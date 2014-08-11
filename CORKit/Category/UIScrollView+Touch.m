//
//  UIScrollView+Touch.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/05/13.
//  Copyright (c) 2014年 corleonis.jp. All rights reserved.
//

#import "UIScrollView+Touch.h"

@implementation UIScrollView (Touch)

/**
 * fetch user touch events even on scrollview
 */
- (void)touchesEnded:(NSSet *)touches
           withEvent:(UIEvent *)event
{
	if (!self.dragging) {
        
		[self.nextResponder touchesEnded:touches
                               withEvent:event];
	}
    
	[super touchesEnded:touches
              withEvent:event];
}

@end
