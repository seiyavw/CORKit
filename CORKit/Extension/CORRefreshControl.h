//
//  CORRefreshControl.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/08/25.
//  Copyright (c) 2014年 jp.corleonis All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CORRefreshControl : UIControl

@property (nonatomic, assign, readonly) BOOL isRefreshing;
@property (nonatomic, assign) CGFloat refreshOffsetY;

- (void)endRefreshing;
- (void)willStartRefreshing;
- (void)willEndRefreshing;

@end
