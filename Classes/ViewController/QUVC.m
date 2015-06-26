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
}

-(void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
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


@end
