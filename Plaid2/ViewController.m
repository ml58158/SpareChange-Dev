//
//  ViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/16/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "ViewController.h"
#import "MFAViewController.h"
#import "AccountViewController.h"
#import "TransactionViewController.h"
#import "PlaidHTTPClient.h"
#import "AFNetworking.h"

#define kaccess_token @"accesstoken"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *usernameTextField;
@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;
@property (strong, nonatomic) IBOutlet UITextField *pinTextField;
@property (strong, nonatomic) IBOutlet UITextField *typeTextField;
@property (strong, nonatomic) IBOutlet UITextField *emailTextField;
//@property (strong, nonatomic) IBOutlet UITextField *webhookTextField;
@property (strong, nonatomic) IBOutlet UILabel *mfaQuestionLabel;
@property (strong, nonatomic) IBOutlet UITextField *responseTextField;
@property (strong, nonatomic) IBOutlet UIButton *mfaSubmitButton;

@property PlaidHTTPClient *client;
@property NSString *accessToken;
@property NSString *institution;
@property NSDictionary *userAccounts;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   // PlaidHTTPClient *client = [PlaidHTTPClient sharedPlaidHTTPClient];
    }


- (IBAction)addUserOnTap:(UIButton *)sender {

   // MFAViewController *mvc = [[MFAViewController alloc]init];

    NSString *username = self.usernameTextField.text;
    NSString *password = self.passwordTextField.text;
    self.institution = self.typeTextField.text;
    NSString *email = self.emailTextField.text;
    NSString *pin = self.pinTextField.text;
   // NSString *webhook = self.webhookTextField.text;
    NSString *MFAResponse = self.responseTextField.text;



    self.client = [PlaidHTTPClient sharedPlaidHTTPClient];

    [self.client loginToInstitution:self.institution userName:username password:password pin:pin email:email withCompletionHandler:^(NSInteger responseCode, NSDictionary *userAccounts) {
        NSLog(@"%@", userAccounts);

        self.accessToken = userAccounts[@"access_token"];
        NSArray *mfa = userAccounts[@"mfa"];
        NSDictionary *question = mfa[0];

//        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
//        [defaults setObject:self.accessToken forKey:kaccess_token];
//        [defaults synchronize];

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

    }];
    /**
     *  Clears TextFields
     */
   self.usernameTextField.text = @"";
   self.passwordTextField.text = @"";
   self.typeTextField.text = @"";
   self.emailTextField.text =@"";
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

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    TransactionViewController *tvc = segue.destinationViewController;
    //tvc.transactions = [self.userAccounts.]
}

@end
