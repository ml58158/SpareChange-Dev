//
//  Category.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CategoryId.h"

@protocol  CategoryId

@end

@interface CategoryId : NSObject

@property (strong, nonatomic) NSString *categoryId;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;


@end