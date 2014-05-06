//
//  COROnWindowView.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface COROnWindowView : UIView

- (void)setup;
+ (void)show;
+ (void)hide;
- (void)showSharedView;
- (void)hideSharedView;

@end
