//
//  Balance.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "JSONModel.h"

@interface Balance : JSONModel
@property (nonatomic) double available;
@property (nonatomic) double current;
@end