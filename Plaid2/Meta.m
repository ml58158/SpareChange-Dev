//
//  Meta.m
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Meta.h"

@implementation Meta

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.name = dictionary[@"name"];
        self.number =dictionary[@"number"];
        self.location = dictionary[@"location"];
    }
    return self;
}

@end
