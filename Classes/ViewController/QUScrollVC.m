//
//  QUScrollVC.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/8/27.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUScrollVC.h"

@implementation QUScrollVC

-(void)loadView
{
    [super loadView];
    
    
    if (self.scrollView == nil) {
        self.scrollView = [self.view newUIScrollView];
        self.scrollView.showsHorizontalScrollIndicator = NO;
        self.scrollView.showsVerticalScrollIndicator = NO;
        self.scrollView.scrollEnabled = YES;
        self.scrollView.backgroundColor = [UIColor clearColor];
        self.scrollView.translatesAutoresizingMaskIntoConstraints  = NO;
        
        [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.width.equalTo(self.view.width);
        }];
        
        UIView *contentView = [self.scrollView newUIView];
        contentView.tag = 101;
        contentView.backgroundColor = [UIColor clearColor];
        contentView.translatesAutoresizingMaskIntoConstraints = NO;
        self.contentView = contentView;
        [contentView makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(_scrollView);
            make.width.equalTo(_scrollView);
            //make.height.equalTo(_scrollView);
        }];
    }
    
}

@end
