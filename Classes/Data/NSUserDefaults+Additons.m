//
//  NSUserDefaults+Settings.m
//  RaoooScore
//
//  Created by 瞿 伦平 on 13-12-31.
//  Copyright (c) 2013年 Allran. All rights reserved.
//

#import "NSUserDefaults+Additons.h"

static NSString * const keyDeviceID                     = @"Key_DeviceID";
static NSString * const keyUserToken                    = @"keyUserToken";
static NSString * const keyUserLost                    = @"keyUserLost";
static NSString * const keyapiBaseURL                    = @"keyapiBaseURL";
static NSString * const keytablePageRow                    = @"keytablePageRow";
static NSString * const keysuccessNumber                    = @"keysuccessNumber";

@interface NSUserDefaults (SettingsPrimary)

@end


@implementation NSUserDefaults (Additons)

@dynamic deviceID;
@dynamic userToken;
@dynamic userLost;
@dynamic apiBaseURL;
@dynamic tablePageRow;
@dynamic successNumber;

#pragma mark - deviceID
-(NSString *)deviceID
{
    return [self stringForKey:keyDeviceID];
}
-(void)setDeviceID:(NSString *)deviceID
{
    [self setObject:deviceID forKey:keyDeviceID];
    [self synchronize];
}


#pragma mark - deviceID
-(NSString *)userToken
{
    return [self stringForKey:keyUserToken];
}
-(void)setUserToken:(NSString *)userToken
{
    [self setObject:userToken forKey:keyUserToken];
    [self synchronize];
}

#pragma mark - deviceID
-(NSTimeInterval)userLost
{
    return [self doubleForKey:keyUserLost];
}
-(void)setUserLost:(NSTimeInterval)userLost
{
    [self setDouble:userLost forKey:keyUserLost];
    [self synchronize];
}


#pragma mark - apiBaseURL
-(NSString *)apiBaseURL
{
    return [self stringForKey:keyapiBaseURL];
}
-(void)setApiBaseURL:(NSString *)apiBaseURL
{
    [self setObject:apiBaseURL forKey:keyapiBaseURL];
    [self synchronize];
}

#pragma mark - tablePageRow
-(NSInteger)tablePageRow
{
    return [self integerForKey:keytablePageRow];
}
-(void)setTablePageRow:(NSInteger)tablePageRow
{
    [self setInteger:tablePageRow forKey:keytablePageRow];
    [self synchronize];
}

#pragma mark - successNumber
-(NSInteger)successNumber
{
    return [self integerForKey:keysuccessNumber];
}
-(void)setSuccessNumber:(NSInteger)successNumber
{
    [self setInteger:successNumber forKey:keysuccessNumber];
    [self synchronize];
}




- (void)qu_registerDefaults {
    NSDictionary *defaults = @{
                               keyDeviceID                  : @"test111" ,
                               keysuccessNumber             : @200 ,
                               keytablePageRow              : @20
                               };
    [self registerDefaults:defaults];
    

}


@end
