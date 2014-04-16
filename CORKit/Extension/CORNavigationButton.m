//
//  CORNavigationButton.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORNavigationButton.h"
#import "UIDevice+COR.h"

@implementation CORNavigationButton
{
    BOOL _isLeftItem;
}

CGFloat const kNavigationMarginSize = 9.0f;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setIsLeftItem:(BOOL)isLeftItem
{
    _isLeftItem = isLeftItem;
}

- (UIEdgeInsets)alignmentRectInsets
{
    if ([UIDevice isIOS7Later]) {
        
        UIEdgeInsets insets;
        if (_isLeftItem) {
            insets = UIEdgeInsetsMake(0, kNavigationMarginSize, 0, 0);
        }
        else {
            insets = UIEdgeInsetsMake(0, 0, 0, kNavigationMarginSize);
        }
        return insets;
        
    } else {
        
        return UIEdgeInsetsZero;
    }
}

@end
