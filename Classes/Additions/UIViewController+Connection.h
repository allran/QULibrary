//
//  UIViewController+Connection.h
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/25.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface UIViewController (Connection)


/**
 *  取消当前vc的所有网络链接
 */
- (void)cancelConnections;



/**
 *  取消当前链接 &&
 *
 *  @param viewController 视图vc
 *  @param animated       是否动画
 */
/**
 *  push到下一个vc
 *
 *  @param viewController 视图vc
 *  @param animated       是否动画
 *  @param isCancel       是否取消当前vc的网络链接
 */
- (void)quPushViewController:(UIViewController *)viewController animated:(BOOL)animated isCancelConnections:(BOOL)isCancel;

/**
 *  pop到上一个vc
 *
 *  @param animated 是否动画
 *
 *  @return Returns the popped controller.
 */
- (UIViewController *)quPopToFatherViewControllerAnimated:(BOOL)animated;
- (UIViewController *)quPopToFatherViewControllerWithAnimated;



/**
 *  present到下一个vc
 *
 *  @param viewControllerToPresent 视图vc
 *  @param animated       是否动画
 *  @param isCancel       是否取消当前vc的网络链接
 */
-(void)quPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated isCancelConnections:(BOOL)isCancel;

-(void)quDismissViewControllerAnimated;

@end
