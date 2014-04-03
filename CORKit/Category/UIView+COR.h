//
//  UIView+COR.h
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (COR)

- (CGFloat)getOriginX;
- (CGFloat)getOriginY;
- (CGFloat)getWidth;
- (CGFloat)getHeight;
- (CGFloat)getBottom;

- (void)setOriginX:(CGFloat)originX;
- (void)setOriginY:(CGFloat)originY;
- (void)setWidth:(CGFloat)width;
- (void)setHeight:(CGFloat)height;
- (void)showFrameLog;


@end
