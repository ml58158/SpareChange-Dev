//
//  AccountViewController.h
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaidHTTPClient.h"
#import "Accounts.h"

@interface AccountViewController : UIViewController

@property NSString *accesstoken;
@property Accounts *accountModel;

@end
