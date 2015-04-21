//
//  LoginViewController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/19/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "LoginViewController.h"
#import "SignUpViewController.h"
#import <Parse/Parse.h>

@interface LoginViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation LoginViewController

-(void)viewDidAppear:(BOOL)animated {
}

-(IBAction)onDismissButtonTapped:(UIButton *)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


/**
 *  Reset Password
 *
 *  @param sender forgotPasswordButton
 */
- (IBAction)onForgottenPasswordButtonTapped:(id)sender
{
[self getEmail];

}

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

- (void)sendEmail:(NSString *)email{
    [PFUser requestPasswordResetForEmailInBackground:email];
}

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
                                            NSLog(@"%hhu", PFLogLevelError);
                                            } else {
                                            NSLog(@"%@", error);
                                        }
                                    }];
}


@end
