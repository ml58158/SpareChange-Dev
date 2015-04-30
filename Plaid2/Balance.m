//
//  Balance.m
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Balance.h"

@implementation Balance

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.available = [dictionary[@"available"] doubleValue];
        self.current = [dictionary[@"current"] doubleValue];
    }
    return self;
}

@end
