//
//  Accounts.m
//  Plaid2
//
//  Created by Matt Larkin on 4/20/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Accounts.h"

@implementation Accounts

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.account = [self.UserAccounts objectForKey:@"_account"];
        self.identifier = [self.UserAccounts objectForKey:@"_id"];
        self.item = [self.UserAccounts objectForKey:@"item"];
        self.user = [self.UserAccounts objectForKey:@"user"];

        self.balance = [self.UserAccounts objectForKey:@"balance"];
        self.available = [self.UserAccounts objectForKey:@"available"];
        self.current= [self.UserAccounts objectForKey:@"current"];


        self.institution_type = [self.UserAccounts objectForKey:@"institution_type"];
        self.meta = [self.UserAccounts objectForKey:@"meta"];
        self.limit = [self.UserAccounts objectForKey:@"limit"];
        self.accountNumber = [self.UserAccounts objectForKey:@"accountNumber"];
        self.name = [self.UserAccounts objectForKey:@"name"];
        self.type = [self.UserAccounts objectForKey:@"type"];
    }
    return self;
}

@end
