//
//  UINavigationController+Custom.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/8/27.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "UINavigationController+Custom.h"
#import "QUCustomDefine.h"
@implementation UINavigationController (Custom)

-(void)loadCustomStyleWithColor:(UIColor *)color
{
    self.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    self.navigationBar.tintColor = color;
    self.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationBar.translucent = NO;
    if (SystemIsiOS7()) {
        self.navigationBar.barTintColor = color;
        self.navigationBar.tintColor = [UIColor whiteColor];
    }
    //[nav.navigationBar setBackgroundImage:IMG(@"tab_bg.png") forBarMetrics:UIBarMetricsDefault];
}

@end
