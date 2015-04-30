//
//  Balance.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Balance : NSObject
@property (nonatomic) double available;
@property (nonatomic) double current;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end