//
//  NSDictionary+COR.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/13.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "NSDictionary+COR.h"

@implementation NSDictionary (COR)

- (id)valueReplacingNullWithKey:(NSString *)key
{
    return [self valueReplacingNullWithKey:key defaultValue:nil];
}

- (id)valueReplacingNullWithKey:(NSString *)key defaultValue:(id)defaultValue
{
    id value = self[key];
    if ([value isKindOfClass:[NSNull class]]) {
        
        return defaultValue;
    
    } else {
        
        return value;
    }
}

@end
