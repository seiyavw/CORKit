//
//  CORScrollMenuBar.h
//  CORKitSample
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
@property (nonatomic, weak) id <CORScrollMenuBarDelegate> delegate;

- (void)addButtons:(NSArray *)buttons;
- (void)moveToButtonAtIndex:(NSInteger)buttonIndex;

@end

@protocol CORScrollMenuBarDelegate <NSObject>

@optional
- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didTapButtonOfTag:(NSInteger)tag;
- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didTapButtonAtIndex:(NSInteger)index;
- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didScrollToButtonAtIndex:(NSInteger)index;

@end