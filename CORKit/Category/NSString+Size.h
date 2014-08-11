//
//  NSString+Size.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/02/20.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Size)

- (CGRect)getTextFrameWithFont:(UIFont *)font label:(UILabel *)label padding:(CGSize)padding;
- (CGSize)getTextSizeWithFont:(UIFont *)font viewWidth:(CGFloat)viewWidth padding:(CGSize)padding;

@end
