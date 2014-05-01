//
//  CKSRootViewController.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/04/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CKSRootViewController.h"
#import "CORPagingScrollView.h"

@interface CKSRootViewController ()

@end

@implementation CKSRootViewController
{
    CORPagingScrollView *_scrollView;
}

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
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIView *view1 = [[UIView alloc] initWithFrame:self.view.bounds];
    view1.backgroundColor = [UIColor redColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label1.center = view1.center;
    [label1 setText:@"1"];
    [view1 addSubview:label1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:self.view.bounds];
    view2.backgroundColor = [UIColor greenColor];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label2.center = view1.center;
    [label2 setText:@"2"];
    [view2 addSubview:label2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:self.view.bounds];
    view3.backgroundColor = [UIColor blueColor];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label3.center = view1.center;
    [label3 setText:@"3"];
    [view3 addSubview:label3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:self.view.bounds];
    view4.backgroundColor = [UIColor orangeColor];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label4.center = view1.center;
    [label4 setText:@"4"];
    [view4 addSubview:label4];
    
    UIView *view5 = [[UIView alloc] initWithFrame:self.view.bounds];
    view5.backgroundColor = [UIColor purpleColor];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label5.center = view1.center;
    [label5 setText:@"5"];
    [view5 addSubview:label5];
    
    UIView *view6 = [[UIView alloc] initWithFrame:self.view.bounds];
    view6.backgroundColor = [UIColor yellowColor];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label6.center = view1.center;
    [label6 setText:@"6"];
    [view6 addSubview:label6];
    
    NSArray *pages = @[view1, view2, view3, view4, view5, view6];
    
    CORPagingScrollView *scrollView = [[CORPagingScrollView alloc] initWithFrame:self.view.bounds];
    scrollView.loopEnabled = YES;
    [scrollView addPages:pages];
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    [self.view addSubview:scrollView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PagingScroll

- (void)scrollView:(CORPagingScrollView *)scrollView didMoveToPageAt:(NSInteger)pageIndex
{
    LOG(@"page index %d", pageIndex);
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
