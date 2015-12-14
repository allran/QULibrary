//
//  EGORefreshTVC.m
//  Shipping
//
//  Created by apple on 12-10-25.
//
//

#import "QURefreshTVC.h"

@interface QURefreshTVC ()
@end

@implementation QURefreshTVC
- (id)init
{
    self = [super init];
    if (self) {
        self.startId = kTableAllDataNumber;
        self.beginHeaderRereshingWhenViewWillAppear = YES;
    }
    return self;
}


#pragma mark - view Method
- (void)loadView
{
    [super loadView];

    __weak typeof(self) weakSelf = self;
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        [weakSelf loadHeaderRefreshing];
    }];
    self.tableView.header = header;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (tableSeparatorStyle != self.tableView.separatorStyle)
        tableSeparatorStyle = self.tableView.separatorStyle;
    
    if (self.tableArr.count == 0 && _beginHeaderRereshingWhenViewWillAppear==YES)
        [self performSelector:@selector(beginHeaderRereshing) withObject:nil afterDelay:0.1];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    if (self.tableIsReloading == YES)
        [self doneLoadingTableViewData];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -
#pragma mark Table view data source
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.tableArr.count > 0)
        return self.tableArr.count;
    return [super tableView:tableView numberOfRowsInSection:section];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}


#pragma mark -
#pragma mark Data Source Loading / Reloading Methods

-(void)beginHeaderRereshing
{
    [self.tableView.header beginRefreshing];
}

-(void)loadHeaderRefreshing
{
    self.tableIsReloading = YES;
    [self reloadTableViewDataSource];
}


- (void)reloadTableViewDataSource
{

	self.tableIsReloading = YES;
    //[self.tableView reloadData];
}

-(void)doneHeaderRereshing
{
    self.tableIsReloading = NO;
    
    if (self.tableArr.count>0 || self.tableDic.count>0) {
        if (tableSeparatorStyle != self.tableView.separatorStyle)
            self.tableView.separatorStyle = tableSeparatorStyle;
    } else {
        tableSeparatorStyle = self.tableView.separatorStyle;
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    [self.tableView reloadData];
    
    [self.tableView.header endRefreshing]; // (最好在刷新表格后调用)调用endRefreshing可以结束刷新状态
}

- (void)doneLoadingTableViewData
{
    [self doneHeaderRereshing];
}


//- (void)reloadWithTableArr:(NSArray *)tablearr errInfo:(RespInfo*) info
//{
//    if (!info.state==UserDefaults().successNumber)
//        self.errMsg = info.message!=nil ? info.message : @"网络错误";
//    else {
//        if (tablearr.count > 0)
//            [self.tableArr setArray:tablearr];
//        else {
//            [self.tableArr removeAllObjects];
//            self.errMsg = @"暂无数据";
//        }
//    }
//    [self doneLoadingTableViewData];
//}



@end
