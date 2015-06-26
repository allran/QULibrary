//
//  ViewController.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/24.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "ViewController.h"
#import "RefreshTVCTest.h"
#import "TableRefreshPageTVCTest.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 100, 100, 100);
    [btn setTitle:@"111" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(pushMethod:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(100, 300, 100, 100);
    [btn setTitle:@"222" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(push1Method:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)pushMethod:(id)sender
{
    RefreshTVCTest *vc  = [[RefreshTVCTest alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)push1Method:(id)sender
{
    TableRefreshPageTVCTest *vc  = [[TableRefreshPageTVCTest alloc] initWithStyle:UITableViewStylePlain];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
