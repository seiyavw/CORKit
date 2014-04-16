//
//  CORBlendView.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/02/26.
//  Copyright (c) 2014年 Seiya Sasaki All rights reserved.
//

#import "CORBlendView.h"

@implementation CORBlendView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _blendMode = kCGBlendModeMultiply;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (UIImage *)imageFromView:(UIView *)view
{
    // 必要なUIImageサイズ分のコンテキスト確保
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    // 画像出力
    [view.layer renderInContext:context];
    
    // uiimage化
    UIImage *renderedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    // コンテキスト破棄
    UIGraphicsEndImageContext();
    
    return renderedImage;
    
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextClearRect(context, self.bounds);
    
    if (_backImage) {
        
        [_backImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0f];
    }
    
    if (_frontImage) {
        
        [_frontImage drawInRect:rect blendMode:self.blendMode alpha:1.0f];
    }
}

- (void)redrawViews
{
    if (_backView) {
        
        _backImage = [self imageFromView:_backView];
    }
    
    if (_frontView) {
        
        _frontImage = [self imageFromView:_frontView];
    }
    
    [self setNeedsDisplay];
}

- (void)clearViews
{
    _backView = nil;
    _frontView = nil;
    _backImage = nil;
    _frontImage = nil;
    
    [self setNeedsDisplay];
}

- (void)updateWithBackView:(UIView *)backView
{
    _backView = backView;
    [self redrawViews];
}

- (void)updateWithFrontView:(UIView *)frontView
{
    _frontView = frontView;
    [self redrawViews];
}

- (void)setFrontView:(UIView *)frontView
{
    _frontView = frontView;
}

- (void)setBackView:(UIView *)backView
{
    _backView = backView;
}

@end
