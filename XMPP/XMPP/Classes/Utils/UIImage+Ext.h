//
//  UIImage+Ext.h
//
//
//  Created by kiefer on 13-9-26.
//  Copyright (c) 2013年 cztv. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Ext)

- (UIImage *)fixOrientation;
////////////////////////////////////////////////////////////////////////////////////////////////////
- (UIImage *)imageAtRect:(CGRect)rect;
- (UIImage *)imageByScalingProportionallyToMinimumSize:(CGSize)targetSize;
- (UIImage *)imageByScalingProportionallyToSize:(CGSize)targetSize;
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
- (UIImage *)imageRotatedByRadians:(CGFloat)radians;
- (UIImage *)imageRotatedByDegrees:(CGFloat)degrees;
- (UIImage *)imageByApplyingAlpha:(CGFloat)alpha;
+ (UIImage *)imageWithColor:(UIColor *)color;
@end
