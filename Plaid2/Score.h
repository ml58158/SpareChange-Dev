//
//  Score.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"

@interface Score : NSObject
@property (nonatomic) NSString* name;
@property (strong, nonatomic) Location *location;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
