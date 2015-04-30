//
//  Location.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Location : NSObject
@property (strong, nonatomic) NSString *city;
@property (strong, nonatomic) NSString *state;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end


