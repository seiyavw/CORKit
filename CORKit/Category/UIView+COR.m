//
//  UIView+COR.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "UIView+COR.h"

@implementation UIView (COR)

- (CGFloat)originX
{
    return self.frame.origin.x;
}

- (CGFloat)originY
{
    return self.frame.origin.y;
}

- (CGFloat)width
{
    return self.frame.size.width;
}

- (CGFloat)height
{
    return self.frame.size.height;
}

- (CGFloat)maxX
{
    return CGRectGetMaxX(self.frame);
}

- (CGFloat)maxY
{
    return CGRectGetMaxX(self.frame);
}

- (CGPoint)origin
{
    return self.frame.origin;
}

- (CGSize)size
{
    return self.frame.size;
}

- (void)setOriginX:(CGFloat)originX
{
    [self setFrame:CGRectMake(originX, self.originY, self.width, self.height)];
}

- (void)setOriginY:(CGFloat)originY
{
    [self setFrame:CGRectMake([self originX], originY, self.width, self.height)];
}

- (void)setWidth:(CGFloat)width
{
    [self setFrame:CGRectMake([self originX], [self originY], width, self.height)];
}

- (void)setHeight:(CGFloat)height
{
    [self setFrame:CGRectMake([self originX], [self originY], self.width, height)];
}

- (void)setMaxX:(CGFloat)maxX
{
    [self setFrame: CGRectMake(maxX - self.width, self.originY, self.width, self.height)];
}

- (void)setMaxY:(CGFloat)maxY
{
    [self setFrame: CGRectMake(self.originX, maxY - self.height, self.width, self.height)];
}

- (void)setOrigin:(CGPoint)origin
{
    [self setFrame:CGRectMake(origin.x, origin.y, self.width, self.height)];
}

- (void)setSize:(CGSize)size
{
    [self setFrame:CGRectMake(self.originX, self.originY, size.width, size.height)];
}

- (void)checkFrame
{
    NSLog(@"-- Instance of %@ --", NSStringFromClass([self class]));
    NSLog(@" OriginX : %f", [self originX]);
    NSLog(@" OriginY : %f", [self originY]);
    NSLog(@" Width   : %f", self.width);
    NSLog(@" Height  : %f", self.height);
}


@end
