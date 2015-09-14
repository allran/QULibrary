//
//  QUClient.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/24.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUClient.h"
#import "NSUserDefaults+Additons.h"



//#pragma mark -
//@implementation NSMutableDictionary (APIClient_Additions)
//
//-(void)addTableParamWithIndex:(int)index
//{
//    [self setValue:StringWithInt(index) forKey:@"offset"]; //第几页
//    if (index != kTableAllDataNumber)
//        [self setValue:StringWithInteger(UserDefaults().tablePageRow) forKey:@"limit"]; //每一次取20条数据
//}
//
//@end


#pragma mark -
@interface QUClient ()
- (void)cancelHttpOpretion:(AFHTTPRequestOperation *)http;
- (void)addConnection:(AFHTTPRequestOperation *)operation group:(NSString *)key;
- (void)removeConnection:(AFHTTPRequestOperation *)operation group:(NSString *)key;

@end



#pragma mark -
@implementation QUClient

+ (instancetype)sharedClient {
    static QUClient *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[QUClient alloc] initWithBaseURL:[NSURL URLWithString:UserDefaults().apiBaseURL]];
    });
    return _sharedClient;
}

- (instancetype)initWithBaseURL:(NSURL *)url {
    self = [super initWithBaseURL:url];
    if (self) {
        //self.requestSerializer = [AFJSONRequestSerializer serializer];
        //self.responseSerializer = [AFJSONResponseSerializer serializer];
        self.requestSerializer.HTTPShouldHandleCookies = YES;
        self.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html", nil];
        //self.requestSerializer = [AFHTTPRequestSerializer serializer];
        self.responseSerializer = [AFHTTPResponseSerializer serializer];
        self.conDic = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark -
- (void)cancelHttpOpretion:(AFHTTPRequestOperation *)http
{
    for (NSOperation *operation in [self.operationQueue operations]) {
        if (![operation isKindOfClass:[AFHTTPRequestOperation class]]) {
            continue;
        }
        if ([operation isEqual:http]) {
            [operation cancel];
            break;
        }
    }
}

- (void)addConnection:(AFHTTPRequestOperation *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr == nil)
        arr = [[NSMutableArray alloc] init];
    [arr addObject:operation];
    
    if (key==nil || key.length==0)
        key = @"defaultKey";

    [self.conDic setObject:arr forKey:key];
}

- (void)removeConnection:(AFHTTPRequestOperation *)operation group:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if ([arr containsObject:operation]) {
        [arr removeObject:operation];
        [self.conDic setObject:arr forKey:key];
    }
}

- (void)removeConnections:(NSString *)key
{
    NSMutableArray *arr = [self.conDic objectForKey:key];
    if (arr != nil) {
        for (AFHTTPRequestOperation *operation in arr)
            [self cancelHttpOpretion:operation];
        [self.conDic removeObjectForKey:key];
    }
}


#pragma mark -

-(void)urlType:(kURLLinkType)type groupKey:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback
{
    id operation = nil;
    if (type == kURLLink_GET) {
        operation = [self GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            callback(nil, responseObject);
            [self removeConnection:operation group:key];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self removeConnection:operation group:key];
            callback(error, nil);
        }];
    } else if (type == kURLLink_POST) {
        operation = [self POST:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
            callback(nil, responseObject);
            [self removeConnection:operation group:key];
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            [self removeConnection:operation group:key];
            callback(error, nil);
        }];
    }
    [self addConnection:operation group:key];
}


-(void)urlType:(kURLLinkType)type group:(NSObject *)tag path:(NSString *)URLString parameters:(id)parameters call:(void (^)(NSError *error, id responseObject))callback
{
    [self urlType:type groupKey:NSStringFromClass([tag class]) path:URLString parameters:parameters call:^(NSError *error, id responseObject) {
        callback(error, responseObject);
    }];
}



-(void)postWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlockBack:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(NSError *error, id responseObject))callback
{
    id operation = nil;
    operation = [self POST:URLString parameters:parameters constructingBodyWithBlock:block success:^(AFHTTPRequestOperation *operation, id responseObject) {
        callback(nil, responseObject);
        [self removeConnection:operation group:key];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [self removeConnection:operation group:key];
        callback(error, nil);
    }];
    [self addConnection:operation group:key];
}


//-(void)postWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters constructingBodyWithBlock:(void (^)(id <AFMultipartFormData> formData))block call:(void (^)(RespInfo* info))callback
//{
//    [self postWithGroup:key path:URLString parameters:parameters constructingBodyWithBlockBack:block call:^(NSError *error, id responseObject) {
//        if (error == nil) {
//            [self encodeWithObj:responseObject call:^(RespInfo *info) {
//                callback(info);
//            }];
//        } else
//            callback([RespInfo infoWithError:error]);
//    }];
//}
//
//
//-(void)getWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters  call:(void (^)(RespInfo* info))callback
//{
//    [self urlType:kURLLink_GET group:key path:URLString parameters:parameters call:^( RespInfo *info) {
//        callback(info);
//    }];
//}
//
//-(void)postWithGroup:(NSString *)key path:(NSString *)URLString parameters:(id)parameters call:(void (^)(RespInfo* info))callback
//{
//    [self urlType:kURLLink_POST group:key path:URLString parameters:parameters  call:^( RespInfo *info) {
//        callback(info);
//    }];
//}
//
//
//-(void)tableListGroup:(NSString *)key path:(NSString *)URLString parameters:(NSMutableDictionary *)parameters index:(int)index subClass:(Class)aClass call:(TableBlock)callback
//{
//    if (parameters == nil)
//        parameters = [NSMutableDictionary dictionary];
//    [parameters addTableParamWithIndex:index];
//    [self postWithGroup:key path:URLString parameters:parameters call:^( RespInfo *info) {
//        [self encodeWithObj:info.data info:info jsonTotalCountKey:@"totalcount" jsonListKey:@"list" subClass:aClass tableCall:^(int totalCount, NSArray *tableArr, RespInfo *info) {
//            callback(totalCount, tableArr, info);
//        }];
//    }];
//}
//
//-(void)tableListGroup:(NSString *)key path:(NSString *)URLString parameters:(NSMutableDictionary *)parameters subClass:(Class)aClass call:(TableBlock)callback
//{
//    [self tableListGroup:key path:URLString parameters:parameters index:kTableAllDataNumber subClass:aClass call:^(int totalpage, NSArray *tableArr, RespInfo *info) {
//        callback(totalpage, tableArr, info);
//    }];
//}
//
//#pragma mark -
//-(void)encodeWithObj:(id)responseObject call:( void(^)(RespInfo* info))callback
//{
//    NSString *result = [[NSString alloc] initWithData:responseObject  encoding:NSUTF8StringEncoding];
//    RespInfo *info = [RespInfo objectWithKeyValues:responseObject];
//    callback(info);
////    [info loadStatus];
////    if (info.state==UserDefaults().successNumber)
////        callback(info.data, info);
////    else
////        callback(nil, info);
//}
//
//-(void)encodeWithObj:(id)obj info:(RespInfo *)info  statusCall:(StatusBlock)callback
//{
//    if (info.state!=UserDefaults().successNumber || obj==nil) {
//        callback(NO, info);
//    } else {
//        id stat = [obj objectWithKey:@"resultStatus"];
//        if (stat != nil)
//            callback([stat boolValue], info);
//        else
//            callback(info.state, info);
//    }
//}
//
//-(void)encodeWithObj:(id)obj info:(RespInfo *)info jsonTotalCountKey:(NSString *)countKey jsonListKey:(NSString *)listKey subClass:(Class)aClass tableCall:(TableBlock)callback {
//    int newPage = kNoneNumber;
//    NSArray *newArr = nil;
//    if (info.state == UserDefaults().successNumber) {
//        if (countKey.length > 0)
//            newPage = [[obj objectWithKey:countKey] intValue];
//        
//        NSArray *list = [obj objectWithKey:listKey];
//        if (list.count > 0)
//            newArr = [aClass objectArrayWithKeyValuesArray:list];
//    }
//    callback(newPage, newArr, info);
//}


@end
