//
//  Type.m
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Type.h"

@implementation Type

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        self.primary = dictionary[@"primary"];
    }
    return self;
}


@end
