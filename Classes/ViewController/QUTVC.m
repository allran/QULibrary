//
//  QUTVC.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/25.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUTVC.h"
@implementation QUTVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [self initData];
    }
    return self;
}

-(void)initData
{
    self.tableArr = [NSMutableArray array];
    self.tableDic = [NSMutableDictionary dictionary];
    self.tableOrderArr = [NSMutableArray array];
    
    tableStyle = UITableViewStylePlain;
    tableSeparatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _tableIsReloading = NO;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [self init];
    if (self) {
        tableStyle = style;
    }
    return self;
}


-(void)loadView
{
    [super loadView];
    
    if (self.tableView==nil ) {
        CGFloat height = DEVICE_Height;
        if (self.navigationController.navigationBarHidden == NO) {
            height = DEVICE_InNavBar_Height;
        }
        self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, DEVICE_Width, height) style:tableStyle];
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.view addSubview:self.tableView];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.tableView.tableFooterView = [[UIView alloc] init];
        
        [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(self.view);
            make.height.equalTo(self.view.height);
        }];
    }
}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark -
#pragma mark Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (_tableIsReloading)
        return 0;
    else
        return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (_tableIsReloading)
        return 44;
    else
        return 50;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell_Something";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        cell.editing = NO;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.textLabel.font = [UIFont systemFontOfSize:12];
    }
    
    if (_tableIsReloading)
        cell.textLabel.text = @"";
    else
        cell.textLabel.text = self.errMsg;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


@end
