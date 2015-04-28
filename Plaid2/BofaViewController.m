//
//  BofaViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "BofaViewController.h"
#import "MFAViewController.h"
#import "AccountViewController.h"
#import "TransactionViewController.h"
#import "PlaidHTTPClient.h"
#import "AFNetworking.h"

#define kaccess_token @"accesstoken"

// Defines bank as Bank of America
#define kinstitution_type @"bofa"

@interface BofaViewController ()



@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UILabel *mfaQuestionLabel;
@property (strong, nonatomic) IBOutlet UITextField *responseTextField;
@property (strong, nonatomic) IBOutlet UIButton *mfaSubmitButton;

@property PlaidHTTPClient *client;
@property NSString *accessToken;
@property NSString *institution;
@property NSDictionary *userAccounts;

@end

@implementation BofaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    // PlaidHTTPClient *client = [PlaidHTTPClient sharedPlaidHTTPClient];
}

# pragma mark - Action Buttons

- (IBAction)addUserOnTap:(UIButton *)sender {

    // MFAViewController *mvc = [[MFAViewController alloc]init];

    /**
     *  Assigns variables to User TextFields
     */
    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *MFAResponse = self.responseTextField.text;


    /**
     *  Initates Singleton
     */
    self.client = [PlaidHTTPClient sharedPlaidHTTPClient];


    /**
     *  Provides Interface to log into Bank Account
     *
     *  @param responseCode Success/Fail
     *  @param userAccounts accessToken and Account Information
     *
     *  @return Access Token and account information
     */
    [self.client loginToInstitution:kinstitution_type userName:username password:password pin:nil email:nil withCompletionHandler:^(NSInteger responseCode, NSDictionary *userAccounts) {
       // NSLog(@"%@", userAccounts);

        self.accessToken = userAccounts[@"access_token"];
        NSArray *mfa = userAccounts[@"mfa"];
        NSDictionary *question = mfa[0];

        //        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        //        [defaults setObject:self.accessToken forKey:kaccess_token];
        //        [defaults synchronize];

       // NSLog(@"access_token == %@", self.accessToken);
       // NSLog(@"question == %@", question[@"question"]);
        self.responseTextField.placeholder = question[@"question"];

        self.userAccounts = userAccounts;

        /**
         *  Loops Authentication based on MFA Responses
         */
        if (responseCode == 201) { //Requires additional authentication to generate POST
            self.responseTextField.text = @"";
            self.responseTextField.placeholder = question[@"question"];
        }
        else if (responseCode == 200) { // User authenticated correctly
          //  NSLog(@"MFA SUBMIT RESPONSE DICTIONARY == %@", userAccounts);
            [self performSegueWithIdentifier:@"TransactionSegue" sender:self];
        }

    }];
    /**
     *  Clears TextFields
     */
    self.usernameTextField.text = @"";
    self.passwordTextField.text = @"";
   // self.emailTextField.text =@"";



}

/**
 *  Multi-Form Authentication Submission
 *
 *  @param sender MFASubmit Button
 */

- (IBAction)onMFASubmit:(id)sender {

    [self.client submitMFAResponse:self.responseTextField.text institution:self.institution accessToken:self.accessToken withCompletionHandler:^(NSInteger responseCode, NSDictionary *userAccounts1) {

        self.accessToken = userAccounts1[@"access_token"];
        NSArray *mfa = userAccounts1[@"mfa"];
        NSDictionary *question = mfa[0];

        /**
         *  Loops Authentication based on MFA Responses
         *  Allows for multiple questions if needed
         */
        if (responseCode == 201) { // User needs additonal authentication before POST
            self.responseTextField.text = @"";
            self.responseTextField.placeholder = question[@"question"];
        }
        else if (responseCode == 200) {
         //   NSLog(@"MFA SUBMIT RESPONSE DICTIONARY == %@", userAccounts1);
            [self performSegueWithIdentifier:@"TransactionSegue" sender:self];
        }
    }];

}

/**
 *  Transition to TransactionViewController
 *
 *  @param segue  Bofa VC
 *  @param sender Transaction VC
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TransactionViewController *tvc = segue.destinationViewController;
    //tvc.transactions = [self.userAccounts.]
}



@end
