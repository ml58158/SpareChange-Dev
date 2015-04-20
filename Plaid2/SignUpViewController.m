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
#import <ParseUI/ParseUI.h>


@interface SignUpViewController ()

@property (strong, nonatomic) IBOutlet UITextField *emailTextField;

@property (strong, nonatomic) IBOutlet UITextField *passwordTextField;

@end

@implementation SignUpViewController

- (void)viewDidLoad {
    [super viewDidLoad];

}




- (IBAction)onCreateUserTapped:(UIButton *)sender {
    [self userCreation];

}
- (IBAction)onLoginRedirectButtonTapped:(UIButton *)sender
{
[self performSegueWithIdentifier:@"LoginSegue" sender:self];
self.emailTextField.text = @"";
self.passwordTextField.text = @"";


}

- (void)userCreation{
    PFUser *user = [PFUser user];
    user.username = self.emailTextField.text;
    user.password = self.passwordTextField.text;

    // other fields can be set just like with PFObject
    user[@"phone"] = @"415-392-0202";

    [user signUpInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (!error) {
            [self performSegueWithIdentifier:@"AccountSetupSegue" sender:self];
        } else {
            [self takenAlert];
            NSString *errorString = [error userInfo][@"error"];
            
            // Show the errorString somewhere and let the user try again.
        }
    }];
}

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
