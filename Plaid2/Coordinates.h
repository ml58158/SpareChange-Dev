//
//  Coordinates.h
//  Plaid2
//
//  Created by Matt Larkin on 4/30/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Meta.h"
#import "Location.h"

@protocol coordinates <NSObject>

@end


@interface Coordinates : NSObject

@property (strong, nonatomic) NSString *lat;
@property (strong, nonatomic) NSString *lon;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
