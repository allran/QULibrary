//
//  UIImage+Additons.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/9/21.
//  Copyright © 2015年 瞿伦平. All rights reserved.
//

#import "UIImage+Additons.h"

@implementation UIImage (Additons)
-(UIImage *) imageCompressForSize:(UIImage *)sourceImage targetSize:(CGSize)size {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = size.width;
    CGFloat targetHeight = size.height;
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    
    UIGraphicsBeginImageContext(size);
    
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    [sourceImage drawInRect:thumbnailRect];
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    
    return newImage;
    
}


-(UIImage *)imageCompressForWidth:(UIImage *)sourceImage targetWidth:(CGFloat)defineWidth {
    UIImage *newImage = nil;
    CGSize imageSize = sourceImage.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat targetWidth = defineWidth;
    CGFloat targetHeight = height / (width / targetWidth);
    CGSize size = CGSizeMake(targetWidth, targetHeight);
    CGFloat scaleFactor = 0.0;
    CGFloat scaledWidth = targetWidth;
    CGFloat scaledHeight = targetHeight;
    CGPoint thumbnailPoint = CGPointMake(0.0, 0.0);
    if(CGSizeEqualToSize(imageSize, size) == NO){
        CGFloat widthFactor = targetWidth / width;
        CGFloat heightFactor = targetHeight / height;
        if(widthFactor > heightFactor){
            scaleFactor = widthFactor;
        }
        else{
            scaleFactor = heightFactor;
        }
        scaledWidth = width * scaleFactor;
        scaledHeight = height * scaleFactor;
        if(widthFactor > heightFactor){
            thumbnailPoint.y = (targetHeight - scaledHeight) * 0.5;
        }else if(widthFactor < heightFactor){
            thumbnailPoint.x = (targetWidth - scaledWidth) * 0.5;
        }
    }
    UIGraphicsBeginImageContext(size);
    CGRect thumbnailRect = CGRectZero;
    thumbnailRect.origin = thumbnailPoint;
    thumbnailRect.size.width = scaledWidth;
    thumbnailRect.size.height = scaledHeight;
    
    [sourceImage drawInRect:thumbnailRect];
    
    newImage = UIGraphicsGetImageFromCurrentImageContext();
    if(newImage == nil){
        NSLog(@"scale image fail");
    }
    
    UIGraphicsEndImageContext();
    return newImage;
}


/**
 *  返回指定格式图片
 *
 *  @param image       源图片
 *  @param maxFileSize 目标大小，单位为k,如 20kb
 *
 *  @return 返回图片
 */
+ (NSData *)compressImage:(UIImage *)image toMaxFileSize:(NSInteger)maxFileSize {
    NSUInteger length = 0, lengthNew = 0;
    
    CGFloat compression = 0.9f;
    NSData *imageData = UIImageJPEGRepresentation(image, compression);
    length = imageData.length;
    lengthNew = length;
    
    
    
    NSUInteger lengthTag = maxFileSize*1000;
    NSUInteger lengthOffset = 20*1000;
    
    NSLog(@"Length: %lu New: %lu lengthTag: %lu  lengthOffset: %lu", length, lengthNew, lengthTag, lengthOffset);
    //
    while (lengthNew > lengthTag && (length-lengthNew)<lengthOffset) { //当源图片大于指定大小，并且两次裁切差大于20kb 时
        length = lengthNew;
        compression -= compression/2;
        imageData = UIImageJPEGRepresentation(image, compression);
        lengthNew = imageData.length;
        
        NSLog(@"WhileLength: %lu  New:%lu  compression:%.2f", (unsigned long)length, (unsigned long)lengthNew, compression);
    }
    NSLog(@"Length: %lu New: %lu lengthTag: %lu  lengthOffset: %lu", length, lengthNew, lengthTag, lengthOffset);
    NSLog(@"Length: %lu", (unsigned long)imageData.length);
    return imageData;
}



+ (UIImage *)imageFromColor:(UIColor *)color {
    return [self imageFromColor:color targetSize:CGSizeMake(600, 600)];
}

+ (UIImage *)imageFromColor:(UIColor *)color targetSize:(CGSize)size {
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return img;
}
@end
