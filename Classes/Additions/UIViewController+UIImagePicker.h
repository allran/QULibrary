//
//  UIViewController+UIImagePicker.h
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/9/24.
//  Copyright © 2015年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/MobileCoreServices.h>

@interface UIViewController(UIImagePicker)<UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIActionSheetDelegate>
-(void)startPickerImage; //选取照片
-(void)endLoadOriginalImage:(UIImage *)img;
@end