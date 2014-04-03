//
//  CORBlendView.h
//  Smahorror
//
//  Created by Seiya Sasaki on 2014/02/26.
//  Copyright (c) 2014年 kayac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CORBlendView : UIView
{
@protected
    UIImage *_frontImage;
    UIImage *_backImage;
    CGBlendMode _blendMode;
    UIView *_backView;
    UIView *_frontView;
}

@property (nonatomic) CGBlendMode blendMode;

- (UIImage *)imageFromView:(UIView *)view;
- (void)redrawViews;
- (void)updateWithBackView:(UIView *)backView;
- (void)updateWithFrontView:(UIView *)frontView;
- (void)setFrontView:(UIView *)frontView;
- (void)setBackView:(UIView *)backView;
- (void)clearViews;

@end
