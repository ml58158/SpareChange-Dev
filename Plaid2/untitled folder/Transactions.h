//
//  Transactions.h
//  Plaid2
//
//  Created by Matt Larkin on 4/17/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//
#import "Accounts.h"
#import <Foundation/Foundation.h>

@interface Transactions : NSObject

@property NSDictionary *accountDetails;

@property (nonatomic, retain) NSNumber* transactions;// Header

@property (nonatomic, retain) NSString* account;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSNumber* amount;
@property (nonatomic, retain) NSString* date;

@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSNumber* available;
@property (nonatomic, retain) NSString* meta; //Key

@property (nonatomic, retain) NSString* coordinates; //Key
@property (nonatomic, retain) NSString* lat;
@property (nonatomic, retain) NSString* lon;
@property (nonatomic, retain) NSString* state;
@property (nonatomic, retain) NSString* city;
@property (nonatomic, retain) NSString* address;

//@property (strong, nonatomic) NSArray<Accounts, Optional>* tags;




@end
