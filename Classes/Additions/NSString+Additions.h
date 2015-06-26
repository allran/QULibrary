//
//  NSString+Additions.h
//  MalaClient
//
//  Created by uncle Blue on 11-6-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <UIKit/UIKit.h>
@interface NSString (aaAdditions)

+ (NSString*)base64encode:(NSString*)str;
+ (NSString *)md5:(NSString *)str;


+ (BOOL)isMobileNumber:(NSString *)mobileNum;//检测是否是手机号码

//- (CGFloat)heightForTextWidth:(float)width;
- (NSString *)dateStringWithLongFormat:(BOOL)flag;
- (NSString *)timeIntervalStringWithFormatterString:(NSString *)formatterString;
- (NSString *)hanZiDateString;
//- (int)widthFromTextString;

+ (NSString *)localDateStringWithTimeInterval:(NSTimeInterval)timeInterval;


+(NSString *)LastLognDateWithStr:(NSString *)dateStr;
@end
