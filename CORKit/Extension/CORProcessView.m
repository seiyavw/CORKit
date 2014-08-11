//
//  CORProcessView.h.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "CORProcessView.h"
#import "UIView+Extend.h"

CORPosition CORPositionMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left)
{
    CORPosition position; position.top = top; position.right = right; position.bottom = bottom; position.left = left; return position;
}

@implementation CORProcessView
{
    NSMutableArray *_views;
    NSInteger _currentIndex;
}

NSString *const kCORProcessAnimation = @"kCORProcessAnimation";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    _currentIndex = 0.f;
    _views = @[].mutableCopy;
}

- (void)removeFromSuperview
{
    // remove animation and decrease reference count to 1
    [self removeAllProcessAnimations];
    
    [super removeFromSuperview];
}

- (void)dealloc
{
//    NSLog(@"dealloc");
}

#pragma mark - public

/**
 * register process with relative offset of a view
 */
- (void)registerProcessWithView:(UIView *)view
                         origin:(CGPoint)origin
{
    CGRect frame = CGRectMake(origin.x, origin.y, view.frame.size.width, view.frame.size.height);
    view.frame = frame;
    
    [self addProccessView:view];
}

/**
 * register process with offset from center of a view
 */
- (void)registerProcessWithView:(UIView *)view
                     centerView:(UIView *)centerView
                       offset:(CGPoint)offset
{
    if (centerView != nil) {
    
        CGPoint centerPoint = centerView.center;
        centerPoint.x += offset.x;
        centerPoint.y += offset.y;
        
        view.center = centerPoint;
    }

    [self addProccessView:view];
}

/**
 * register process with margin offset from a view
 */
- (void)registerProcessWithView:(UIView *)view
                     besideView:(UIView *)besideView
                       position:(CORPosition)position
{
    CGFloat offsetX = 0.f;
    CGFloat offsetY = 0.f;
    
    if (besideView != nil) {
        
        [self validatePostion:position];
        
        BOOL hasTop = (position.top != 0.f);
        BOOL hasBottom = (position.bottom != 0.f);
        BOOL hasRight = (position.right != 0.f);
        BOOL hasLeft = (position.left != 0.f);
        
        if (hasLeft || hasRight) {
            
            if (hasLeft) {
                
                offsetX = besideView.frame.origin.x - view.frame.size.width - position.left;
            
            } else {
            
                offsetX = CGRectGetMaxX(besideView.frame) + position.right;
            }
            
            if (!hasBottom && !hasTop) {
                offsetY = besideView.frame.origin.y + (besideView.frame.size.height - view.frame.size.height) / 2;
            }
        }
        
        if (hasTop || hasBottom) {
            
            if (hasTop) {
                
                offsetY = besideView.frame.origin.y - view.frame.size.height - position.top;
                
            } else {
                
                offsetY = CGRectGetMaxY(besideView.frame) + position.bottom;
            }
            
            if (!hasLeft && !hasRight) {
            
                offsetX = besideView.frame.origin.x + (besideView.frame.size.width - view.frame.size.width) / 2;
            }
        }
        
        CGRect frame = CGRectMake(offsetX, offsetY, view.frame.size.width, view.frame.size.height);
        view.frame = frame;
    }
    
    [self addProccessView:view];
    
}

/**
 * start processed automatically.
 * (needs keyTimes property)
 */
- (void)start
{
    if (_keyTimes == nil)
        return;
    
    for (int i = 0, length = _keyTimes.count; i < length; i++) {
        
        NSTimeInterval time = [[_keyTimes objectAtIndex:i] doubleValue];
        [self performSelector:@selector(process) withObject:nil afterDelay:time];
    }

}

/**
 * proceeds to the next
 */
- (void)process
{
    // end
    if (_currentIndex >= _views.count) {
        
        return;
    }
    
    // move on to process
    if (_currentIndex != 0 && _showsOnlyOneProcess) {
        UIView *previousView = [_views objectAtIndex:_currentIndex - 1];
        [previousView removeFromSuperview];
    }
    
    // execute process animation
    [self processAnimation];
    
    // increment for the next process
    _currentIndex++;
    
}

#pragma mark - private

- (void)addProccessView:(UIView *)view
{
    view.alpha = 0.f;
    [_views addObject:view];
}

- (void)validatePostion:(CORPosition)position
{
    NSAssert(!(position.top != 0.f && position.bottom != 0.f) ||
             !(position.right != 0.f && position.left != 0.f), @"top/bottom or left/right cannot be set both.");
}

- (void)processAnimation
{
    
    UIView *view = [_views objectAtIndex:_currentIndex];
    [self addSubview:view];
    
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(processView:animationForProcessAtIndex:)]) {
        
        CAAnimation *animation = [self.delegate processView:self animationForProcessAtIndex:_currentIndex];
        
        if (animation != nil) {
            
            if (animation.delegate == nil) {
                animation.delegate = self;
            }
            
        } else {
            
            animation = [self defaultAnimation];
        }
        
        [view.layer addAnimation:animation forKey:kCORProcessAnimation];
        
    } else {
        
        CAAnimation *animation = [self defaultAnimation];
        [view.layer addAnimation:animation forKey:kCORProcessAnimation];
    }
}

- (CABasicAnimation *)defaultAnimation
{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    animation.delegate = self;
    animation.fromValue = @0.f;
    animation.toValue = @1.f;
    animation.duration = 0.3f;
    animation.fillMode = kCAFillModeBoth;
    animation.removedOnCompletion = NO;
    
    return animation;
}

/**
 * remove all animation (otherwise, self is retained by animations' delegate)
 */
- (void)removeAllProcessAnimations
{
    for (UIView *view in _views) {
        [view.layer removeAnimationForKey:kCORProcessAnimation];
    }
}

#pragma mark - CAAnimationDelegate

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    if (self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(processView:didExecuteProcessAtIndex:)]) {
        
        [self.delegate processView:self didExecuteProcessAtIndex:_currentIndex];
    }
    
    if (_currentIndex == [_views count] &&
        self.delegate != nil &&
        [self.delegate respondsToSelector:@selector(processView:didEndAllProcesses:)]) {
        
        [self.delegate processView:self didEndAllProcesses:[_views count] - 1];
    }
}

@end
