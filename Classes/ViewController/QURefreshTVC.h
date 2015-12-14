//
//  EGORefreshTVC.h
//  Shipping
//
//  Created by apple on 12-10-25.
//
//

#import "QUTVC.h"
#import <MJRefresh/MJRefresh.h>


@interface QURefreshTVC : QUTVC {

}
@property(nonatomic,assign) BOOL                beginHeaderRereshingWhenViewWillAppear;

@property(nonatomic,assign) int                 startId;

/**
 *  代码调用开始下拉刷新（有上拉或者下拉时调用）
 */
-(void)beginHeaderRereshing;


/**
 *  刷新时调用方法
 */
- (void)reloadTableViewDataSource;

/**
 *  完成刷新时调用方法
 */
- (void)doneLoadingTableViewData;

/**
 *  开始头部刷新时的处理
 */
-(void)loadHeaderRefreshing;

/**
 *  结束头部刷新时的处理
 */
-(void)doneHeaderRereshing;

/**
 *  当接口取到数据时调用--把接口数据加入tabArr里面
 *
 *  @param tablearr 传入的列表对象数组
 *  @param info     错误信息
 */
//- (void)reloadWithTableArr:(NSArray *)tablearr errInfo:(RespInfo*) info;
@end
