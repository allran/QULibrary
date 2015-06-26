//
//  View1VC.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/25.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "RefreshTVCTest.h"

@implementation RefreshTVCTest

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableArr.count > 0)
        return self.tableArr.count;
    return [super tableView:tableView numberOfRowsInSection:section];
}

//- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return UITableViewAutomaticDimension;
//}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.tableArr.count > 0) {
        NSString *aa = @"sdfafasdf";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:aa];
        if (cell == nil) {
            cell= [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:aa];
            cell.backgroundColor = [UIColor clearColor];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.textLabel.text = [self.tableArr objectAtIndex:indexPath.row];
        return cell;
    }
    
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}




-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

}

-(void)loadData
{
    NSMutableArray *arr = [NSMutableArray array];
    for (int i=0; i<20; i++) {
        [arr addObject:[NSString stringWithFormat:@"row-number-%i", i]];
    }
    RespInfo *info = [[RespInfo alloc] init];
    info.state = 200;
    [self reloadWithTableArr:arr errInfo:info];
}
-(void)reloadTableViewDataSource
{
    [super reloadTableViewDataSource];
    
    [self performSelector:@selector(loadData) withObject:nil afterDelay:0.5];

}

@end
