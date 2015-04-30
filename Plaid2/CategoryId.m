//
//  Category.m
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "CategoryId.h"

@implementation CategoryId

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{

    self = [super init];
    if (self) {

        self.categoryId = dictionary[@"category_id"];
    }
    return self;
}

@end
