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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/**
 *  Reset Password
 *
 *  @param sender forgotPasswordButton
 */
- (IBAction)onForgottenPasswordButtonTapped:(id)sender
{

[PFUser requestPasswordResetForEmailInBackground:self.emailTextField.text];



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
                                      [self performSegueWithIdentifier:@"AccountSegue" sender:self];
                                        } else {
                                            // The login failed. Check error to see why.
                                        }
                                    }];
}


@end
