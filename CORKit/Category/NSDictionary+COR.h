//
//  NSDictionary+COR.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/13.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (COR)

- (id)valueReplacingNullWithKey:(NSString *)key;
- (id)valueReplacingNullWithKey:(NSString *)key defaultValue:(id)defaultValue;

@end
