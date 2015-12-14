//
//  NSString+Additions.h
//  MalaClient
//
//  Created by uncle Blue on 11-6-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSString (aaAdditions)

NS_ASSUME_NONNULL_BEGIN
+ (NSString *)base64encode:(NSString *)str;
+ (NSString *)md5:(NSString *)str;


+ (BOOL)isMobileNumber:(NSString *)mobileNum;//检测是否是手机号码
+ (BOOL)isNomalMobileNumber:(NSString *)mobileNum;

//- (CGFloat)heightForTextWidth:(float)width;
- (NSString *)dateStringWithLongFormat:(BOOL)flag;
- (NSString *)timeIntervalStringWithFormatterString:(NSString *)formatterString;
- (NSString *)hanZiDateString;
//- (int)widthFromTextString;

+ (NSString *)localDateStringWithTimeInterval:(NSTimeInterval)timeInterval;


+(NSString *)LastLognDateWithStr:(NSString *)dateStr;

- (NSString *)URLEncodedString;
NS_ASSUME_NONNULL_END

@end





@interface NSTimeZone (QUTimeZoneCreation)

+ (nullable instancetype)timeZoneWithChinaSimple;

@end