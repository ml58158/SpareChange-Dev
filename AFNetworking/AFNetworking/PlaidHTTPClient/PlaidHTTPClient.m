//
//  PlaidHTTPClient.m
//  EnvelopeBudget
//
//  Created by Nate on 5/29/14.
//  Copyright (c) 2014 Nate. All rights reserved.
//

#import "PlaidHTTPClient.h"
#import "USAAViewController.h"
#import "AccountViewController.h"
#import "TransactionViewController.h"
#import "CredentialStore.h"
#import "Accounts.h"
#import "Transactions.h"

#define kaccesstoken @"access_token"

@interface PlaidHTTPClient ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;
@property Accounts *accountModel;
@property Transactions *transactionsModel;
@property Balance *balance;

@property NSArray *account;
@property NSArray *transaction;

@property AccountViewController *accountViewController;
@property TransactionViewController *transactionViewController;

@end



@implementation PlaidHTTPClient

#pragma mark - Setters & Getters

- (NSDateFormatter *)dateFormatter
{
    if (!_dateFormatter)
    {
        _dateFormatter = [NSDateFormatter new];
        [_dateFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"en_US_PSIX"]];
        [_dateFormatter setDateFormat: @"yyy-MM-dd"];
    }
    return _dateFormatter;
}


#pragma mark - Public Class Methods

+ (PlaidHTTPClient *)sharedPlaidHTTPClient;
{
    static PlaidHTTPClient *_sharedPlaidHTTPClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^
                              {
                                  _sharedPlaidHTTPClient = [[self alloc] initWithBaseURL: [NSURL URLWithString: kPlaidBaseURL]];
                              });
    return _sharedPlaidHTTPClient;
}



#pragma mark - Public Instance Methods

- (void) downloadPlaidInstitutionsWithCompletionHandler: (void(^)(NSArray * institutions))handler
{
    [self GET: @"/institutions"
   parameters: nil
      success: ^(NSURLSessionDataTask *task, id responseObject)
               {
                   NSArray *sortedInstitutions = [(NSArray *)responseObject sortedArrayUsingDescriptors: @[[[NSSortDescriptor alloc] initWithKey: @"name"
                ascending: YES]]];
                   handler(sortedInstitutions);
               }
      failure: ^(NSURLSessionDataTask *task, NSError *error)
               {
                   NSLog(@"Failed to retrieve Plaid institutions: %@", error.localizedDescription);
               }];
}


/**
 *  Add User to Plaid System
 *
 *  @param institutionType <#institutionType description#>
 *  @param userName        <#userName description#>
 *  @param password        <#password description#>
 *  @param pin             <#pin description#>
 *  @param email           <#email description#>
 *  @param handler         <#handler description#>
 */
- (void) loginToInstitution: (NSString *)institutionType
                   userName: (NSString *)userName
                   password: (NSString *)password
                        pin: (NSString *)pin
                      email: (NSString *)email
      withCompletionHandler: (void(^)(NSInteger responseCode, NSDictionary *userAccounts))handler
{
    NSDictionary *credentials     = @{@"username": userName,
                                      @"password": password,
                                      @"pin"     : pin};
    
    NSDictionary *logInParameters = @{@"client_id"  : kClientID,
                                      @"secret"     : kSecret,
                                      @"credentials": credentials,
                                      @"type"       : institutionType,
                                      @"email"      : email};
    
    [self POST: @"/auth"
    parameters: logInParameters
       success: ^(NSURLSessionDataTask *task, id responseObject)
                {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    
                    handler(response.statusCode, responseObject);

                    self.accountModel = (Accounts *)responseObject;
                    self.transactionsModel = (Transactions *)responseObject;

                    self.account = [Accounts arrayOfModelsFromData:responseObject error:nil];
                    self.transaction = [Transactions arrayOfModelsFromData:responseObject error:nil];

                    NSString *accessToken = responseObject[@"access_token"];
                    // NSLog(@"Success Account: %@", self.accountModel);
                   // NSLog(@"Success Transaction: %@", self.transactionsModel);

                     // NSLog(@"Access Token %@", self.accountModel.accessToken);
                    NSLog(@"Access token string %@", accessToken);


                    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"accesstoken"])
                    {
                        [CredentialStore saveKey:@"accessToken" withValue:responseObject[@"access_token"]];
                        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"access_token"];
                        
                    }
                    else if ([[NSUserDefaults standardUserDefaults] boolForKey:@"accesstoken"])
                    {
                        [CredentialStore getValueWithKey:@"accessToken"];
                    }
                   NSLog(@"NSDefault Dump %@", [[NSUserDefaults standardUserDefaults] dictionaryRepresentation]);
                    
                }
       failure: ^(NSURLSessionDataTask *task, NSError *error)
                {
                    NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
                    NSLog(@"Unable to login into account with response code : %ld.  Error: %@", (long)response.statusCode, error.localizedDescription);

                    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Address" message:[NSString stringWithFormat:@"%ld", (long)response.statusCode] delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
                    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
                    
                    handler(response.statusCode, nil);
                }];
            }


- (void)submitMFAResponse: (NSString *)mfaResponse
               institution: (NSString *)institutionType
               accessToken: (NSString *)accessToken

     withCompletionHandler: (void(^)(NSInteger responseCode, NSDictionary *userAccounts))handler
{
    NSDictionary *mfaParameters = @{@"client_id"    : kClientID,
                                    @"secret"       : kSecret,
                                    @"mfa"          : mfaResponse,
                                    @"access_token" : accessToken,
                                    @"type"         : institutionType};



  //  NSDictionary *mfaQuestionDict = [mfaParameters objectForKey:@"questions"];

    [self POST: @"/auth/step"
    parameters: mfaParameters
       success: ^(NSURLSessionDataTask *task, id responseObject)
     {
         NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
         
         handler(response.statusCode, responseObject);
     }
       failure: ^(NSURLSessionDataTask *task, NSError *error)
     {
         NSHTTPURLResponse *response = (NSHTTPURLResponse *)task.response;
         NSLog(@"Unable to login into account with response code : %ld.  Error: %@", (long)response.statusCode, error.localizedDescription);
         
         handler(response.statusCode, nil);
     }];
}



- (void) downloadTransactionsForAccessToken: (NSString *)accessToken
                                    pending: (BOOL) isPending
                                    account: (NSString *)accountID
                           sinceTransaction: (NSString *)transactionID
                                        gte: (NSDate *)fromDate
                                        lte: (NSDate *)toDate
                                    success: (void(^)(NSURLSessionDataTask *task, NSArray * transactions))success
                                    failure: (void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSMutableDictionary *options = [NSMutableDictionary new];
    
    options[@"pending"] = [NSString stringWithFormat: (isPending ? @"true" : @"false")];
    
    if (accountID)
    {
        options[@"account"] = accountID;
    }
    
    if (transactionID)
    {
        options[@"last"] = transactionID;
    }
    
    if (fromDate)
    {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        
        [dateFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"en_US_PSIX"]];
        [dateFormatter setDateFormat: @"yyy-MM-dd"];
        
        options[@"gte"] = [dateFormatter stringFromDate: fromDate];
    }
    
    if (toDate)
    {
        NSDateFormatter *dateFormatter = [NSDateFormatter new];
        
        [dateFormatter setLocale: [NSLocale localeWithLocaleIdentifier: @"en_US_PSIX"]];
        [dateFormatter setDateFormat: @"yyy-MM-dd"];
        
        options[@"lte"] = [dateFormatter stringFromDate: toDate];
    }
    
    NSDictionary *downloadCredentials = @{
                                         @"client_id"     : kClientID,
                                         @"secret"        : kSecret,
                                         @"access_token"  : accessToken,
                                         @"options"       : options
                                         };

    [self GET: @"/connect"
   parameters: downloadCredentials
      success: ^(NSURLSessionDataTask *task, id responseObject)
     {
         NSLog(@"ResponseObject == %@", responseObject);
         self.accountModel = (Accounts *)responseObject;
         self.transactionsModel = (Transactions *)responseObject;

         self.account = [Accounts arrayOfModelsFromData:responseObject error:nil];
         self.transaction = [Transactions arrayOfModelsFromData:responseObject error:nil];
         self.balance = [Balance arrayOfModelsFromData:responseObject error:nil];

         [CredentialStore getValueWithKey:self.accountModel.accessToken];

         NSArray *transactionsArray = (NSArray *)responseObject[@"transactions"];
         success(task, transactionsArray);
         transactionsArray = [Transactions arrayOfModelsFromData:responseObject error:nil];
         NSLog(@"credentials: %@ %@ %@", kClientID, kSecret, accessToken);
     }
      failure: ^(NSURLSessionDataTask *task, NSError *error)
     {
         failure(task, error);
     }];
}



- (void)downloadAccountDetailsForAccessToken: (NSString *)accessToken

                                     account: (NSString *)accountID
                                     success: (void(^)(NSURLSessionDataTask *task, NSDictionary *accountDetails))success
                                     failure: (void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSDictionary *options             = @{
                                          @"account" : accountID
                                          };
    NSDictionary *downloadCredentials = @{
                                          @"client_id": kClientID,
                                          @"secret"   : kSecret,
                                          @"access_token" : accessToken,
                                          @"options"      : options
                                          };
    
    [self GET: @"/connect"
   parameters: downloadCredentials
      success: ^(NSURLSessionDataTask *task, id responseObject)
               {
                   NSDictionary *accountDictonary = (NSDictionary *)responseObject[@"accounts"][0];
                   success(task, accountDictonary);

                   [CredentialStore getValueWithKey:self.accountModel.accessToken];

                   self.accountModel = (Accounts *)responseObject;
                   self.transactionsModel = (Transactions *)responseObject;

                   NSLog(@"Success: %@", self.accountModel);
                   NSLog(@"Success: %@", self.transactionsModel);

//                   NSLog(@"Credientials dictionary test: %@ %@",downloadCredentials[@"access_token"], downloadCredentials[accessToken]);
                  NSLog(@"Credentials: %@", accountDictonary[@"access_token"]);
                  NSLog(@"Account Dictionary == %@", accountDictonary);
               }
      failure: ^(NSURLSessionDataTask *task, NSError *error)
               {
                   failure(task, error);
               }];
}

- (void)UpdateCredentialsWithAccessToken: (NSString *)accessToken
                                userName: (NSString *)userName
                                password: (NSString *)password
                                     pin: (NSString *)pin
                                   email: (NSString *)email
                                     account: (NSString *)accountID
                                     success: (void(^)(NSURLSessionDataTask *task, NSDictionary *accountDetails))success
                                     failure: (void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    NSDictionary *options             = @{
                                          @"account" : accountID
                                          };
    NSDictionary *downloadCredentials = @{
                                          @"client_id": kClientID,
                                          @"secret"   : kSecret,
                                          @"access_token" : self.accountModel.accessToken,
                                          @"options"      : options
                                          };

    [self GET: @"/connect"
   parameters: downloadCredentials
      success: ^(NSURLSessionDataTask *task, id responseObject)
     {
         NSDictionary *accountDictonary = (NSDictionary *)responseObject[@"accounts"][0];
         success(task, accountDictonary);
         NSLog(@"Credientials dictionary test: %@ %@",downloadCredentials[@"access_token"], downloadCredentials[accessToken]);
         NSLog(@"Credentials: %@", accountDictonary[@"access_token"]);
     }
      failure: ^(NSURLSessionDataTask *task, NSError *error)
     {
         failure(task, error);
     }];
}


- (void)downloadPlaidEntity: (NSString *)entityID
                    success: (void(^)(NSURLSessionDataTask *task, id plaidEntity))success
                    failure: (void(^)(NSURLSessionDataTask *task, NSError *error))failure
{
    [self GET: [NSString stringWithFormat: @"/entities/%@", entityID]
   parameters: nil
      success: ^(NSURLSessionDataTask *task, id responseObject)
               {
                   success(task, responseObject);
               }
      failure: ^(NSURLSessionDataTask *task, NSError *error)
               {
                   failure(task, error);
               }];
}


#pragma mark - Private Methods

- (instancetype)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL: url];
    
    if (self)
    {
        self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer  = [AFJSONRequestSerializer serializer];
    }
    return self;
}


@end
