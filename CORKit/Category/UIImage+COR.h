//
//  UIImage+COR.h
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (COR)
+ (UIImage *)roundedImageWithImage:(UIImage *)image size:(CGSize)size;
+ (UIImage *)syntheSizeImageWithBaseImage:(UIImage *)baseImage frontImage:(UIImage *)frontImage atPoint:(CGPoint)point;

- (UIImage *)imageOrientationFixedOfCamera:(BOOL)takenByRear;
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageMirroredHorizontally;

- (UIImage *)getGrayScaleImage;

@end
