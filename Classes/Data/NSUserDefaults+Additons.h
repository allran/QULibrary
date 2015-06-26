//
//  NSUserDefaults+Settings.h
//  RaoooScore
//
//  Created by 瞿 伦平 on 13-12-31.
//  Copyright (c) 2013年 Allran. All rights reserved.
//

#import <Foundation/Foundation.h>

#define UserDefaults()                              [NSUserDefaults standardUserDefaults]


@interface NSUserDefaults (Additons)


@property(nonatomic,strong) NSString*               deviceID;                    //设备号,默认:test111
@property(nonatomic,strong) NSString*               userToken;                 //用户token值
@property(nonatomic,assign) NSTimeInterval          userLost;                 //用户的token过期时间戳

@property(nonatomic,strong) NSString*               apiBaseURL;                 //用户接口链接基础url

@property(nonatomic,assign) NSInteger               tablePageRow;                 //每次页面调用20条数据
@property(nonatomic,assign) NSInteger               successNumber;                 //定义的成功返回值

- (void)qu_registerDefaults;    //设置默认数据

@end
