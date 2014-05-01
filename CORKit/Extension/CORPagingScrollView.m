//
//  CORPagingScrollView.m
//  CORKitSample
//
//  Created by Seiya Sasaki on 2014/05/01.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

// TODO 14/05/01
// - flexible pages size (with margin options)
// - refactoring

#import "CORPagingScrollView.h"

@implementation CORPagingScrollView
{
    UIScrollView *_scrollView;
    NSArray *_pages;
    NSInteger _currentIndex;
    CORPagingScrollDirection _direction;
    CGPoint _beginDraggingOffset;
    BOOL _pageMovable;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
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
    CGFloat pageWidth = [self getWidth];
    
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
    
    for (int i = 0, length = _pages.count; i < length; i++) {
        
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

- (void)updatePageIndex
{
    switch (_direction) {
        case CORPagingScrollLeft: {
            _currentIndex++;
            if (_currentIndex > _pages.count - 1) {
                _currentIndex = 0;
            }
        }
            break;
        case CORPagingScrollRight: {
            _currentIndex--;
            if (_currentIndex < 0) {
                _currentIndex = _pages.count - 1;
            }
            break;
        }
        case CORPagingScrollNone:
        default:
            break;
    }
}

- (void)handlePaging
{
    if (_loopEnabled) {
        
        // rearrange
        [self rearrangePages];
        
        // reset values at the end
        _direction = CORPagingScrollNone;
        _pageMovable = NO;
        
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(scrollView: didMoveToPageAt:)]) {
            [self.delegate scrollView:self didMoveToPageAt:_currentIndex];
        }
        
    } else {
    
        if (self.delegate &&
            [self.delegate respondsToSelector:@selector(scrollView: didMoveToPageAt:)]) {
            
            NSInteger index = (NSInteger)_scrollView.contentOffset.x / _scrollView.frame.size.width;
            [self.delegate scrollView:self didMoveToPageAt:index];
        }
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
    
    for (int i = 0, length = pages.count; i < length; i++) {
        
        UIView *view = [pages objectAtIndex:i];
        CGFloat width = [view getWidth];
        [view setOriginX: width * i];
        [_scrollView addSubview:view];
        
        contentWidth += width;
    }
    
    [_scrollView setContentSize:CGSizeMake(contentWidth, [self getHeight])];
    
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
 * @param Page Index
 *
 * @return void
 */
- (void)moveToPageAt:(NSInteger)pageIndex
{
    if (pageIndex > _pages.count - 1)
        return; // beyond the number of pages
    
    _currentIndex = pageIndex; // set index
    _pageMovable = YES;// enable moving
    
    // update pages
    [self handlePaging];
}



#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    _beginDraggingOffset = _scrollView.contentOffset;
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset
{
    // if scrollView will change its page
    if (_beginDraggingOffset.x != targetContentOffset->x) {
        
        // detect direction
        if (_beginDraggingOffset.x < targetContentOffset->x) {
            
            _direction = CORPagingScrollLeft;
            
        } else if (_beginDraggingOffset.x > targetContentOffset->x) {
            
            _direction = CORPagingScrollRight;
        }
        
        // set page moging enable for page handling
        _pageMovable = YES;
        
        // prepare index for page handling
        [self updatePageIndex];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if (_pageMovable) {
        [self handlePaging];
    }
}


@end
