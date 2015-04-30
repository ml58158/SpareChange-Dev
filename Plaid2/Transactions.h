//
//  Transactions.h
//  Plaid2
//
//  Created by Matt Larkin on 4/25/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

//#import "JSONModel.h"
#import "Meta.h"
#import "Score.h"
#import "Type.h"
#import "CategoryId.h"
#import "PlaidHTTPClient.h"
#import <Foundation/Foundation.h>
@protocol Transactions

@end


@interface Transactions : NSObject
@property (nonatomic) BOOL pending;
@property (nonatomic) NSInteger amount;
@property (strong, nonatomic) NSString *Account;
@property (strong, nonatomic) NSString *categoryId;
@property (strong, nonatomic) NSString *date;
@property (strong, nonatomic) NSString *id;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) Meta *meta;
@property (strong, nonatomic) Score *score;
@property (strong, nonatomic) Type *type;
@property (strong, nonatomic) NSArray<CategoryId> *category;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;
@end