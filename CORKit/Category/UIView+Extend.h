//
//  UIView+Extend.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Extend)

@property (nonatomic) CGFloat originX;
@property (nonatomic) CGFloat originY;
@property (nonatomic) CGFloat width;
@property (nonatomic) CGFloat height;
@property (nonatomic) CGFloat maxX;
@property (nonatomic) CGFloat maxY;

@property (nonatomic) CGPoint origin;
@property (nonatomic) CGSize size;

- (void)checkFrame;

@end
