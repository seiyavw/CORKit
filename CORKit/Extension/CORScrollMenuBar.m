//
//  CORScrollMenuBar.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/01.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CORScrollMenuBar.h"
#import "UIView+COR.h"

@implementation CORScrollMenuBar
{
    UIScrollView *_scrollView;
    NSInteger _currentIndex;
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

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupScrollView];
    }
    return self;
}

#pragma mark - private

- (void)setupScrollView
{
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.clipsToBounds = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    _scrollView.decelerationRate = UIScrollViewDecelerationRateFast;
    [self addSubview:_scrollView];
}

- (void)didTapMenuButton:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(scrollMenuBar:didTapButton:)]) {
        
        // deliver button instance
        [self.delegate scrollMenuBar:self didTapButton:button];
    }
    
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(scrollMenuBar:didTapButtonAtIndex:)]) {
        
        // tell a button index
        NSInteger index = [_buttons indexOfObject:button];
        [self.delegate scrollMenuBar:self didTapButtonAtIndex:index];
    }
}

/**
 * Rearrange all button and adjust scroll offset for loop
 */
- (void)rearrangeButtonsWithCenterIndex:(NSInteger)centerIndex
{

    NSInteger visibleIndex = ceil((CGFloat)(_buttons.count - 1) / 2);
    
    // example (case of the number of pages is four)
    //
    // current == 0
    // 2  3 |0| 1
    //(0  1  2  3)
    //
    // current == 3
    // 1  2 |3| 0
    //(0  1  2  3)
    //
    
    NSMutableArray *newButtons = @[].mutableCopy;
    
    // create new array which size is the same as _buttons'.
    for (NSInteger i = 0; i < _buttons.count; i++)
    {
        [newButtons addObject:[NSNull null]];
    }
    
    // arrange new array
    for (NSInteger i = 0, length = _buttons.count; i < length; i++) {
        
        NSInteger pageIndex = i + (int)(visibleIndex - centerIndex);
        
        if (pageIndex > (NSInteger)(_buttons.count - 1)) {
            
            pageIndex = pageIndex - _buttons.count;
            
        } else if (pageIndex < 0) {
            
            pageIndex = _buttons.count + pageIndex;
        }
        
        UIButton *button = [_buttons objectAtIndex:i];
        [newButtons replaceObjectAtIndex:pageIndex withObject:button];
    }
    
    // relayout based on new array
    CGFloat lastMaxX = 0;
    for (UIButton *button in newButtons) {
        [button setFrame:CGRectMake(lastMaxX + _horizontalMargin, _vertialMargin, button.frame.size.width, button.frame.size.height)];
        lastMaxX = CGRectGetMaxX(button.frame);
    }
    
    // set offset
    UIButton *centerButton = [_buttons objectAtIndex:centerIndex];
    [self scrollToCenterOfButton:centerButton animated:NO completion:nil];
    
}

/**
 * Scroll to center button
 */
- (void)scrollToCenterOfButton:(UIButton *)button animated:(BOOL)animated completion:(void (^)(BOOL finished))completion
{

    CGFloat targetX = button.frame.origin.x - (_scrollView.frame.size.width - button.frame.size.width) / 2;
    CGPoint targetPoint = CGPointMake(targetX, _scrollView.contentOffset.y);
    
    __weak typeof (_scrollView) weakScrollView = _scrollView;
    
    if (animated) {
        [UIView animateWithDuration:0.15f animations:^{
            
            [weakScrollView setContentOffset:targetPoint animated:NO];
            
        } completion:completion];
        
    } else {
        
        [_scrollView setContentOffset:targetPoint animated:NO];
    }

}

/**
 * Set button on/off for dragging
 */
- (void)setButtonsUserInterationEnabled:(BOOL)enabled;
{
    for (UIButton *button in _buttons) {
        button.userInteractionEnabled = enabled;
    }
}

/**
 * Find the center button and rearrange
 */
- (void)handleScrolling
{
    CGFloat tempMarginDiff = 320.f;
    UIButton *centerButton = nil;
    for (UIButton *button in _buttons) {
        CGRect intersectionRect = CGRectIntersection(_scrollView.bounds, button.frame);
        if (!CGRectIsNull(intersectionRect)) {
            CGFloat leftOffset = intersectionRect.origin.x - _scrollView.contentOffset.x;
            CGFloat rightOffset = _scrollView.bounds.size.width - (leftOffset + intersectionRect.size.width);
            CGFloat marginDiff = abs(leftOffset - rightOffset);
            if (tempMarginDiff > marginDiff) {
                tempMarginDiff = marginDiff;
                centerButton = button;
            }
        }
    }
    
    if (centerButton != nil) {
        
        NSInteger buttonIndex = [_buttons indexOfObject:centerButton];
        __weak typeof (self) weakSelf = self;
        [self scrollToCenterOfButton:centerButton animated:YES completion:^(BOOL finished) {
            
            if (_currentIndex == buttonIndex)
                return; // if the same index, no changes
            
            // update index
            _currentIndex = buttonIndex;
            
            if (_loopEnabled) {
                [weakSelf rearrangeButtonsWithCenterIndex:buttonIndex];
            }
            
            if (weakSelf.delegate != nil &&
                [weakSelf.delegate respondsToSelector:@selector(scrollMenuBar:didScrollToButtonAtIndex:)]) {
                [weakSelf.delegate scrollMenuBar:weakSelf didScrollToButtonAtIndex:buttonIndex];
            }
        }];
    }
}

#pragma mark - public

/**
 * add and layout buttons
 *
 * @param array of buttons
 *
 * @return void
 */
- (void)addButtons:(NSArray *)buttons
{
    if (_buttons != nil)
        return;
    
    CGFloat lastMaxX = 0;
    
    for (NSInteger i = 0, length = buttons.count; i < length; i++) {
        
        UIButton *button = [buttons objectAtIndex:i];
        [button setFrame:CGRectMake(lastMaxX + _horizontalMargin, _vertialMargin, button.frame.size.width, button.frame.size.height)];
        [button addTarget:self action:@selector(didTapMenuButton:) forControlEvents:UIControlEventTouchUpInside];
        [_scrollView addSubview:button];
        lastMaxX = CGRectGetMaxX(button.frame);
    }
    
    [_scrollView setContentSize:CGSizeMake(lastMaxX + _horizontalMargin, self.frame.size.height)];
    
    _buttons = buttons;
}

/**
 * move to a specified page index
 *
 * @param page index number
 *
 * @return void
 */
- (void)moveToButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex > _buttons.count - 1)
        return; // beyond array capacity
    
    UIButton *centerButton = [_buttons objectAtIndex:buttonIndex];
    // in this case, delegate method is not called in completion block
    __weak typeof (self) weakSelf = self;
    [self scrollToCenterOfButton:centerButton animated:YES completion:^(BOOL finished) {
        
        if (_loopEnabled && _currentIndex != buttonIndex) {
            _currentIndex = buttonIndex;
            [weakSelf rearrangeButtonsWithCenterIndex:buttonIndex];
        }
    }];

}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self setButtonsUserInterationEnabled:NO];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self setButtonsUserInterationEnabled:YES];
    
    if (!decelerate) {
        
        [self handleScrolling];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self handleScrolling];
}

@end
