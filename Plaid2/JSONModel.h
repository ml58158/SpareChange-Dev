//
//  JSONModel.h
//  Plaid2
//
//  Created by Matt Larkin on 4/24/15.
//  Copyright (c) 2015 Matt Larkin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JSONModel : NSObject <NSCopying, NSMutableCopying>

-(id) initWithDictionary:(NSMutableDictionary*) jsonDictionary;

@end
