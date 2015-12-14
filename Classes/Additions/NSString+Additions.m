//
//  NSString+Additions.m
//  MalaClient
//
//  Created by uncle Blue on 11-6-1.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NSString+Additions.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreFoundation/CoreFoundation.h>

#define Time_mm  60
#define Time_HH  (60*60)
#define Time_DD  (60*60*24)
#define Time_MM  (60*60*24*30)
#define Time_YY  (60*60*24*365)
static const char encodingTable[] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
#define DEFINE_NEW_ENUM(Type_, Values_)\
typedef enum { BOOST_PP_SEQ_ENUM(Values_) } Type_;\
size_t count(Type_) { return BOOST_PP_SEQ_SIZE(Values_); }

@implementation NSString (aaAdditions)

+ (NSString*)base64encode:(NSString*)str 
{
    if ([str length] == 0)
        return @"";
	
    const char *source = [str UTF8String];
    int strlength  = (int)strlen(source);
    
    char *characters = malloc(((strlength + 2) / 3) * 4);
    if (characters == NULL)
        return nil;
	
    NSUInteger length = 0;
    NSUInteger i = 0;
	
    while (i < strlength) {
        char buffer[3] = {0,0,0};
        short bufferLength = 0;
        while (bufferLength < 3 && i < strlength)
            buffer[bufferLength++] = source[i++];
        characters[length++] = encodingTable[(buffer[0] & 0xFC) >> 2];
        characters[length++] = encodingTable[((buffer[0] & 0x03) << 4) | ((buffer[1] & 0xF0) >> 4)];
        if (bufferLength > 1)
            characters[length++] = encodingTable[((buffer[1] & 0x0F) << 2) | ((buffer[2] & 0xC0) >> 6)];
        else characters[length++] = '=';
        if (bufferLength > 2)
            characters[length++] = encodingTable[buffer[2] & 0x3F];
        else characters[length++] = '=';
    }
    
    return [[NSString alloc] initWithBytesNoCopy:characters length:length encoding:NSASCIIStringEncoding freeWhenDone:YES];
}

+ (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ]; 
}



///// 手机号码的有效性判断
//检测是否是手机号码
+ (BOOL)isMobileNumber:(NSString *)mobileNum
{
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES))
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)isNomalMobileNumber:(NSString *)mobileNum
{
    NSString * MOBILE = @"^((13[0-9]{1})|130|131|132|133|134|135|136|137|138|139|141|142|143|144|145|146|147|148|149|150|151|152|153|155|156|157|158|159|177|180|181|182|183|184|185|186|187|188|189)+\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    return [regextestmobile evaluateWithObject:mobileNum];
}


- (NSString *)dateStringWithLongFormat:(BOOL)flag {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	
	NSString *time = [[[self componentsSeparatedByString:@"+"] objectAtIndex:0] substringFromIndex:6];
	NSTimeInterval second = [time doubleValue] / 1000; 
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:second];
	NSString *dateString = [formatter stringFromDate:date];
	//[formatter release];
	if (flag) {
		return [[dateString substringToIndex:16] substringFromIndex:6];
	}
	else {
		return [dateString substringWithRange:NSRangeFromString(@"{11, 5}")];
	}
}

+ (NSString *)localDateStringWithTimeInterval:(NSTimeInterval)timeInterval {
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MM月dd日 HH:mm"];
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
	NSString *dateString = [formatter stringFromDate:date];
	return dateString;
}

- (NSString *)hanZiDateString {
	NSString *ret;
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
	[formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
	NSString *time = [[[self componentsSeparatedByString:@"+"] objectAtIndex:0] substringFromIndex:6];
	NSTimeInterval origin = [time doubleValue] / 1000; 
	NSDate *date = [NSDate dateWithTimeIntervalSince1970:origin];
	NSString *dateString = [formatter stringFromDate:date];
	//[formatter release];
	
	//NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	//[dateFormatter setDateFormat:@"yyyy-MM-dd HH-mm-ss"];
	NSString *todayDateString = [NSString stringWithFormat:@"%@ 00:00:00", [[[NSDate date] description] substringToIndex:10]];
	NSDate *todayDate = [formatter dateFromString:todayDateString];
	NSTimeInterval today = [todayDate timeIntervalSince1970];
	//[formatter release];
	
	if (origin - today >= 0) {
		ret = [NSString stringWithFormat:@"今天 %@", [dateString substringWithRange:NSRangeFromString(@"{11, 5}")]];
	}
	else if (today - origin <= 86400) {
		ret = [NSString stringWithFormat:@"昨天 %@", [dateString substringWithRange:NSRangeFromString(@"{11, 5}")]];;
	}
	else {
		ret = [dateString substringWithRange:NSRangeFromString(@"{5, 11}")];
	}
	
	return ret;
}

- (NSString *)timeIntervalStringWithFormatterString:(NSString *)formatterString
{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:formatterString];
	NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"GMT"];
	[dateFormatter setTimeZone:timeZone];
	NSDate *date = [dateFormatter dateFromString:self];
	NSTimeInterval second = [date timeIntervalSince1970] * 1000;
	//[dateFormatter release];
	NSString *timeString = [NSString stringWithFormat:@"/Date(%.0f+0800)/", second];
	
	return timeString;
}





+(NSString *)LastLognDateWithStr:(NSString *)dateStr
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setLocale:[NSLocale currentLocale]];
    NSTimeZone* timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *date = [formatter dateFromString:dateStr];
    NSTimeInterval number = ABS([date timeIntervalSinceNow]);
    //[formatter release];
    NSString *title;
    NSInteger newNumber = 0;
    if (number < Time_mm) {
        title = @"现在";
    } else if (number>Time_mm && number<Time_HH) {
        newNumber = number/Time_mm;
        title = [NSString stringWithFormat:@"%li分钟前", (long)newNumber];
    } else if (number>Time_HH && number<Time_DD) {
        newNumber = number/Time_HH;
        title = [NSString stringWithFormat:@"%li小时前", (long)newNumber];
    } else if (number>Time_DD && number<Time_MM) {
        newNumber = number/Time_DD;
        title = [NSString stringWithFormat:@"%li天前", (long)newNumber];
    } else if (number>Time_MM && number<Time_YY) {
        newNumber = number/Time_MM;
        title = [NSString stringWithFormat:@"%li月", (long)newNumber];
    } else if (number>Time_YY) {
        newNumber = number/Time_YY;
        title = [NSString stringWithFormat:@"%li年", (long)newNumber];
    }
    return title;
}

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                            (CFStringRef)self,
                                            (CFStringRef)@"!$&'()*+,-./:;=?@_~%#[]",
                                            NULL,
                                            kCFStringEncodingUTF8));
    return encodedString;
}

@end




@implementation NSTimeZone (QUTimeZoneCreation)
+ (nullable instancetype)timeZoneWithChinaSimple
{
    return [NSTimeZone timeZoneWithName:@"GMT"];
}

@end
