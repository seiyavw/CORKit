//
//  CORScrollContentViewController.m
//  MyTemplate
//
//  Created by Seiya Sasaki on 2014/03/24.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORScrollContentViewController.h"

@interface CORScrollContentViewController ()

@end

@implementation CORScrollContentViewController

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
    // Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // layout
    
    
    // layout
    [self.view layoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // PaCOR the selected object to the new view controller.
}
*/

@end
