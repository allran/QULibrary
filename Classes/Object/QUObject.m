//
//  QUObject.m
//  QULibraryDemo
//
//  Created by 瞿伦平 on 15/6/24.
//  Copyright (c) 2015年 瞿伦平. All rights reserved.
//

#import "QUObject.h"



#pragma mark -
#pragma mark NSDictionary
@implementation NSDictionary (Additions)
-(id)objectWithKey:(NSString *)key
{
    id obj = [self objectForKey:key];
    if ([obj isEqual:[NSNull null]]) {
        obj = nil;
    }
    return obj;
}
@end



#pragma mark -
#pragma mark NSObject
@implementation NSObject (BVJSONString)
-(NSString*) bv_jsonStringWithPrettyPrint:(BOOL) prettyPrint {
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:self
                                                       options:(NSJSONWritingOptions) (prettyPrint ? NSJSONWritingPrettyPrinted : 0)
                                                         error:&error];
    NSString *str = @"";
    if (! jsonData) {
        NSLog(@"bv_jsonStringWithPrettyPrint: error: %@", error.localizedDescription);
        if ([self isKindOfClass:[NSArray class]])
            str = @"[]";
        else if ([self isKindOfClass:[NSDictionary class]])
            str = @"{}";
    } else {
        str = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    }
    return str;
}

+(BOOL)isValueEqual:(id)object
{
    BOOL isEqual = YES;
    unsigned int outCount, i;
    objc_property_t *properties = class_copyPropertyList([self class], &outCount);
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        NSString *propertyName = [NSString stringWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        id propValue = [self valueForKey:propertyName];
        if (![propValue isEqual:[object valueForKey:propertyName]]) {
            isEqual = NO;
            break;
        }
    }
    free(properties);
    if([self superclass] != [NSObject class])
        [[self superclass] isValueEqual:object];
    return YES;
}


////重载选择 使用的LKDBHelper
//+(LKDBHelper *)getUsingLKDBHelper
//{
//    static LKDBHelper* db;
//    static dispatch_once_t onceToken;
//    dispatch_once(&onceToken, ^{
//        NSString* dbpath = [NSHomeDirectory() stringByAppendingPathComponent:@"db/mydata.db"];
//        db = [[LKDBHelper alloc] initWithDBPath:dbpath];
//        db.encryptionKey = @"allran.mine";
//    });
//    return db;
//}

+(void)arrInsertToDB:(NSArray *)arr
{
    Class clazz = [self class];
    //LKDBHelper* globalHelper = [clazz getUsingLKDBHelper];
    [LKDBHelper clearTableData:clazz];
    [clazz insertToDBWithArray:arr filter:^(id model, BOOL inserted, BOOL *rollback) {}];
    //    [globalHelper executeDB:^(FMDatabase *db) {
    //        [db beginTransaction];
    //        for (id item in arr) {
    //            [globalHelper insertToDB:item];
    //        }
    //        [db commit];
    //    }];
}

- (NSString *)classString
{
    NSString *key = NSStringFromClass(self.class);
    return key;
}

@end




@implementation QUObject

@end





//#pragma mark -
//#pragma mark RespInfo
//@implementation RespInfo
//
//+ (void)initialize
//{
//    [super initialize];
//    //[self bindYYJSONKey:@"response" toProperty:@"state"];
//}
//+(RespInfo *)infoWithError:(NSError *)error
//{
//    RespInfo *info = [[RespInfo alloc] init];
//    info.message       = @"网络请示失败，请检查网络";
//    return info;
//}
//
//+(RespInfo *)infoWithErrorMessage:(NSString *)errMsg
//{
//    RespInfo *info = [[RespInfo alloc] init];
//    info.message       = errMsg;
//    return info;
//}
//
//-(void)loadStatus
//{
//
////    if (self.data == nil) {
////        if (self.state != UserDefaults().successNumber)
////            self.state = kNoneNumber;
////        if (self.message == nil)
////            self.message = @"无数据";
////    } else {
////        if ([self.data isKindOfClass:[NSDictionary class]]) {
////            id result = [self.data objectForKey:@"resultStatus"];
////            if (result) {
////                BOOL boolResult = [result boolValue];
////                if (boolResult)
////                    self.state = kSuccessNumber;
////                else
////                    self.state = kFailNumber;
////            }
////        }
////    }
//}
//
//@end
