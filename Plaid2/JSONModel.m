//
//  JSONModel.m
//  Plaid2
//
//  Created by Matt Larkin on 4/24/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "JSONModel.h"

@implementation JSONModel

-(id) initWithDictionary:(NSMutableDictionary*) jsonObject
{
    if((self = [super init]))
    {
        self = [self init];
        [self setValuesForKeysWithDictionary:jsonObject];
    }
    return self;
}


@end
