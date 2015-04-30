//
//  Location.m
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Location.h"

@implementation Location

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.meta.Location.city = [dictionary[@"meta"][@"location"][@"city"]];
        self.meta.location.state = [dictionary[@"meta"][@"location"][@"state"]];
    }
    return self;
}


@end


