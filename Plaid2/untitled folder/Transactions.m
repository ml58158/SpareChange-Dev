//
//  Transactions.m
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Transactions.h"
#import "TransactionViewController.h"
#import "Accounts.h"
#import "USAAViewController.h"

@implementation Transactions



- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.account = [self.accountDetails objectForKey:@"_account"];
        self.id = [self.accountDetails objectForKey:@"_id"];
        self.amount = [self.accountDetails objectForKey:@"amount"];
        self.date = [self.accountDetails objectForKey:@"date"];

        self.name = [self.accountDetails objectForKey:@"name"];
        self.available = [self.accountDetails objectForKey:@"available"];

        self.meta = [self.accountDetails objectForKey:@"meta"];

        self.coordinates = [self.accountDetails objectForKey:@"coordinates"];
        self.lat = [self.accountDetails objectForKey:@"lat"];
        self.lon = [self.accountDetails objectForKey:@"lon"];
        self.state = [self.accountDetails objectForKey:@"state"];
        self.city = [self.accountDetails objectForKey:@"city"];
        self.address = [self.accountDetails objectForKey:@"address"];

    }
    return self;
}



@end
