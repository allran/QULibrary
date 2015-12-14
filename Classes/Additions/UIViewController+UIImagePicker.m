//
//  UIViewController+UIImagePicker.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/9/24.
//  Copyright © 2015年 瞿伦平. All rights reserved.
//

#import "UIViewController+UIImagePicker.h"
#import <UIAlertView-Blocks/UIActionSheet+Blocks.h>

@implementation UIViewController (UIImagePicker)

- (void)startPickerImage {
    UIActionSheet *choiceSheet = [[UIActionSheet alloc] initWithTitle:@"相片选取" cancelButtonItem:[RIButtonItem itemWithLabel:@"取消"] destructiveButtonItem:nil
                                                     otherButtonItems:[RIButtonItem itemWithLabel:@"拍照" action:^{
        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
            if ([self isFrontCameraAvailable]) {
                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
            }
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }], [RIButtonItem itemWithLabel:@"从相册中选取" action:^{
        if ([self isPhotoLibraryAvailable]) {
            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
            controller.mediaTypes = mediaTypes;
            controller.delegate = self;
            [self presentViewController:controller
                               animated:YES
                             completion:^(void){
                                 NSLog(@"Picker View Controller is presented");
                             }];
        }
    }], nil];
    
    [choiceSheet showInView:self.view];
}

-(void)endLoadOriginalImage:(UIImage *)img
{
    
}

//#pragma mark UIActionSheetDelegate
//- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
//    if (buttonIndex == 0) {
//        // 拍照
//        if ([self isCameraAvailable] && [self doesCameraSupportTakingPhotos]) {
//            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//            controller.sourceType = UIImagePickerControllerSourceTypeCamera;
//            if ([self isFrontCameraAvailable]) {
//                controller.cameraDevice = UIImagePickerControllerCameraDeviceFront;
//            }
//            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//            controller.mediaTypes = mediaTypes;
//            controller.delegate = self;
//            [self presentViewController:controller
//                               animated:YES
//                             completion:^(void){
//                                 NSLog(@"Picker View Controller is presented");
//                             }];
//        }
//        
//    } else if (buttonIndex == 1) {
//        // 从相册中选取
//        if ([self isPhotoLibraryAvailable]) {
//            UIImagePickerController *controller = [[UIImagePickerController alloc] init];
//            controller.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//            NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
//            [mediaTypes addObject:(__bridge NSString *)kUTTypeImage];
//            controller.mediaTypes = mediaTypes;
//            controller.delegate = self;
//            [self presentViewController:controller
//                               animated:YES
//                             completion:^(void){
//                                 NSLog(@"Picker View Controller is presented");
//                             }];
//        }
//    }
//}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [picker dismissViewControllerAnimated:YES completion:^() {
        
        NSString *mediaType = [info objectForKey: UIImagePickerControllerMediaType];
        if ([mediaType isEqualToString:(NSString *)kUTTypeImage]) {
            UIImage* editedImage = [info objectForKey:UIImagePickerControllerOriginalImage]; //获取用户编辑之后的图像
            [self endLoadOriginalImage:editedImage];
        }
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:^(){
    }];
}



#pragma mark camera utility
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isRearCameraAvailable{
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear];
}

- (BOOL) isFrontCameraAvailable {
    return [UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront];
}

- (BOOL) doesCameraSupportTakingPhotos {
    return [self cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable:
            UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickVideosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeMovie sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self
            cameraSupportsMedia:(__bridge NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0) {
        return NO;
    }
    NSArray *availableMediaTypes = [UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock: ^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
    }];
    return result;
}


@end
