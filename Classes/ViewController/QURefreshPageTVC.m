//
//  EGORefreshPageTVC.m
//  SpecialFriends
//
//  Created by apple on 13-1-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "QURefreshPageTVC.h"

@interface QURefreshPageTVC ()

@end

@implementation QURefreshPageTVC

- (id)init
{
    self = [super init];
    if (self) {
//        页码数(传入参数时：
//            列表没有分页取全部数据时，page=-1,
//            第一次加载时page=0,
//            重新下拉刷新时page=1,
//            上拉更多时page++)
        self.startId = kTableFirstDataNumber;
    }
    return self;
}


#pragma mark - view Method
- (void)loadView
{
    [super loadView];
    
    __weak typeof(self) weakSelf = self;

    // 设置回调（一旦进入刷新状态，就调用target的action，也就是调用self的loadMoreData方法）
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadFooterRefreshing];
    }];
    footer.automaticallyRefresh = NO;  // 禁止自动加载
    footer.refreshingTitleHidden = YES;
    self.tableView.footer = footer;
    
    self.tableView.footer.hidden = YES;
}

 
#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

-(void)beginHeaderRereshing
{
    self.startId = kTableFirstDataNumber;
    [super beginHeaderRereshing];
}

-(void)loadHeaderRefreshing
{
    self.tableView.footer.hidden = YES;
    if (self.startId != kTableFirstDataNumber)
        self.startId = kTableReloadDataNumber;
    [super loadHeaderRefreshing];
}

-(void)loadFooterRefreshing
{
    self.tableIsReloading = YES;
    [self reloadTableViewDataSource];
}

-(void)doneHeaderRereshing
{
    if (self.tableArr.count>0 || self.tableDic.count>0)
        self.tableView.footer.hidden = NO;
    else
        self.tableView.footer.hidden = YES;
    
    [super doneHeaderRereshing];
}

-(void)doneFooterRereshing
{
    self.tableIsReloading = NO;
    [self.tableView reloadData];
    [self.tableView.footer endRefreshing];
}

- (void)doneLoadingTableViewData
{
    if (self.startId==kTableFirstDataNumber || self.startId==kTableReloadDataNumber)
        [self doneHeaderRereshing];
    else
        [self doneFooterRereshing];
}


//- (void)reloadWithTableArr:(NSArray *)tablearr totalIndex:(int)index  errInfo:(RespInfo*) info
//{
//
//    if (self.startId == kTableFirstDataNumber)
//        self.startId = kTableReloadDataNumber;
//    int temIndex = self.startId;
//    temIndex ++;
//    if (temIndex*UserDefaults().tablePageRow >= index)
//        self.tableView.footer.state = MJRefreshStateNoMoreData;
//    else
//        self.tableView.footer.state = MJRefreshStateIdle;
//    
//    if (!info.state==UserDefaults().successNumber) {
//        self.errMsg = info.message!=nil ? info.message : @"网络错误";
//        
//    } else {
//        if (tablearr.count > 0) {
//            if (self.startId <= kTableReloadDataNumber) {
//                [self.tableArr removeAllObjects];
//                self.tableArr = [tablearr mutableCopy];
//            } else
//                [self.tableArr addObjectsFromArray:tablearr];
//        } else
//            self.errMsg = @"暂无数据";
//    }
//    [self doneLoadingTableViewData];
//    
//    self.startId = temIndex;
//}



@end
