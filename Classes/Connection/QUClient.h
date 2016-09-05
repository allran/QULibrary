//
//  QUClient.h
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/24.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>
#import "QUObject.h"
#import "QUCustomDefine.h"


typedef enum : int {
    kURLLink_GET        = 0,        //
    kURLLink_POST       = 1         //
} kURLLinkType;  //


//typedef void (^SuccessBlock)(BOOL success, NSString* errStr);
//typedef void (^StatusBlock)(BOOL status, RespInfo *info);
//typedef void (^ObjectBlock)(id obj, RespInfo *info);
//typedef void (^TableBlock)(int totalCount, NSArray *tableArr, RespInfo* info);



//@interface NSMutableDictionary (APIClient_Additions)
//-(void)addTableParamWithIndex:(int)index;
//@end


@interface QUClient : AFHTTPSessionManager
@property(nonatomic, strong) NSMutableDictionary *conDic;//存网络链接，便于取消

+ (instancetype)sharedClient;


/**
 *  清除所有的所属组链接
 *
 *  @param key 网络链接所属于的组
 */
- (void)removeConnections:(NSString *)key;



/**
 *  链接总方法
 *
 *  @param type       url方式
 *  @param key        网络链接所属于的组
 *  @param URLString  请求链接path
 *  @param parameters 参数
 *  @param callback   返回网络数据
 */
-(void)urlType:(kURLLinkType)type groupKey:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback;
-(void)urlType:(kURLLinkType)type group:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback;


/**
 *  Post链接上传文件总方法
 *
 *  @param key        网络链接所属于的组
 *  @param URLString  请求链接path
 *  @param parameters 参数
 *  @param block      上传数据
 *  @param callback   返回网络数据
 */
-(void)postWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback;


///**
// *  Get链接总方法
// *
// *  @param key        网络链接所属于的组
// *  @param URLString  请求链接
// *  @param parameters 参数
// *  @param callback   返回网络数据
// */
//-(void)getWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters  call:(void (^)(RespInfo* info))callback;
//
//
///**
// *  Post链接总方法
// *
// *  @param key        网络链接所属于的组
// *  @param URLString  请求链接
// *  @param parameters 参数
// *  @param callback   返回网络数据
// */
//-(void)postWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(RespInfo* info))callback;
//
//
///**
// *  多页表格链接方法
// *
// *  @param key        网络链接所属于的组
// *  @param URLString  请求链接
// *  @param parameters 参数
// *  @param index      页码数
// *  @param aClass     返回数据解析对象
// *  @param callback   返回表格数据
// */
//-(void)tableListGroup:(NSString *)key path:(NSString *)URLString parameters:(NSMutableDictionary *)parameters index:(int)index subClass:(Class)aClass call:(TableBlock)callback;
//
//
///**
// *  单页表格链接方法
// *
// *  @param key        网络链接所属于的组
// *  @param URLString  请求链接
// *  @param parameters 参数
// *  @param aClass     返回数据解析对象
// *  @param callback   返回表格数据
// */
//-(void)tableListGroup:(NSString *)key path:(NSString *)URLString parameters:(NSMutableDictionary *)parameters subClass:(Class)aClass call:(TableBlock)callback;
//
//
//
//-(void)encodeWithObj:(id)responseObject call:( void(^)(RespInfo* info))callback;
//-(void)encodeWithObj:(id)obj info:(RespInfo *)info  statusCall:(StatusBlock)callback;
//-(void)encodeWithObj:(id)obj info:(RespInfo *)info jsonTotalCountKey:(NSString *)countKey jsonListKey:(NSString *)listKey subClass:(Class)aClass tableCall:(TableBlock)callback;


@end
