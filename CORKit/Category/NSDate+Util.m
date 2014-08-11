//
//  NSDate+Util.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/04/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "NSDate+Util.h"

@implementation NSDate (Util)

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

/**
 * helper: compare two date instances by year, month and day.
 */
+ (BOOL)isSameDayWithDate1:(NSDate*)date1 date2:(NSDate*)date2
{
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    
    NSDateComponents* comp1 = [calendar components:unitFlags fromDate:date1];
    [comp1 setTimeZone:[NSTimeZone localTimeZone]];
    NSDateComponents* comp2 = [calendar components:unitFlags fromDate:date2];
    [comp2 setTimeZone:[NSTimeZone localTimeZone]];
    
    return [comp1 day] == [comp2 day] &&
    [comp1 month] == [comp2 month] &&
    [comp1 year]  == [comp2 year];
}

/**
 * modify a date instance with proper local timezone
 */
+ (NSDate *)adjustDate:(NSDate *)date sourceTimeZone:(NSTimeZone *)sourceTimeZone destinationTimeZone:(NSTimeZone *)destinationTimeZone
{
    
    NSInteger sourceGMTOffset = [sourceTimeZone secondsFromGMTForDate:date];
    NSInteger destinationGMTOffset = [destinationTimeZone secondsFromGMTForDate:date];
    NSTimeInterval interval = destinationGMTOffset - sourceGMTOffset;
    
    NSDate *localDate = [[NSDate alloc] initWithTimeInterval:interval sinceDate:date];
    
    return localDate;
}



@end
