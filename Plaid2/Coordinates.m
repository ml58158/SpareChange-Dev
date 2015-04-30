//
//  Coordinates.m
//  Plaid2
//
//  Created by Matt Larkin on 4/30/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "Coordinates.h"
#import "Meta.h"
#import "Location.h"

@implementation Coordinates

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{

    self = [super init];
    if (self) {

     //   self.meta.Location.lat = [dictionary[@"meta"][@"location"][@"lat"]];
      //  self.meta.Location.lon = [dictionary[@"meta"][@"location"][@"lon"]];
    }
    return self;
}

@end
