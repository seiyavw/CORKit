//
//  CORPagingScrollView.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/01.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

// TODO 14/05/01
// - flexible pages size (with margin options)
// - refactoring

#import "CORPagingScrollView.h"
#import "UIView+COR.h"

@implementation CORPagingScrollView
{
    UIScrollView *_scrollView;
    NSArray *_pages;
    NSInteger _currentIndex;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupScrollView];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self setupScrollView];
    }
    return self;
}


#pragma mark - private

/**
 * initial setup values and scrollView
 */
- (void)setupScrollView
{
    _currentIndex = 0;
    
    _scrollView = [[UIScrollView alloc] initWithFrame:self.bounds];
    _scrollView.pagingEnabled = YES;
    _scrollView.clipsToBounds = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
}

/**
 * Rearrange subview pages depending on the current page index
 */
- (void)rearrangePages
{
    NSInteger visibleIndex = ceil((CGFloat)(_pages.count - 1) / 2);
    CGFloat pageWidth = self.frame.size.width;
    
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
    
    for (NSInteger i = 0, length = _pages.count; i < length; i++) {
        
        NSInteger pageIndex = i + (int)(visibleIndex - _currentIndex);
        
        if (pageIndex > (NSInteger)(_pages.count - 1)) {
            
            pageIndex = pageIndex - _pages.count;
            
        } else if (pageIndex < 0) {
            
            pageIndex = _pages.count + pageIndex;
        }
        
        UIView *view = [_pages objectAtIndex:i];
        [view setOriginX:pageWidth * pageIndex];
    }
    
    [_scrollView setContentOffset:CGPointMake(visibleIndex * pageWidth, 0.f) animated:NO];
    
}

/**
 * move page views based on updated page index
 */
- (void)handlePaging
{
    if (_loopEnabled) {
        // rearrange
        [self rearrangePages];
    }
    
    if (self.delegate &&
        [self.delegate respondsToSelector:@selector(scrollView: didMoveToPageAt:)]) {
        [self.delegate scrollView:self didMoveToPageAt:_currentIndex];
    }
}

#pragma mark - public

/**
 * add subview pages of scrollView
 *
 * @param Array of Pages (NSArray of UIViews)
 *
 * @return void
 */
- (void)addPages:(NSArray *)pages
{
    if (_pages != nil)
        return;
    
    CGFloat contentWidth = 0;
    
    for (NSInteger i = 0, length = pages.count; i < length; i++) {
        
        UIView *view = [pages objectAtIndex:i];
        CGFloat width = view.frame.size.width;
        [view setOriginX: width * i];
        [_scrollView addSubview:view];
        
        contentWidth += width;
    }
    
    [_scrollView setContentSize:CGSizeMake(contentWidth, self.frame.size.height)];
    
    _pages = pages;
    
    if (_loopEnabled) {
        
        // if loop is enabled, do initial loop setup
        _currentIndex = 0;
        [self rearrangePages];
    }
}

/**
 * move to a specified page index
 *
 * @param page index number
 *
 * @return void
 */
- (void)moveToPageAt:(NSInteger)pageIndex
{
    if (pageIndex > _pages.count - 1 || _currentIndex == pageIndex)
        return; // beyond array capacity or the same index
    
    _currentIndex = pageIndex; // set index
    
    if (_loopEnabled) {
        // rearrange
        [self rearrangePages];
    }
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    CGFloat tempVisibleWidth = 0.f;
    UIView *targetPage = nil;
    for (UIView *page in _pages) {
        CGRect intersectionRect = CGRectIntersection(scrollView.bounds, page.frame);
        if (!CGRectIsNull(intersectionRect)) {
            CGFloat width = intersectionRect.size.width;
            if (tempVisibleWidth < width) {
                tempVisibleWidth = width;
                targetPage = page;
            }
        }
    }
    
    if (targetPage != nil) {
        NSInteger targetIndex = [_pages indexOfObject:targetPage];
        
        if (_currentIndex == targetIndex) // if it will move to the same page, do nothing
            return;
        
        _currentIndex = targetIndex;
        [self handlePaging];
    }
}

@end
