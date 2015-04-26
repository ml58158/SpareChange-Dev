//
//  SignUpController.m
//  Plaid2
//
//  Created by Matt Larkin on 4/19/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "SignUpViewController.h"
#import <Bolts/Bolts.h>
#import <ParseCrashReporting/ParseCrashReporting.h>
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>
#import "CredentialStore.h"
#import "PlaidHTTPClient.h"


@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}

#pragma mark - Action Buttons



/**
 *  Parse User Creation Button
 *
 *  @param sender Create User Button
 */
- (IBAction)onCreateUserTapped:(UIButton *)sender {
    [self userCreation];

}

/**
 *  Login Redirect Segue
 *
 *  @param sender Already Have Account Button
 */
- (IBAction)onLoginRedirectButtonTapped:(UIButton *)sender
{
[self performSegueWithIdentifier:@"LoginSegue" sender:self];
}

/**
 *  Modal Segue to Login Screen
 */
-(void)loginSegue
{
    [self performSegueWithIdentifier:@"SVCSegue" sender:self];
}

#pragma mark - Helper Methods

/**
 *  Parse User Creation
 */
- (void)userCreation{
    PFUser *user = [PFUser user];
    user.username = self.emailTextField.text;
    user.password = self.passwordTextField.text;

    // other fields can be set just like with PFObject
    //user[@"phone"] = @"415-392-0202";

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"BankSelectSegue" sender:self];
        } else {
            //[self takenAlert];
            NSString *errorString = [error userInfo][@"error"];
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:error.userInfo[@"error"] delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
            [alertView show];
            
            // Show the errorString somewhere and let the user try again.
        }
    }];
}


/**
 *  Alerts User If Email Address / Username Is Taken
 */
- (void)takenAlert {
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"An account already exists with this email address!" delegate: self cancelButtonTitle: nil otherButtonTitles: @"OK",nil, nil];
    [alertView show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (buttonIndex != [alertView cancelButtonIndex])
    {
        [alertView dismissWithClickedButtonIndex:alertView.cancelButtonIndex animated:YES];
    }
}


@end
