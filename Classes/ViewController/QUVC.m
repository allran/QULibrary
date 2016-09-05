//
//  QUVC.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/24.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUVC.h"

@interface QUVC ()

@end


@implementation QUVC
- (id)init
{
    self = [super init];
    if (self) {

    }
    return self;
}

-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = COLOR(243, 243, 243);
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    [SVProgressHUD dismiss];
    if ([self.navigationController.viewControllers indexOfObject:self] == NSNotFound)
        [self cancelConnections];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    MLLog_VC("viewDidUnload");
    [self cancelConnections];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [self cancelConnections];
}



-(NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait ;
}
- (BOOL)shouldAutorotate
{
    return NO;
}
-(UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

@end
