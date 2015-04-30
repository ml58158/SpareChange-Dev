//
//  Meta.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "JSONModel.h"
#import "Location.h"

@interface Meta : JSONModel
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *number;
@property (strong, nonatomic) Location *location;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end