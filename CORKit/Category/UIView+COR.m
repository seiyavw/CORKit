//
//  UIView+COR.m
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "UIView+COR.h"

@implementation UIView (COR)

- (CGFloat)getOriginX
{
    return self.frame.origin.x;
}

- (CGFloat)getOriginY
{
    return self.frame.origin.y;
}

- (CGFloat)getWidth
{
    return self.frame.size.width;
}

- (CGFloat)getHeight
{
    return self.frame.size.height;
}

- (CGFloat)getBottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setOriginX:(CGFloat)originX
{
    [self setFrame:CGRectMake(originX, self.getOriginY, self.getWidth, self.getHeight)];
}

- (void)setOriginY:(CGFloat)originY
{
    [self setFrame:CGRectMake(self.getOriginX, originY, self.getWidth, self.getHeight)];
}

- (void)setWidth:(CGFloat)width
{
    [self setFrame:CGRectMake(self.getOriginX, self.getOriginY, width, self.getHeight)];
}

- (void)setHeight:(CGFloat)height
{
    [self setFrame:CGRectMake(self.getOriginX, self.getOriginY, self.getWidth, height)];
}

- (void)showFrameLog
{
    NSLog(@"--- Instance of %@ ---", NSStringFromClass([self class]));
    NSLog(@" OriginX : %f", [self getOriginX]);
    NSLog(@" OriginY : %f", [self getOriginY]);
    NSLog(@" Width   : %f", [self getWidth]);
    NSLog(@" Height  : %f", [self getHeight]);
}


@end
