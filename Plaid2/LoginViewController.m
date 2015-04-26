//
//  LoginViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/19/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Parse/Parse.h>
@import LocalAuthentication;
#import "LoginViewController.h"
#import "SignUpViewController.h"

#import "CredentialStore.h"
#import "KeychainWrapper.h"

//#import "KeychainItemWrapper.h"

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@property (strong, nonatomic) IBOutlet UIButton *touchIDButton;


@end

//KeychainWrapper *myKeyChainWrapper;


LAContext *context;
NSString *myLocalizedReasonString = @"Used for quick and secure access to the test app";

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.touchIDButton.hidden = true;
    NSError *error;

    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])

        self.touchIDButton.hidden = false;
    }


-(IBAction)onDismissButtonTapped:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  TouchID BioMetrics
 *
 *  @param sender TouchIDButton
 */
- (IBAction)onTouchIDLoginPressed:(UIButton *)sender
{

    [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics localizedReason:myLocalizedReasonString reply:^(BOOL success, NSError *error) {
        if (success) {
            // Authentication Complete
            [self loadAccountSegue];
        } else {
            NSLog(@" BioMetric Authentication Failed");
            //Did not authenticate sucessfully.
        }
    }];
}




#pragma mark - Helper Methods




/**
 *  Reset Password
 *
 *  @param sender forgotPasswordButton
 */
- (IBAction)onForgottenPasswordButtonTapped:(id)sender
{
[self getEmail];

}

/**
 *  Retrieve Email From User Input
 */
- (void)getEmail {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Email Address" message:@"Enter the email for your account:" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex]) {
        UITextField *emailTextField = [alertView textFieldAtIndex:0];
        [self sendEmail:emailTextField.text];
    }
}

/**
 *  Reset Lost Password
 *
 *  @param email user email
 */
- (void)sendEmail:(NSString *)email{
    [PFUser requestPasswordResetForEmailInBackground:email];
}

/**
 *  Triggers Segue into Bank Selection Screen
 */
-(void)loadAccountSegue
{
    [self performSegueWithIdentifier:@"BankChooseSegue" sender:self];
}



/**
 *  Login Button
 *
 *  @param sender Login Button
 */
- (IBAction)onLoginButtonTapped:(UIButton *)sender
{
    [PFUser logInWithUsernameInBackground:self.emailTextField.text password:self.passwordTextField.text
                                    block:^(PFUser *user, NSError *error) {
                                        if (user) {
                                            [self loadAccountSegue];
                                            NSLog(@"Parse Login Success!");
                                            //NSLog(@"Parse Error: %hhu", PFLogLevelError);
                                            } else {
                                            NSLog(@"Parse Error %@", error);
                                        }
                                    }];



}


@end
