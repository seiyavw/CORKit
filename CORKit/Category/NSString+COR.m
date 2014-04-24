//
//  NSString+COR.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/02/20.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "NSString+COR.h"

@implementation NSString (COR)

- (CGRect)getTextFrameWithFont:(UIFont *)font label:(UILabel *)label padding:(CGFloat)padding {
    
    CGSize size;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributeDic = @{NSFontAttributeName:font};
        size = [self boundingRectWithSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributeDic
                                  context:nil].size;
    } else {
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // under ios7
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(label.frame.size.width, CGFLOAT_MAX)];
        #pragma clang diagnostic pop
        
    }
    
    CGRect frame = CGRectMake(label.frame.origin.x, label.frame.origin.y, label.frame.size.width, size.height + padding);
    
    return frame;
}

- (CGSize)getTextSizeWithFont:(UIFont *)font viewWidth:(CGFloat)viewWidth padding:(CGFloat)padding
{
    
    CGSize size;
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        NSDictionary *attributeDic = @{NSFontAttributeName:font};
        size = [self boundingRectWithSize:CGSizeMake(viewWidth, CGFLOAT_MAX)
                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingTruncatesLastVisibleLine
                               attributes:attributeDic
                                  context:nil].size;
    } else {
        
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wdeprecated-declarations"
        // under ios7
        size = [self sizeWithFont:font constrainedToSize:CGSizeMake(viewWidth, CGFLOAT_MAX)];
        #pragma clang diagnostic pop
    }
    
    size.height += padding;
    
    return size;
}


@end
