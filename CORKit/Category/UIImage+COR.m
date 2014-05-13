//
//  UIImage+COR.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "UIImage+COR.h"

CGFloat DegreesToRadians(CGFloat degrees) {return degrees * M_PI / 180;};
CGFloat RadiansToDegrees(CGFloat radians) {return radians * 180/M_PI;};

@implementation UIImage (COR)

+ (UIImage *)roundedImageWithImage:(UIImage *)image size:(CGSize)size
{
    CGContextRef cx = CGBitmapContextCreate(NULL, size.width, size.height, CGImageGetBitsPerComponent(image.CGImage), 0, CGImageGetColorSpace(image.CGImage), (int)kCGImageAlphaPremultipliedLast);
    
    CGContextBeginPath(cx);
    CGRect pathRect = CGRectMake(0, 0, size.width, size.height);
    CGContextAddEllipseInRect(cx, pathRect);
    CGContextClosePath(cx);
    CGContextClip(cx);
    
    CGContextDrawImage(cx, CGRectMake(0, 0, size.width, size.height), image.CGImage);
    
    CGImageRef clippedImage = CGBitmapContextCreateImage(cx);
    CGContextRelease(cx);
    
    UIImage *roundedImage = [UIImage imageWithCGImage:clippedImage];
    CGImageRelease(clippedImage);
    return roundedImage;
}

+ (UIImage *)syntheSizeImageWithBaseImage:(UIImage *)baseImage frontImage:(UIImage *)frontImage atPoint:(CGPoint)point
{
    CGSize size = CGSizeMake(baseImage.size.width, baseImage.size.height);
    
    UIGraphicsBeginImageContext(size);
    
    [baseImage drawInRect:CGRectMake(0, 0 ,size.width, size.height)];
    // draw thumbnail at x:10 y:10
    [frontImage drawInRect:CGRectMake(point.x, point.y, frontImage.size.width, frontImage.size.height)];
    
    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return result;
}


- (UIImage *)imageOrientationFixedOfCamera:(BOOL)takenByFront
{
    UIImage *fixedImage = nil;
    
    UIGraphicsBeginImageContext(self.size);
    [self drawInRect:CGRectMake(0, 0, self.size.width, self.size.height)];
    fixedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    
    if (takenByFront) {
        
        fixedImage = [fixedImage imageMirroredHorizontally];
        
        switch (self.imageOrientation) {
                // normal orientation
            case UIImageOrientationRight:
                return fixedImage;
                break;
            case UIImageOrientationDown:
                return [fixedImage imageRotatedByDegrees:90.f];
                break;
            case UIImageOrientationUp:
                return [fixedImage imageRotatedByDegrees:270.f];
                break;
            case UIImageOrientationLeft:
                return [fixedImage imageRotatedByDegrees:180.f];
                break;
            case UIImageOrientationDownMirrored:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
            case UIImageOrientationUpMirrored:
                return fixedImage;
                break;
        }
        
    } else {
        
        switch (self.imageOrientation) {
                // normal orientation
            case UIImageOrientationRight:
                return fixedImage;
            case UIImageOrientationDown:
                return [fixedImage imageRotatedByDegrees:270.f];
                break;
            case UIImageOrientationUp:
                return [fixedImage imageRotatedByDegrees:90.f];
                break;
            case UIImageOrientationLeft:
                return [fixedImage imageRotatedByDegrees:180.f];
                break;
            case UIImageOrientationDownMirrored:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
            case UIImageOrientationUpMirrored:
                return fixedImage;
                break;
        }
    }
}

-(UIImage *)imageAtRect:(CGRect)rect
{
    
    CGImageRef imageRef = CGImageCreateWithImageInRect([self CGImage], rect);
    UIImage* subImage = [UIImage imageWithCGImage: imageRef];
    CGImageRelease(imageRef);
    
    return subImage;
    
}

- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor > heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor > heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor < heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    if (CGSizeEqualToSize(imageSize, targetSize) == NO) {
        
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        
        if (widthFactor < heightFactor)
            scaleFactor = widthFactor;
        else
            scaleFactor = heightFactor;
        
        scaledWidth  = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        
        // center the image
        
        if (widthFactor < heightFactor) {
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        } else if (widthFactor > heightFactor) {
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)imageByScalingToSize:(CGSize)targetSize {
    
    UIImage *sourceImage = self;
    UIImage *newImage = nil;
    
    //   CGSize imageSize = sourceImage.size;
    //   CGFloat width = imageSize.width;
    //   CGFloat height = imageSize.height;
    
    CGFloat targetWidth = targetSize.width;
    CGFloat targetHeight = targetSize.height;
    
    //   CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    
    CGPoint thumbnailPoint = CGPointMake(0.0,0.0);
    
    // this is actually the interesting part:
    
    UIGraphicsBeginImageContext(targetSize);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width  = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    if(newImage == nil) NSLog(@"could not scale image");
    
    
    return newImage ;
}


- (UIImage *)imageRotatedByRadians:(CGFloat)radians
{
    return [self imageRotatedByDegrees:RadiansToDegrees(radians)];
}

- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees
{
    // calculate the size of the rotated view's containing box for our drawing space
    UIView *rotatedViewBox = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.size.width, self.size.height)];
    CGAffineTransform t = CGAffineTransformMakeRotation(DegreesToRadians(degrees));
    rotatedViewBox.transform = t;
    CGSize rotatedSize = rotatedViewBox.frame.size;
    
    // Create the bitmap context
    UIGraphicsBeginImageContext(rotatedSize);
    CGContextRef bitmap = UIGraphicsGetCurrentContext();
    
    // Move the origin to the middle of the image so we will rotate and scale around the center.
    CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
    
    // Rotate the image context
    CGContextRotateCTM(bitmap, DegreesToRadians(degrees));
    
    // Now, draw the rotated/scaled image into the context
    CGContextScaleCTM(bitmap, 1.0, -1.0);
    CGContextDrawImage(bitmap, CGRectMake(-self.size.width / 2, -self.size.height / 2, self.size.width, self.size.height), [self CGImage]);
    
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
    
}

- (UIImage *)imageMirroredHorizontally
{
    CGImageRef imgRef = [self CGImage];
    
    UIGraphicsBeginImageContext(self.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextTranslateCTM(context, self.size.width,self.size.height);
    
    CGContextScaleCTM(context, -1.0, -1.0);
    CGContextDrawImage(context, CGRectMake( 0, 0,self.size.width, self.size.height), imgRef);
    
    UIImage *retImg = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return retImg;
}

- (UIImage *)getGrayScaleImage
{
    CGRect rect = CGRectMake(0.0, 0.0, self.size.width, self.size.height);
    
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceGray();
    CGContextRef alphaContext = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0,
                                                      colorSpace, (CGBitmapInfo)kCGImageAlphaOnly);
    CGContextDrawImage(alphaContext, rect, [self CGImage]);
    CGImageRef alphaImage = CGBitmapContextCreateImage(alphaContext);
    CGContextRelease(alphaContext);
    
    CGContextRef context = CGBitmapContextCreate(nil, self.size.width, self.size.height, 8, 0,
                                                 colorSpace, (CGBitmapInfo)kCGImageAlphaNone);
    CGContextDrawImage(context, rect, [self CGImage]);
    CGImageRef grayScaleImage = CGBitmapContextCreateImage(context);
    CGContextRelease(context);
    
    UIImage* grayScaleUIImage = [UIImage imageWithCGImage:
                                 CGImageCreateWithMask(grayScaleImage, alphaImage)];
    
    CGImageRelease(grayScaleImage);
    CGImageRelease(alphaImage);
    CGColorSpaceRelease(colorSpace);
    
    return grayScaleUIImage;
}


@end
