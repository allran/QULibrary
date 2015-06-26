//
//  EGORefreshPageTVC.h
//  SpecialFriends
//
//  Created by apple on 13-1-24.
//  Copyright (c) 2013年 apple. All rights reserved.
//

#import "QURefreshTVC.h"
#import <MJRefresh/MJRefresh.h>

@interface QURefreshPageTVC : QURefreshTVC {

}

/**
 *  开始底部刷新时的处理
 */
-(void)loadFooterRefreshing;


/**
 *  结束底部刷新时的处理
 */
-(void)doneFooterRereshing;

/**
 *  当接口取到数据时调用--把接口数据加入tabArr里面
 *
 *  @param tablearr  传入的列表对象数组
 *  @param totalpage 总页面
 *  @param info      错误信息
 */
- (void)reloadWithTableArr:(NSArray *)tablearr totalIndex:(int)index  errInfo:(RespInfo*) info;

@end
