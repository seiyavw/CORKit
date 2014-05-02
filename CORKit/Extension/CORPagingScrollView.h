//
//  CORPagingScrollView.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/01.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CORPagingScrollDirection) {
    CORPagingScrollNone  = 0,
    CORPagingScrollLeft  = 1,
    CORPagingScrollRight = 2
};

@protocol CORPagingScrollViewDelegate;

@interface CORPagingScrollView : UIView <UIScrollViewDelegate>

@property (nonatomic, assign) BOOL loopEnabled;
@property (nonatomic, weak) id <CORPagingScrollViewDelegate> delegate;

- (void)addPages:(NSArray *)pages;
- (void)moveToPageAt:(NSInteger)pageIndex;

@end

@protocol CORPagingScrollViewDelegate <NSObject>

@optional
- (void)scrollView:(CORPagingScrollView *)scrollView didMoveToPageAt:(NSInteger)pageIndex;

@end
