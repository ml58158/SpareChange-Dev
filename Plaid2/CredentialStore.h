//
//  CredentialStore.h
//  Plaid2
//
//  Created by Matt Larkin on 4/23/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CredentialStore : NSObject

+ (void)saveKey:(NSString *)key withValue:(NSString *)value;

+ (NSString *)getValueWithKey:(NSString *)key;

@end
