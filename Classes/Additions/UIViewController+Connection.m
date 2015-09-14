//
//  UIViewController+Connection.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/25.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "UIViewController+Connection.h"
#import "QUClient.h"
@implementation UIViewController(Connection)

- (void)cancelConnections
{
    [[QUClient sharedClient] removeConnections:[self classString]];
}

- (void)quPushViewController:(UIViewController *)viewController animated:(BOOL)animated isCancelConnections:(BOOL)isCancel
{
    if (isCancel)
        [self cancelConnections];
    
    [self.navigationController pushViewController:viewController animated:YES];
}


- (UIViewController *)quPopToFatherViewControllerAnimated:(BOOL)animated
{
    [self cancelConnections];
    UIViewController *vc = [self.navigationController popViewControllerAnimated:animated];
    return vc;
}

- (UIViewController *)quPopToFatherViewControllerWithAnimated
{
    return [self quPopToFatherViewControllerAnimated:YES];
}



-(void)quPresentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)animated isCancelConnections:(BOOL)isCancel
{
    if (isCancel)
        [self cancelConnections];
    
    [self presentViewController:viewControllerToPresent animated:animated completion:^{}];
}


-(void)quDismissViewControllerAnimated
{
    [self cancelConnections];
    [self dismissViewControllerAnimated:YES completion:^{}];
}


@end
