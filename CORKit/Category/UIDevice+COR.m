//
//  UIDevice+COR.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "UIDevice+COR.h"

@implementation UIDevice (COR)

+ (BOOL)is4inch
{
    if([[UIScreen mainScreen] bounds].size.height >= 568.0f) {
        
        return YES;
    }
    
    return NO;
}

+ (BOOL)isIOS7Later
{
    if([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0) {
        
        return YES;
    }
    
    return NO;
}

@end
