//
//  CKSTutorialViewController.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CKSTutorialViewController.h"

@interface CKSTutorialViewController ()

@end

@implementation CKSTutorialViewController
{
    __weak IBOutlet UIButton *_backButton;
    __weak IBOutlet UIButton *_menuButton;
    __weak IBOutlet UIButton *_likeButton;
    __weak IBOutlet UIButton *_shareButton;
    __weak IBOutlet UIImageView *_breederImageView;
    __weak IBOutlet UIButton *_seemoreButton;
    
    __weak CORProcessView *_processView;
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
    
    [self registerProcesses];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)registerProcesses
{
    // Do any additional setup after loading the view from its nib.
    CGSize smallSize = CGSizeMake(100.f, 30.f);
    CGSize smallMidSize = CGSizeMake(120.f, 30.f);
    CGSize middleSize = CGSizeMake(140.f, 30.f);
    CGSize largeSize = CGSizeMake(240.f, 30.f);
    
    CORProcessView *processView = [[CORProcessView alloc] initWithFrame:self.view.bounds];
    
    // process1
    UILabel *backLabel = [self createLabelWithText:@"前のページに戻ります" size:middleSize];
    [processView registerProcessWithView:backLabel besideView:_backButton position:CORPositionMake(0.f, 10.f, 0.f, 0.f)];
    
    // process2
    UILabel *likeLabel = [self createLabelWithText:@"いいね！をします" size:smallMidSize];
    [processView registerProcessWithView:likeLabel origin:CGPointMake(0.f, CGRectGetMaxY(_likeButton.frame) + 10.f)];
    
    // process3
    UILabel *shareLabel = [self createLabelWithText:@"シェアをします" size:smallSize];
    [processView registerProcessWithView:shareLabel besideView:_shareButton position:CORPositionMake(0.f, 0.f, 10.f, 0.f)];
    
    // process4
    UILabel *breedLabel = [self createLabelWithText:@"ブリーダーです" size:smallSize];
    [processView registerProcessWithView:breedLabel centerView:_breederImageView offset:CGPointZero];
    
    // process5
    UILabel *moreLabel = [self createLabelWithText:@"他の情報を見るにはこのボタンをタップ" size:largeSize];
    [processView registerProcessWithView:moreLabel centerView:_seemoreButton offset:CGPointZero];
    
    // setup process view property
    UITapGestureRecognizer *recognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(didTapTutorialView)];
    [processView addGestureRecognizer:recognizer];
    processView.alpha = 0.f;
    processView.backgroundColor = [UIColor colorWithWhite:0.f alpha:0.8];
    processView.showsOnlyOneProcess = NO;
    processView.delegate = self;
    [self.view addSubview:processView];
    
    _processView = processView;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self showProcessViewWithAutoStart:NO];
    
}

- (void)showProcessViewWithAutoStart:(BOOL)autoStart
{
    __weak typeof (_processView) weakProcessView = _processView;
    
    [UIView animateWithDuration:0.3f delay:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakProcessView.alpha = 1.0f;
        
    } completion:^(BOOL finished) {
        if (autoStart) {
            
            weakProcessView.keyTimes = @[@1.f, @2.f, @3.f, @4.f, @5.f];
            [weakProcessView start];
            
        }
    }];
}

- (void)hideProcessView
{
    __weak typeof (_processView) weakProcessView = _processView;
    
    [UIView animateWithDuration:0.3f delay:0.5f options:UIViewAnimationOptionCurveLinear animations:^{
        
        weakProcessView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        [weakProcessView removeFromSuperview];
    }];

}

- (void)didTapTutorialView
{
    [_processView process];
}

- (UILabel *)createLabelWithText:(NSString *)text size:(CGSize)size
{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, size.width, size.height)];
    [label setTextColor:[UIColor whiteColor]];
    [label setFont:[UIFont systemFontOfSize:12.f]];
    [label setTextAlignment:NSTextAlignmentCenter];
    label.layer.borderColor = [UIColor whiteColor].CGColor;
    label.layer.cornerRadius = 3.f;
    label.layer.borderWidth = 1.f;
    [label setText: text];
    return label;
}

- (CAAnimationGroup *)createAnimationGroupWithAnimations:(NSArray *)animations
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.fromValue = @0.f;
    animation.toValue = @1.f;
    
    NSMutableArray *myAnimations = animations.mutableCopy;
    [myAnimations addObject:animation];
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.animations = myAnimations;
    animationGroup.duration = 0.3f;
    animationGroup.fillMode = kCAFillModeBoth;
    animationGroup.removedOnCompletion = NO;
    
    return animationGroup;
}

#pragma mark - CORProgressViewDelegate

- (CAAnimation *)processView:(CORProcessView *)processView animationForProcessAtIndex:(NSInteger)index
{
    
    switch (index) {
        case 0: {
            
            CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];
            animation.fromValue = @10.f;
            animation.toValue = @0.f;
            
            return [self createAnimationGroupWithAnimations:@[animation]];
            break;
        }
        case 1: {
        
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            animation.keyTimes = @[@0.0, @0.5f, @1.0f];
            animation.values = @[@0.f, @-10.f, @0.f];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            return [self createAnimationGroupWithAnimations:@[animation]];
            break;
        }
        case 2: {
            
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.y"];
            animation.keyTimes = @[@0.0, @0.5f, @1.0f];
            animation.values = @[@0.f, @-10.f, @0.f];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            return [self createAnimationGroupWithAnimations:@[animation]];
            break;
        }
        case 3: {
        
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.rotation.z"];
            float circleRadius = 2 * M_PI;
            animation.keyTimes = @[@0.0, @0.5f, @0.675f, @0.85f, @1.f];
            animation.values = @[@0.f, @0.f, @(-circleRadius/72.f), @(circleRadius/72.f), @0.f];
            
            return [self createAnimationGroupWithAnimations:@[animation]];
            break;
        }
        case 4: {
        
            CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.scale"];
            animation.keyTimes = @[@0.0, @0.8f, @1.f];
            animation.values = @[@0.8f, @1.1f, @1.0f];
            animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseOut];
            
            return [self createAnimationGroupWithAnimations:@[animation]];
            break;
        }
        default: {
        
            return nil;
            break;
        }
    }
}

- (void)processView:(CORProcessView *)processView didExecuteProcessAtIndex:(NSInteger)index
{
//    LOG(@"process:%d was executed", index);
}

- (void)processView:(CORProcessView *)processView didEndAllProcesses:(NSInteger)totalCount
{
    [self hideProcessView];
}

#pragma mark - IBAction

- (IBAction)didTapLikeButton:(id)sender {
    [self registerProcesses];
    [self showProcessViewWithAutoStart:NO];
}

- (IBAction)didTapDislikeButton:(id)sender {
    
    [self registerProcesses];
    [self showProcessViewWithAutoStart:YES];
    
}

@end
