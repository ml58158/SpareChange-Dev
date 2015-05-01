//
//  TransactionViewController.h
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PlaidHTTPClient.h"
#import "Accounts.h"

@interface TransactionViewController : UIViewController

@property PlaidHTTPClient *client;
@property Accounts *id;
@property NSArray *transactions;

@property (strong, nonatomic) NSDictionary *accountDict;

@property NSString *accesstoken;
@property Accounts *accountModel;
@property Balance *balanceModel;

@end
