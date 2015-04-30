//
//  Transactions.m
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Transactions.h"
#import "Location.h"
#import "Meta.h"
#import "Coordinates.h"

@implementation Transactions

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.pending = dictionary[@"pending"];
        self.amount = [dictionary[@"amount"] integerValue];
        self.categoryId = dictionary[@"category_id"];
        self.date = dictionary[@"date"];
        self.name = dictionary[@"name"];
        self.meta = dictionary[@"meta"];
        self.score = dictionary[@"score"];
        self.type = dictionary[@"type"];
        

    }
    return self;
}






@end
