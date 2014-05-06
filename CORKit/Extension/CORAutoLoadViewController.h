//
//  CORAutoLoadViewController.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/06.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CORAutoLoadViewController : UIViewController
{
    @protected
    __weak IBOutlet UITableView* _tableView;
    __weak UIRefreshControl *_refreshControl;
}

@property (nonatomic) BOOL needsLoadNext;
@property (nonatomic) BOOL needsRefresh;

- (void)addLoad;
- (void)refresh;

@end
