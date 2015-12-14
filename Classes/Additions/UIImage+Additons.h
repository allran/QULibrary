//
//  UIImage+Additons.h
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/9/21.
//  Copyright © 2015年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (Additons)

-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size;
-(UIImage *) imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth;
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize;

+ (UIImage *)imageFromColor:(UIColor *)color;
+ (UIImage *)imageFromColor:(UIColor *)color targetSize:(CGSize)size;

@end
