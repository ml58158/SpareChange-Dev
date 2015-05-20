//
//  ViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/16/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "USAAViewController.h"
#import "MFAViewController.h"
#import "AccountViewController.h"
#import "TransactionViewController.h"

#import "PlaidHTTPClient.h"
#import "AFNetworking.h"
#import "SSKeychain.h"

#define kaccess_token @"accesstoken"
#define kinstitution_type @"usaa"
#define kemail @""



@interface USAAViewController ()

/**
 *  User Login Properties
 */
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *pinTextField;

/**
 *  MFA Response Properties
 */
@property (strong, nonatomic) IBOutlet UITextField *responseTextField;
@property (strong, nonatomic) IBOutlet UIButton *mfaSubmitButton;

/**
 *  User Created Properties
 */
@property PlaidHTTPClient *client;
@property NSString *accessToken;
@property NSString *institution;
@property NSDictionary *userAccounts;
@property Accounts *account;


@end

@implementation USAAViewController


- (void)viewDidLoad {
    [super viewDidLoad];

    }

/**
 *  Adds User Button
 *
 *  @param sender addUserButton
 */
- (IBAction)addUserOnTap:(UIButton *)sender {

    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    NSString *pin = self.pinTextField.text;
    self.institution = kinstitution_type;

    self.client = [PlaidHTTPClient sharedPlaidHTTPClient];

    /**
     *  Add User To Plaid Backend
     *
     *  @param responseCode 200/201/401
     *  @param userAccounts dictionary
     *
     *  @return Account Data
     */
    [self.client loginToInstitution:kinstitution_type userName:username password:password pin:pin email:kemail withCompletionHandler:^(NSInteger responseCode, NSDictionary *userAccounts) {

        /**
         *  Saves Password in Keychain
         */
        [SSKeychain setPassword:password forService:@"Plaid" account:@"com.mal.plaid2"];

        /**
         *  Gets Access Token
         */
        self.accessToken = userAccounts[@"access_token"];
        self.account = [[Accounts alloc] initWithDictionary:userAccounts[@"accounts"][0]];
        NSLog(@"Account id: %@", self.account.id);


        self.accessToken = userAccounts[@"access_token"];
        NSArray *mfa = userAccounts[@"mfa"];
        NSDictionary *question = mfa[0];

        self.responseTextField.placeholder = question[@"question"];
        
        self.userAccounts = userAccounts;



        /**
         *  Loops Authentication based on MFA Responses
         */
        if (responseCode == 201) {
            self.responseTextField.text = @"";
            self.responseTextField.placeholder = question[@"question"];
        }
        else if (responseCode == 200) {
            // NSLog(@"MFA SUBMIT RESPONSE DICTIONARY == %@", userAccounts);


            [self performSegueWithIdentifier:@"AccountSelectSegue" sender:self];
            
        }
    }];

    /**
     *  Clears TextFields
     */
   self.usernameTextField.text = @"";
   self.passwordTextField.text = @"";
   self.pinTextField.text =@"";


}



- (IBAction)onMFASubmit:(id)sender {

    [self.client submitMFAResponse:self.responseTextField.text institution:self.institution accessToken:self.accessToken withCompletionHandler:^(NSInteger responseCode, NSDictionary *userAccounts1) {

        self.accessToken = userAccounts1[@"access_token"];
        NSArray *mfa = userAccounts1[@"mfa"];
        NSDictionary *question = mfa[0];

        /**
         *  Loops Authentication based on MFA Responses
         */
        if (responseCode == 201) {
            self.responseTextField.text = @"";
            self.responseTextField.placeholder = question[@"question"];
        }
        else if (responseCode == 200) {
          [self performSegueWithIdentifier:@"TransactionSegue" sender:self];
        }
    }];

}


/**
 *  Cancels AlertView
 *
 *  @param alertView   UIAlertView
 *  @param buttonIndex cancelButton
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
    }
}

/**
 *  Passes Data to AccountSelectionViewController
 *
 *  @param segue  AccountSelectionViewController
 *  @param sender WellsViewController
 */
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AccountSelectSegue"]) {
        AccountViewController *vc = segue.destinationViewController;
        vc.accesstoken = self.accessToken;
        vc.accountModel = self.account;
    }

}


@end
