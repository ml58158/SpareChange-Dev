//
//  Meta.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "Location.h"

@interface Meta : NSObject
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) Location *location;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end