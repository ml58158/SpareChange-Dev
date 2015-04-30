//
//  Accounts.m
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Accounts.h"
#import "USAAViewController.h"
#import "PlaidHTTPClient.h"
#import "Balance.h"
//#import "JSONModel.h"



@implementation Accounts

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.id = dictionary[@"_id"];
        self.Item = dictionary[@"_item"];
        self.User = dictionary[@"_user"];
        self.balance.available = [dictionary[@"balance"][@"available"] doubleValue];
        self.balance.current = [dictionary[@"balance"][@"current"] doubleValue];
        self.institutionType = dictionary[@"institution_type"];
        self.meta.name = dictionary[@"meta"][@"name"];
        self.meta.number = dictionary[@"meta"][@"number"];
        self.type = dictionary[@"type"];
    }
    return self;
}

@end


