//
//  CORScrollContentViewController.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/03/24.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CORScrollContentViewController : UIViewController
{
    @protected
    __weak IBOutlet UIScrollView *_scrollView;
    __weak IBOutlet UIView *_scrollContentView;
}

@end
