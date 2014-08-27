//
//  CKSPagingViewController.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/04/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CKSPagingViewController.h"

@interface CKSPagingViewController ()

@end

@implementation CKSPagingViewController
{
    CORPagingScrollView *_scrollView;
    CORScrollMenuBar *_menuBar;
    NSArray * _buttons;
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
    menuBar.loopEnabled = YES;
    menuBar.horizontalMargin = 30.f;
    menuBar.vertialMargin = 20.f;
    menuBar.delegate = self;
    
    UIButton *button1 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 90.f, 40.f)];
    [button1 setTitle:@"1.Fashion" forState:UIControlStateNormal];
    UIButton *button2 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 40.f)];
    [button2 setTitle:@"2.IT" forState:UIControlStateNormal];
    UIButton *button3 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 110.f, 40.f)];
    [button3 setTitle:@"3.Technology" forState:UIControlStateNormal];
    UIButton *button4 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 90.f, 40.f)];
    [button4 setTitle:@"4.Culture" forState:UIControlStateNormal];
    UIButton *button5 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 70.f, 40.f)];
    [button5 setTitle:@"5.Music" forState:UIControlStateNormal];
    UIButton *button6 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 110.f, 40.f)];
    [button6 setTitle:@"6.Literature" forState:UIControlStateNormal];
    UIButton *button7 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 70.f, 40.f)];
    [button7 setTitle:@"7.Book" forState:UIControlStateNormal];
    UIButton *button8 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 110.f, 40.f)];
    [button8 setTitle:@"8.Literature" forState:UIControlStateNormal];
    UIButton *button9 = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 80.f, 40.f)];
    [button9 setTitle:@"9.Human" forState:UIControlStateNormal];
    
    NSArray *buttons = @[button1, button2, button3, button4, button5, button6, button7, button8, button9];
    [menuBar addButtons:buttons];
    _buttons = buttons;
    _menuBar = menuBar;
    
    [self.view addSubview:menuBar];
}

- (void)setupScrollView
{
    CORPagingScrollView *scrollView = [[CORPagingScrollView alloc] initWithFrame:CGRectMake(0.f, 64.f, 320.f, self.view.frame.size.height - 64.f)];
    
    NSMutableArray *pages = @[].mutableCopy;
    for (int i = 0; i < 9; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:scrollView.bounds];
        view.backgroundColor = [UIColor colorWithHue:0.1 * i saturation:1.0 brightness:1.0 alpha:1.0];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 200.f, 40.f)];
        label.textAlignment = NSTextAlignmentCenter;
        [label setFont:[UIFont systemFontOfSize:24.f]];
        label.center = view.center;
        [label setText:[NSString stringWithFormat:@"%d", i + 1]];
        [view addSubview:label];
        [pages addObject:view];
    }
    
    scrollView.loopEnabled = YES;
    [scrollView addPages:pages];
    scrollView.delegate = self;
    
    _scrollView = scrollView;
    
    [self.view addSubview:scrollView];
}

#pragma mark - CORPagingScrollViewDelegate

- (void)scrollView:(CORPagingScrollView *)scrollView didMoveToPageAt:(NSInteger)pageIndex
{
    LOG(@"page index %ld", (long)pageIndex);
    [_menuBar moveToButtonAtIndex:pageIndex];
}

#pragma mark - CORScrollMenuBarDelegate

- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didTapButtonAtIndex:(NSInteger)index
{
    LOG(@"index : %ld", (long)index);
}

- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didTapButton:(UIButton *)button
{
    LOG(@"%@ is tapped.", button);
}

- (void)scrollMenuBar:(CORScrollMenuBar *)scrollMenuBar didScrollToButtonAtIndex:(NSInteger)index
{
    UIButton *button = [_buttons objectAtIndex:index];
    LOG(@"Center is %@", button.titleLabel.text);
    
    [_scrollView moveToPageAt:index];
}

@end
