//
//  Accounts.m
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Accounts.h"
#import "USAAViewController.h"



@implementation Accounts


- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.account = [self.UserAccounts objectForKey:@"accounts"];
        self.identifier = [self.UserAccounts objectForKey:@"_id"];
        self.item = [self.UserAccounts objectForKey:@"_item"];
        self.user = [self.UserAccounts objectForKey:@"_user"];

        self.balance = [self.UserAccounts objectForKey:@"balance"];
        self.available = [self.UserAccounts objectForKey:@"available"];
        self.current = [self.UserAccounts objectForKey:@"current"];

        self.institution_type = [self.UserAccounts objectForKey:@"institution_type"];
        self.meta = [self.UserAccounts objectForKey:@"meta"];
        self.limit = [self.UserAccounts objectForKey:@"limit"];
        self.accountNumber = [self.UserAccounts objectForKey:@"number"];
    }
        return self;
}

+ (NSArray *)accountInfoFromArray:(NSArray *)incomingArray
{
    NSMutableArray *newArray = [[NSMutableArray alloc] initWithCapacity:incomingArray.count];

    for (NSDictionary *d in incomingArray) {
        Accounts *a = [[Accounts alloc]initWithDictionary:d];
        [newArray addObject:a];

    }
    return newArray;
}


@end