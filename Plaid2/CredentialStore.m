//
//  CredentialStore.m
//  Plaid2
//
//  Created by Matt Larkin on 4/23/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import "CredentialStore.h"

@implementation CredentialStore

+ (void)saveKey:(NSString *)key withValue:(NSString *)value {
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
[defaults setObject:value forKey:[key lowercaseString]];
[defaults synchronize];
}

+ (NSString *)getValueWithKey:(NSString *)key {
NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
return [defaults objectForKey:[key lowercaseString]];
}

@end
