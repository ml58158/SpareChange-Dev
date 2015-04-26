//
//  Score.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "JSONModel.h"
#import "Location.h"

@interface Score : JSONModel
@property (nonatomic) NSInteger name;
@property (strong, nonatomic) Location *location;
@end
