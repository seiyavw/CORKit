//
//  NSDate+COR.h
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/04/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (COR)

+ (NSDate *)createDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minite:(NSInteger)minute second:(NSInteger)second;
+ (NSDate *)adjustDate:(NSDate *)date sourceTimeZone:(NSTimeZone *)sourceTimeZone destinationTimeZone:(NSTimeZone *)destinationTimeZone;
+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2;

@end
