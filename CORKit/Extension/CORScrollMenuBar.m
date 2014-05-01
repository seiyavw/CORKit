//
//  CORScrollMenuBar.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/05/01.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CORScrollMenuBar.h"

@implementation CORScrollMenuBar
{
    UIScrollView *_scrollView;
    NSArray *_buttons;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollView];
    }
    return self;
}

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.clipsToBounds = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}

- (void)addButtons:(NSArray *)buttons
{
    if (_buttons != nil)
        return;
    
    CGFloat lastMaxX = 0;
    
    for (int i = 0, length = buttons.count; i < length; i++) {
        
        UIButton *button = [buttons objectAtIndex:i];
        [button setFrame:CGRectMake(lastMaxX + _horizontalMargin, _vertialMargin, [button getWidth], [button getHeight])];
        [button addTarget:self action:@selector(didTapMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        lastMaxX = CGRectGetMaxX(button.frame);
    }
    
    [_scrollView setContentSize:CGSizeMake(lastMaxX + _horizontalMargin, [self getHeight])];
    
    _buttons = buttons;
}

- (void)didTapMenuButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(scrollMenuBar:didTapButtonOfTag:)]) {
        
        NSInteger tag = button.tag;
        [self.delegate scrollMenuBar:self didTapButtonOfTag:tag];
    }
    
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(scrollMenuBar:didTapButtonAtIndex:)]) {
        
        NSInteger index = [_buttons indexOfObject:button];
        [self.delegate scrollMenuBar:self didTapButtonAtIndex:index];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    LOG(@"end");
}


@end
