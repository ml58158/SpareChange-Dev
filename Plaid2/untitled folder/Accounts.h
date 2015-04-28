//
//  Accounts.h
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PlaidHTTPClient.h"
#import "Balance.h"
#import "meta.h"
#import "Accounts.h"
#import "Transactions.h"
//#import "JSONModel.h"

@protocol Accounts

@end

@interface Accounts : JSONModel

@property (strong, nonatomic) NSString *accessToken;
@property (strong, nonatomic) NSString *identifier;
@property (strong, nonatomic) NSString *institutionType;
@property (strong, nonatomic) NSString *Item;
@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSString *User;
@property (strong, nonatomic) Balance *balance;
@property (strong, nonatomic) Meta *meta;
@property (strong, nonatomic) NSArray<Accounts> *accounts;
@property (strong, nonatomic) NSArray<Transactions> *transactions;
@end
