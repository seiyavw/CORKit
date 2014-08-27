//
//  CORScrollMenuBar.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/01.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CORScrollMenuBarDelegate;

@interface CORScrollMenuBar : UIView <UIScrollViewDelegate>

@property (nonatomic) BOOL loopEnabled;
@property (nonatomic) CGFloat vertialMargin;
@property (nonatomic) CGFloat horizontalMargin;
@property (nonatomic, weak, readonly) UIScrollView *scrollView;
@property (nonatomic, readonly) NSInteger currentIndex;
@property (nonatomic, readonly) NSArray *buttons;
@property (nonatomic, weak) id <CORScrollMenuBarDelegate> delegate;

- (void)addButtons:(NSArray *)buttons;
- (void)moveToButtonAtIndex:(NSInteger)buttonIndex;
- (void)setButtonSelectedAtIndex:(NSInteger)index;

@end

@protocol CORScrollMenuBarDelegate <NSObject>

@optional
- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didTapButton:(UIButton *)button;
- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didTapButtonAtIndex:(NSInteger)index;
- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didScrollToButtonAtIndex:(NSInteger)index;

@end