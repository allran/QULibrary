//
//  NSDate+Utilities.h
//  CodeBox
//
//  Created by 杨兴军 on 14-9-26.
//  Copyright (c) 2014年 PhotoStudio Inc. All rights reserved.
//

/*!
 @header
 @abstract 日期的工具类。
 @author 杨兴军
 @version 1.0.0
 */

#import <Foundation/Foundation.h>

#define D_MINUTE    60
#define D_HOUR      3600
#define D_DAY       86400
#define D_WEEK      604800
#define D_YEAR      31556926

/*!
 @category
 @abstract NSDate扩展
 */
@interface NSDate (UtilitiesExtensions)

// Relative dates from the current date
+ (NSDate *)dateTomorrow;
+ (NSDate *)dateYesterday;
+ (NSDate *)dateWithDaysFromNow:(NSUInteger)days;
+ (NSDate *)dateWithDaysFromDate:(NSDate *)date days:(NSUInteger)days;
+ (NSDate *)dateWithDaysBeforeNow:(NSUInteger)days;
+ (NSDate *)dateWithDaysBeforeDate:(NSDate *)date days:(NSUInteger)days;
+ (NSDate *)dateWithHoursFromNow:(NSUInteger)dHours;
+ (NSDate *)dateWithDaysFromDate:(NSDate *)date hours:(NSUInteger)dHours;
+ (NSDate *)dateWithHoursBeforeNow:(NSUInteger)dHours;
+ (NSDate *)dateWithDaysBeforeDate:(NSDate *)date hours:(NSUInteger)dHours;
+ (NSDate *)dateWithMinutesFromNow:(NSUInteger)dMinutes;
+ (NSDate *)dateWithDaysFromDate:(NSDate *)date minutes:(NSUInteger)dMinutes;
+ (NSDate *)dateWithMinutesBeforeNow:(NSUInteger)dMinutes;
+ (NSDate *)dateWithDaysBeforeDate:(NSDate *)date minutes:(NSUInteger)dMinutes;

// Comparing dates
- (BOOL)isEqualToDateIgnoringTime:(NSDate *)aDate;
- (BOOL)isToday;
- (BOOL)isTomorrow;
- (BOOL)isYesterday;
- (BOOL)isSameWeekAsDate:(NSDate *)aDate;
- (BOOL)isThisWeek;
- (BOOL)isNextWeek;
- (BOOL)isLastWeek;
- (BOOL)isSameYearAsDate:(NSDate *)aDate;
- (BOOL)isThisYear;
- (BOOL)isNextYear;
- (BOOL)isLastYear;
- (BOOL)isEarlierThanDate:(NSDate *)aDate;
- (BOOL)isLaterThanDate:(NSDate *)aDate;

// Adjusting dates
- (NSDate *)dateByAddingDays:(NSUInteger)dDays;
- (NSDate *)dateBySubtractingDays:(NSUInteger)dDays;
- (NSDate *)dateByAddingHours:(NSUInteger)dHours;
- (NSDate *)dateBySubtractingHours:(NSUInteger)dHours;
- (NSDate *)dateByAddingMinutes:(NSUInteger)dMinutes;
- (NSDate *)dateBySubtractingMinutes:(NSUInteger)dMinutes;
- (NSDate *)dateAtStartOfDay;

// Retrieving intervals
- (NSInteger)minutesAfterDate:(NSDate *)aDate;
- (NSInteger)minutesBeforeDate:(NSDate *)aDate;
- (NSInteger)hoursAfterDate:(NSDate *)aDate;
- (NSInteger)hoursBeforeDate:(NSDate *)aDate;
- (NSInteger)daysAfterDate:(NSDate *)aDate;
- (NSInteger)daysBeforeDate:(NSDate *)aDate;

// Decomposing dates
@property (readonly) NSInteger nearestHour;
@property (readonly) NSInteger hour;
@property (readonly) NSInteger minute;
@property (readonly) NSInteger seconds;
@property (readonly) NSInteger day;
@property (readonly) NSInteger month;
@property (readonly) NSInteger weekOfMonth;
@property (readonly) NSInteger weekOfYear;
@property (readonly) NSInteger weekday;
@property (readonly) NSInteger nthWeekday; // e.g. 2nd Tuesday of the month == 2
@property (readonly) NSInteger year;

@end

