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

@property (nonatomic) CGFloat vertialMargin;
@property (nonatomic) CGFloat horizontalMargin;
@property (nonatomic, weak) id <CORScrollMenuBarDelegate> delegate;

- (void)addButtons:(NSArray *)buttons;

@end

@protocol CORScrollMenuBarDelegate <NSObject>

@optional
- (void)scrollMenuBar:(CORScrollMenuBar *)scrolLMenuBar didTapButtonOfTag:(NSInteger)tag;
- (void)scrollMenuBar:(CORScrollMenuBar *)scrolLMenuBar didTapButtonAtIndex:(NSInteger)index;

@end