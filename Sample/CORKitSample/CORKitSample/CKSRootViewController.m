//
//  CKSRootViewController.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/04/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CKSRootViewController.h"

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
    
    [self setupScrollView];
    [self setupScrollMenu];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setupScrollMenu
{
    CORScrollMenuBar *menuBar = [[CORScrollMenuBar alloc] initWithFrame:CGRectMake(0.f, 0.f, 320.f, 64.f)];
    menuBar.backgroundColor = [UIColor brownColor];
    menuBar.horizontalMargin = 30.f;
    menuBar.vertialMargin = 20.f;
    menuBar.delegate = self;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 80.f, 40.f)];
    [button1 setTitle:@"Fashion" forState:UIControlStateNormal];
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    [button2 setTitle:@"IT" forState:UIControlStateNormal];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 100.f, 40.f)];
    [button3 setTitle:@"Technology" forState:UIControlStateNormal];
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 80.f, 40.f)];
    [button4 setTitle:@"Culture" forState:UIControlStateNormal];
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 60.f, 40.f)];
    [button5 setTitle:@"Music" forState:UIControlStateNormal];
    UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 70.f, 40.f)];
    [button6 setTitle:@"Nature" forState:UIControlStateNormal];
    UIButton *button7 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 40.f)];
    [button7 setTitle:@"Book" forState:UIControlStateNormal];
    UIButton *button8 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 80.f, 40.f)];
    [button8 setTitle:@"Literature" forState:UIControlStateNormal];
    UIButton *button9 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 60.f, 40.f)];
    [button9 setTitle:@"Human" forState:UIControlStateNormal];
    
    NSArray *buttons = @[button1, button2, button3, button4, button5, button6, button7, button8, button9];
    [menuBar addButtons:buttons];
    
    [self.view addSubview:menuBar];
}

- (void)setupScrollView
{
    CORPagingScrollView *scrollView = [[CORPagingScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, 320.f, [self.view getHeight] - 64.f)];
    
    UIView *view1 = [[UIView alloc] initWithFrame:scrollView.bounds];
    view1.backgroundColor = [UIColor redColor];
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label1.center = view1.center;
    [label1 setText:@"1"];
    [view1 addSubview:label1];
    
    UIView *view2 = [[UIView alloc] initWithFrame:scrollView.bounds];
    view2.backgroundColor = [UIColor greenColor];
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label2.center = view1.center;
    [label2 setText:@"2"];
    [view2 addSubview:label2];
    
    UIView *view3 = [[UIView alloc] initWithFrame:scrollView.bounds];
    view3.backgroundColor = [UIColor blueColor];
    UILabel *label3 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label3.center = view1.center;
    [label3 setText:@"3"];
    [view3 addSubview:label3];
    
    UIView *view4 = [[UIView alloc] initWithFrame:scrollView.bounds];
    view4.backgroundColor = [UIColor orangeColor];
    UILabel *label4 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label4.center = view1.center;
    [label4 setText:@"4"];
    [view4 addSubview:label4];
    
    UIView *view5 = [[UIView alloc] initWithFrame:scrollView.bounds];
    view5.backgroundColor = [UIColor purpleColor];
    UILabel *label5 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label5.center = view1.center;
    [label5 setText:@"5"];
    [view5 addSubview:label5];
    
    UIView *view6 = [[UIView alloc] initWithFrame:scrollView.bounds];
    view6.backgroundColor = [UIColor yellowColor];
    UILabel *label6 = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
    label6.center = view1.center;
    [label6 setText:@"6"];
    [view6 addSubview:label6];
    
    NSArray *pages = @[view1, view2, view3, view4, view5, view6];
    scrollView.loopEnabled = YES;
    [scrollView addPages:pages];
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    [self.view addSubview:scrollView];

}

#pragma mark - CORPagingScrollViewDelegate

- (void)scrollView:(CORPagingScrollView *)scrollView didMoveToPageAt:(NSInteger)pageIndex
{
//    LOG(@"page index %d", pageIndex);
}

#pragma mark - CORScrollMenuBarDelegate

- (void)scrollMenuBar:(CORPagingScrollView *)scrolLMenuBar didTapButtonAtIndex:(NSInteger)index
{
    LOG(@"index : %d", index);
}

- (void)scrollMenuBar:(CORPagingScrollView *)scrolLMenuBar didTapButtonOfTag:(NSInteger)tag
{

    LOG(@"tag : %d", tag);
}

@end
