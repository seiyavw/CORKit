//
//  CORProcessView.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/04.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import <UIKit/UIKit.h>

struct CORPosition {
    CGFloat top;
    CGFloat bottom;
    CGFloat left;
    CGFloat right;
};
typedef struct CORPosition CORPosition;
extern CORPosition CORPositionMake(CGFloat top, CGFloat right, CGFloat bottom, CGFloat left);

@protocol CORProcessViewDelegate;

@interface CORProcessView : UIView

@property (nonatomic) NSArray *keyTimes;
@property (nonatomic) BOOL showsOnlyOneProcess;
@property (nonatomic, weak) id <CORProcessViewDelegate> delegate;


- (void)registerProcessWithView:(UIView *)view
                         origin:(CGPoint)origin;

- (void)registerProcessWithView:(UIView *)view
                     centerView:(UIView *)centerView
                         offset:(CGPoint)offset;

- (void)registerProcessWithView:(UIView *)view
                     besideView:(UIView *)besideView
                       position:(CORPosition)position;

- (void)start;
- (void)process;

@end


@protocol CORProcessViewDelegate <NSObject>

@optional

- (CAAnimation*)processView:(CORProcessView *)processView animationForProcessAtIndex:(NSInteger)index;
- (void)processView:(CORProcessView *)processView didExecuteProcessAtIndex:(NSInteger)index;
- (void)processView:(CORProcessView *)processView didEndAllProcesses:(NSInteger)totalCount;

@end