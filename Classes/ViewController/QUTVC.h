//
//  QUTVC.h
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/25.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUVC.h"



@interface QUTVC : QUVC <UITableViewDataSource, UITableViewDelegate> {
    UITableViewCellSeparatorStyle tableSeparatorStyle;
    UITableViewStyle    tableStyle;
}
@property(nonatomic,assign) BOOL				 tableIsReloading;
@property(nonatomic,strong) NSMutableArray      *tableOrderArr;
@property(nonatomic,strong) NSMutableDictionary *tableDic;
@property(nonatomic,strong) NSMutableArray      *tableArr;
@property(nonatomic,strong) UITableView         *tableView;
@property(nonatomic,strong) NSString            *errMsg;//错误信息输出

- (id)initWithStyle:(UITableViewStyle)style;




@end