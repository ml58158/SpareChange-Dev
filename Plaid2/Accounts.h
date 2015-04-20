//
//  Accounts.h
//  Plaid2
//
//  Created by Matt Larkin on 4/19/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "JSONModel.h"
#import "Transactions.h"

@interface Accounts : JSONModel

@property NSDictionary *UserAccounts;


@property (nonatomic, retain) NSNumber* account;
@property (nonatomic, retain) NSString* id;
@property (nonatomic, retain) NSNumber* item;
@property (nonatomic, retain) NSNumber* user;

@property (nonatomic, retain) NSNumber* balance;
@property (nonatomic, retain) NSNumber* available;
@property (nonatomic, retain) NSNumber* current;

@property (nonatomic, retain) NSString* institution_type;
@property (nonatomic, retain) NSString* meta;
@property (nonatomic, retain) NSNumber* limit;
@property (nonatomic, retain) NSNumber* accountNumber;
@property (nonatomic, retain) NSString* name;
@property (nonatomic, retain) NSString* type;



@end
