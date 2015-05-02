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
#import "KeychainWrapper.h"

#define kaccess_token @"accesstoken"
#define kinstitution_type @"usaa"
#define kemail @""

@interface USAAViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *pinTextField;

@property (strong, nonatomic) IBOutlet UILabel *mfaQuestionLabel;
@property (strong, nonatomic) IBOutlet UITextField *responseTextField;
@property (strong, nonatomic) IBOutlet UIButton *mfaSubmitButton;

@property PlaidHTTPClient *client;
@property NSString *accessToken;
@property NSString *institution;
@property NSDictionary *userAccounts;

@end

@implementation USAAViewController

KeychainWrapper *myKeyChainWrapper;

- (void)viewDidLoad {
    [super viewDidLoad];

    }


- (IBAction)addUserOnTap:(UIButton *)sender {

   // MFAViewController *mvc = [[MFAViewController alloc]init];

    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    self.institution = kinstitution_type;
    NSString *pin = self.pinTextField.text;
//    NSString *MFAResponse = self.responseTextField.text;



    self.client = [PlaidHTTPClient sharedPlaidHTTPClient];

    [self.client loginToInstitution:kinstitution_type userName:username password:password pin:pin email:kemail withCompletionHandler:^(NSInteger responseCode, NSDictionary *userAccounts) {
        NSLog(@"%@", userAccounts);

        self.accessToken = userAccounts[@"access_token"];
        NSArray *mfa = userAccounts[@"mfa"];
        NSDictionary *question = mfa[0];


        NSLog(@"access_token == %@", self.accessToken);
        NSLog(@"question == %@", question[@"question"]);
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
            NSLog(@"MFA SUBMIT RESPONSE DICTIONARY == %@", userAccounts);
            [self performSegueWithIdentifier:@"TransactionSegue" sender:self];
        }
        else if (responseCode == 401) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:[NSString stringWithFormat:@"%li",(long)responseCode] delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alertView show];
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
        NSLog(@"MFA SUBMIT RESPONSE DICTIONARY == %@", userAccounts1);
          [self performSegueWithIdentifier:@"TransactionSegue" sender:self];
        }
    }];

}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
    }
}




@end
