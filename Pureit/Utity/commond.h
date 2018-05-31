//
//  commond.h
//  Kline
//
//  Created by zhaomingxi on 14-2-11.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
@class TAlertView;
@class FGCustomAlertView;
CGSize getScreenSize();
@interface commond : NSObject
+(NSString *)dateStringBySince1970:(long)_timeStamp;
+(NSString*)stringFromDate:(NSDate*)date;
+(NSMutableDictionary *)splitDateStringByYYYYMMDD:(NSString *)_str_date;
+(NSMutableDictionary *)splitTimeStringByHHMMSS:(NSString *)_str_timestamp;
+(NSString *)numberToString:(NSNumber *)_number;
+(NSDate*)dateFromString:(NSString*)str;
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date;
+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta;
+(NSObject *) getUserDefaults:(NSString *) name;
+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key;
+(BOOL)saveToKeyChain:(NSString *)_str_username passwd:(NSString *)_str_passwd;
+(NSString *)getFromKeyChain:(NSString *)_str_username;
+(BOOL)deleteFromKeyChain:(NSString *)_str_username;
+(BOOL)isEmpty:(id)input;
+(NSString *)stringRemovePercentAndPlus:(NSString *)_str_original;
+(CGRect)useDefaultRatioToScaleFrame:(CGRect)_originalFrame;
+(void)useDefaultRatioToScaleView:(UIView *)_view;
+(long)EnCodeCoordinate:(double) para;
+(double)DeCodeCoordinate:(long)totalMilliarcseconds;
+(NSString *)meterToKMIfNeeded:(int)_meters;
+(BOOL)isTAlertAlreadyShowedInWindow;
+(void)alert:(NSString *)_str_title message:(NSString *)_str_message callback:(void (^)(FGCustomAlertView *alertView, NSInteger buttonIndex))callBackBlock;
+(NSString *)clockFormatBySeconds:(int)_sec;
+(void)showLoading;
+(void)removeLoading;
+(void)useRatio:(CGSize)_ratio toScaleView:(UIView *)_view;
+(void)removeAllAlertViewInWindow;
+(void)alertWithButtons:(NSArray *)_arr_buttons title:(NSString *)_str_title message:(NSString *)_str_message callback:(void (^)(FGCustomAlertView *alertView, NSInteger buttonIndex))callBackBlock;
+ (NSString *)getCurrentLanguage;
+(BOOL)isChinese;
@end
