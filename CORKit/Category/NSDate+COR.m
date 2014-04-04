//
//  NSDate+COR.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/04/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "NSDate+COR.h"

@implementation NSDate (COR)

+ (NSDate *)createDateWithYear:(NSInteger)year month:(NSInteger)month day:(NSInteger)day hour:(NSInteger)hour minite:(NSInteger)minute second:(NSInteger)second
{
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    components.year = year;
    components.month = month;
    components.day = day;
    components.hour = hour;
    components.minute = minute;
    components.second = second;
    NSDate* date = [calendar dateFromComponents:components];
    
    return date;
}

@end
