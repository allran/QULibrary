//
//  QUObject.h
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/24.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <LKDBHelper/LKDBHelper.h>
#import <MJExtension/MJExtension.h>
#import "NSUserDefaults+Additons.h"
#import "QUCustomDefine.h"

//列表没有分页取全部数据时，page=-1,
//第一次加载时page=0,
//重新下拉刷新时page=1,
//上拉更多时page++)
const static int kTableAllDataNumber = -1;  //
const static int kTableFirstDataNumber = 0;  //
const static int kTableReloadDataNumber = 1;  //

const static int kNoneNumber = -1000;  //定义无用的初始值
const static int kSuccessNumber = 200;  //定义的成功返回值
const static int kFailNumber = 500;  //定义的失败返回值


#pragma mark - NSDictionary
@interface NSDictionary (QUAdditions)
-(id)objectWithKey:(id)aKey; //返回有效值
-(NSString *)objectStrWithKey:(id)key;  //返回key值的字符串
@end

@interface NSMutableDictionary (QUAdditions)
- (void)setNeedStr:(NSString *)anObject forKey:(id)aKey;  //设置必须有的值
- (void)setValidStr:(NSString *)anObject forKey:(id)aKey;  //当值不为空时，设置该值
- (void)setInt:(int)anObject forKey:(id)aKey;
- (void)setBool:(BOOL)anObject forKey:(id)aKey;
@end





#pragma mark - NSObject
@interface NSObject (BVJSONString)

/**
 *  json对象字符串化
 *
 *  @param prettyPrint prettyPrint
 *
 *  @return 返回object的字符串
 */
- (NSString *)bv_jsonStringWithPrettyPrint:(BOOL)prettyPrint;


/**
 *  处理判断两个对象值是否相等
 *
 *  @param object 匹配对象object
 *
 *  @return 返回bool值
 */
+(BOOL)isValueEqual:(id)object;


/**
 *  把该对象object的数组集插入到db中
 *
 *  @param arr object的arr
 */
+(void)arrInsertToDB:(NSArray *)arr;

/**
 *  把该对象object拷贝为另一个对象
 *
 *  @param obj 当前需要拷贝的对象数据
 */
+(instancetype)copyNewWithObj:(id)obj;

- (NSString *)classString;

@end


#pragma mark - QUObject
@interface QUObject : NSObject

@end


//#pragma mark - RespInfo  外层封装数据
//@interface RespInfo : NSObject
//@property (nonatomic,strong) id                 data;         //正文
//@property (nonatomic,strong) id                 message;   //错误消息
//@property (nonatomic,assign) id                state;         //非0表示 错误,调试使用
//+(RespInfo *)infoWithError:(NSError *)error;
//+(RespInfo *)infoWithErrorMessage:(NSString *)errMsg;
//-(void)loadStatus;
//@end

