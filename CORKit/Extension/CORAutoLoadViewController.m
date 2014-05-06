//
//  CORAutoLoadViewController.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/06.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CORAutoLoadViewController.h"

@interface CORAutoLoadViewController ()

@end

@implementation CORAutoLoadViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (_needsRefresh) {
        
        // refresh Control
        UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
        [_tableView addSubview:refreshControl];
        [refreshControl addTarget:self action:@selector(refreshHandler:) forControlEvents:UIControlEventValueChanged];
        _refreshControl = refreshControl;
    }

}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [_refreshControl endRefreshing];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    _tableView.delegate = nil;
}

- (void)addLoad
{
    // override and load next data here.
}

- (void)refresh
{
    // override and refresh data here.
}

- (void)refreshHandler:(id)sender
{
    UIRefreshControl *refreshControl = (UIRefreshControl *)sender;
    if ([refreshControl isRefreshing]) {
        [self refresh];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    float scrollY = scrollView.contentOffset.y;
    float needsLoadOriginY = scrollView.contentSize.height - CGRectGetHeight(scrollView.bounds) - 10.f;
    
    if (scrollY > needsLoadOriginY)
    {
        if (self.needsLoadNext)
        {
            [self addLoad];
        }
    }
}

@end
