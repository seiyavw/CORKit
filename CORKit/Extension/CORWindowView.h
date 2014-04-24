//
//  CORWindowView.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CORWindowView : UIView

- (void)setup;
+ (void)show;
+ (void)hide;
- (void)prepareToShow;
- (void)showSharedView;
- (void)hideSharedView;

@end
