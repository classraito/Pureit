//
//  commond.m
//  Kline
//
//  Created by zhaomingxi on 14-2-11.
//  Copyright (c) 2014年 zhaomingxi. All rights reserved.
//

#import "commond.h"
#import <CommonCrypto/CommonDigest.h>
#import "Global.h"
CGSize getScreenSize() {
    CGSize screenSize = [UIScreen mainScreen].bounds.size;
    if ((NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1) &&
        UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation)) {
        return CGSizeMake(screenSize.height, screenSize.width);
    }
    return screenSize;
}
MBProgressHUD *HUD;
UIImageView *iv_indicator;
@implementation commond

+(void)showLoading
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        if(!iv_indicator)
        {
            iv_indicator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"loadIndicator1.png"]];
            iv_indicator.bounds = CGRectMake(0, 0, iv_indicator.image.size.width / 2, iv_indicator.image.size.height / 2);
            NSMutableArray *arr_imgs = [NSMutableArray array];
            for(int i=0;i<12;i++)
            {
                UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"loadIndicator%d.png",i+1 ]];
                [arr_imgs addObject:img];
                
            }
            iv_indicator.animationImages = arr_imgs;
            iv_indicator.animationDuration = 1;
            iv_indicator.animationRepeatCount = 0;
        }
        [iv_indicator startAnimating];
        HUD = [MBProgressHUD showHUDAddedTo:appDelegate.window animated:NO];
        HUD.customView = iv_indicator;
        
        // Set custom view mode
        HUD.mode = MBProgressHUDModeCustomView;
    });
    
    
}

+(void)removeLoading
{
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [iv_indicator stopAnimating];
        [MBProgressHUD hideHUDForView:appDelegate.window animated:NO];
    });
}

/*将20131123字符串转换为year:2013 month:11 day:23的字典*/
+(NSMutableDictionary *)splitDateStringByYYYYMMDD:(NSString *)_str_date
{
    if(!_str_date)
        return nil;
    if([@"" isEqualToString:_str_date])
        return nil;
    if([_str_date intValue] == NAN)
        return nil;
    if([_str_date length]!=8)
        return nil;
    
    NSString *str_year = [_str_date substringWithRange:NSMakeRange(0, 4)];
    NSString *str_month = [_str_date substringWithRange:NSMakeRange(4, 2)];
    NSString *str_day = [_str_date substringWithRange:NSMakeRange(6, 2)];
    NSMutableDictionary *_dic_retVal = [NSMutableDictionary dictionaryWithCapacity:3];
    [_dic_retVal setObject:str_year forKey:@"year"];
    [_dic_retVal setObject:str_month forKey:@"month"];
    [_dic_retVal setObject:str_day forKey:@"day"];
    return _dic_retVal;
}

/*将180620字符串转换为hours:18 minutes:06 seconds:20*/
+(NSMutableDictionary *)splitTimeStringByHHMMSS:(NSString *)_str_timestamp
{
    if(!_str_timestamp)
        return nil;
    if([@"" isEqualToString:_str_timestamp])
        return nil;
    if([_str_timestamp intValue] == NAN)
        return nil;
    if([_str_timestamp length]<5 || [_str_timestamp length]>6)
        return nil;
    
    NSInteger strLen = [_str_timestamp length];
    NSString *str_ms = [_str_timestamp substringWithRange:NSMakeRange(strLen-2, 2)];
    NSString *str_minutes = [_str_timestamp substringWithRange:NSMakeRange(strLen-4, 2)];
    NSInteger hourCount = 0;
    if(strLen == 5)
        hourCount = 1;
    else if(strLen == 6)
        hourCount = 2;
    NSString *str_hours = [_str_timestamp substringWithRange:NSMakeRange(strLen-4-hourCount, hourCount)];
    
    NSMutableDictionary *_dic_retVal = [NSMutableDictionary dictionaryWithCapacity:3];
    [_dic_retVal setObject:str_hours forKey:@"hours"];
    [_dic_retVal setObject:str_minutes forKey:@"minutes"];
    [_dic_retVal setObject:str_ms forKey:@"seconds"];
    
    return _dic_retVal;
}

+(NSString *)meterToKMIfNeeded:(int)_meters
{
    NSString *ret = nil;
    if(_meters / 1000 >=1 )
    {
        CGFloat km = (CGFloat)_meters / 1000.0f;
        ret = [NSString stringWithFormat:@"%.1f %@",km,multiLanguage(@"公里")];
    }
    else
    {
        ret = [NSString stringWithFormat:@"%d %@",_meters,multiLanguage(@"米")];
    }
    
    return ret;
}

+(NSString *)numberToString:(NSNumber *)_number
{
    if(!_number)
        return nil;
    if(![_number isKindOfClass:[NSNumber class]])
        return nil;
    
    return [NSString stringWithFormat:@"%@",_number];
}

#pragma mark 字符串转换为日期时间对象
+(NSDate*)dateFromString:(NSString*)str{
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"yyyy-MM-dd"];
    // 将字符串转换为时间对象
    NSDate *tempDate = [datef dateFromString:str];
    return tempDate;
}

+(NSString*)stringFromDate:(NSDate*)date{
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"HH:mm:ss"];
    // 将字符串转换为时间对象
   return [datef stringFromDate:date];
}

+(NSString *)dateStringBySince1970:(long)_timeStamp
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_timeStamp];
    // 创建一个时间格式化对象
    NSDateFormatter *datef = [[NSDateFormatter alloc] init];
    // 设定时间的格式
    [datef setDateFormat:@"yyyy年MM月dd日"];
    NSString *retval = [datef stringFromDate:date];
    return retval;
}

+(NSString *)clockFormatBySeconds:(int)_sec
{
    NSString *_str_retval = nil;
    
    int sec = _sec % 60;
    int min = _sec / 60;
    int hour = _sec / 60 / 60;
    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init] ;
    numberFormatter.minimumIntegerDigits = 2;
    [numberFormatter setNumberStyle:NSNumberFormatterNoStyle];
    NSString *str_hour=[numberFormatter stringFromNumber:[NSNumber numberWithInt:hour]];
    NSString *str_min=[numberFormatter stringFromNumber:[NSNumber numberWithInt:min]];
    NSString *str_sec=[numberFormatter stringFromNumber:[NSNumber numberWithInt:sec]];
    
    _str_retval = [NSString stringWithFormat:@"%@:%@:%@",str_hour,str_min,str_sec];
    numberFormatter = nil;
    return _str_retval;
}

#pragma mark 时间对象转换为时间字段信息
+(NSDateComponents*)dateComponentsWithDate:(NSDate*)date{
    if (date==nil) {
        date = [NSDate date];
    }
    // 获取代表公历的Calendar对象
    NSCalendar *calenar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    // 定义一个时间段的旗标，指定将会获取指定的年，月，日，时，分，秒的信息
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSWeekdayCalendarUnit;
    // 获取不同时间字段信息
    NSDateComponents *dateComp = [calenar components:unitFlags fromDate:date];
    return dateComp;
}

+(bool)isEqualWithFloat:(float)f1 float2:(float)f2 absDelta:(int)absDelta
{
    int i1, i2;
    i1 = (f1>0) ? ((int)f1) : ((int)f1 - 0x80000000);
    i2 = (f2>0) ? ((int)f2)  : ((int)f2 - 0x80000000);
    return ((abs(i1-i2))<absDelta) ? true : false;
}

+(NSObject *) getUserDefaults:(NSString *) name{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    return [userDefaults objectForKey:name];
}

+(void) setUserDefaults:(NSObject *) defaults forKey:(NSString *) key{
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:defaults forKey:key];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+(BOOL)isEmpty:(id)input
{
    if(!input ||[[NSNull null] isEqual:input])
        return YES;
    
    if(![input isKindOfClass:[NSString class]])
        return NO;
    
    if([@"<null>"isEqual:input])
        return YES;
    
    NSString *ret = [input stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if(ret && ![ret isEqualToString:@""] )
        return NO;
    else
        return YES;
    
}

+(NSString *)stringRemovePercentAndPlus:(NSString *)_str_original
{
    _str_original = [_str_original stringByReplacingOccurrencesOfString:@"%" withString:@""];
    _str_original = [_str_original stringByReplacingOccurrencesOfString:@"+" withString:@""];
    return _str_original;
}

+(void)useRatio:(CGSize)_ratio toScaleView:(UIView *)_view
{
    CGRect _newFrame = _view.frame;
    _newFrame.origin.x = _view.frame.origin.x * _ratio.width;
    _newFrame.origin.y = _view.frame.origin.y * _ratio.height;
    _newFrame.size.width = _view.frame.size.width * _ratio.width;
    _newFrame.size.height = _view.frame.size.height * _ratio.height;
    _view.frame = _newFrame;
}

+(CGRect)useDefaultRatioToScaleFrame:(CGRect)_originalFrame
{
    CGRect _frameReturn = CGRectZero;
    _frameReturn.origin.x = _originalFrame.origin.x * ratioW;
    _frameReturn.origin.y = _originalFrame.origin.y * ratioH;
    _frameReturn.size.width = _originalFrame.size.width * ratioW;
    _frameReturn.size.height = _originalFrame.size.height * ratioH;
    return _frameReturn;
    
}

+(void)useDefaultRatioToScaleView:(UIView *)_view
{
    CGRect _newFrame = _view.frame;
    _newFrame.origin.x = _view.frame.origin.x * ratioW;
    _newFrame.origin.y = _view.frame.origin.y * ratioH;
    _newFrame.size.width = _view.frame.size.width * ratioW;
    _newFrame.size.height = _view.frame.size.height * ratioH;
    _view.frame = _newFrame;
}

+(long)EnCodeCoordinate:(double) para
{
    // 度
    //    long temp_para = para*10000000;
    
    long dCoordinate = (long) para;
    //--
    double dResdiue = para - dCoordinate;
    // 分
    double mCoordinate = (double) (dResdiue*60);
    dResdiue = (dResdiue*60) - mCoordinate; //分的余数
    
    // 秒
    double sCoordinate = (double) (dResdiue*60);
    // 毫秒
    double hCorrdinate = (double) (((dResdiue*60) - sCoordinate)*1000);
    
    long result = (dCoordinate*60*60*1000) + (mCoordinate*60*1000) + (sCoordinate*1000) + hCorrdinate;
    
    return result;
}


/// <summary>
/// 长整转经伟度
/// </summary>
/// <returns></returns>
+(double)DeCodeCoordinate:(long)totalMilliarcseconds
{
    double result;
    double du = totalMilliarcseconds/(60*60*1000); //度数
    double fen = (totalMilliarcseconds - du*(60*60*1000))/(60*1000); //分
    double miao = (totalMilliarcseconds - fen*60*1000 - du*60*60*1000)/1000; //秒
    double haomiao = totalMilliarcseconds - miao*1000 - fen*60*1000 - du*60*60*1000;
    
    
    double double1 = [[NSString stringWithFormat:@"%.7f",(double) fen/60] doubleValue];
    double double2 = [[NSString stringWithFormat:@"%.7f",(double) miao/60/6] doubleValue];
    double double3 = [[NSString stringWithFormat:@"%.7f",(double) haomiao/1000/60/60] doubleValue];
    
    result = du + double1 + double2 + double3;
    return result;
}

+(BOOL)isTAlertAlreadyShowedInWindow
{
    UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
    for(UIView *_subview in window.subviews)
    {
        if([_subview isKindOfClass:[FGCustomAlertView class]])
        {
            
            return YES;
        }
    }
    return NO;
}

+(void)removeAllAlertViewInWindow
{
    UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
    for(UIView *_subview in window.subviews)
    {
        if([_subview isKindOfClass:[TAlertView class]])
        {
            
            [_subview removeFromSuperview];
        }
    }
}

+(void)alert:(NSString *)_str_title message:(NSString *)_str_message callback:(void (^)(FGCustomAlertView *alertView, NSInteger buttonIndex))callBackBlock
{
    if([commond isTAlertAlreadyShowedInWindow])
        return;
   /* NSArray * buttons = @[multiLanguage(@"OK")];
    TAlertView *alert = [[TAlertView alloc] initWithTitle:_str_title
                                                  message:_str_message
                                                  buttons:buttons
                                              andCallBack:callBackBlock];
    alert.messageColor = [UIColor blackColor];
    alert.buttonsTextColor = [UIColor blackColor];
    alert.titleFont = font(FONT_NORMAL, 16);
    alert.messageFont = font(FONT_NORMAL, 16);
    alert.buttonsFont =  font(FONT_NORMAL, 16);
    [alert show];*/
    NSArray * buttons = @[multiLanguage(@"OK")];
    
    [commond alertWithButtons:buttons title:_str_title message:_str_message callback:callBackBlock];
}

+(void)alertWithButtons:(NSArray *)_arr_buttons title:(NSString *)_str_title message:(NSString *)_str_message callback:(void (^)(FGCustomAlertView *alertView, NSInteger buttonIndex))callBackBlock
{
    if([commond isTAlertAlreadyShowedInWindow])
        return;
    
    FGCustomAlertView *alert = (FGCustomAlertView *)[[[NSBundle mainBundle] loadNibNamed:@"FGCustomAlertView" owner:nil options:nil] objectAtIndex:0];
    [alert setupWithTitle:_str_title message:_str_message buttons:_arr_buttons andCallBack:callBackBlock];
    [alert show];
}

+(BOOL)saveToKeyChain:(NSString *)_str_username passwd:(NSString *)_str_passwd
{
    NSError *error;
    BOOL saved = [SFHFKeychainUtils storeUsername:_str_username andPassword:_str_passwd forServiceName:APP_BUNDLEID updateExisting:YES error:&error];
    if (!saved) {
        NSLog(@"Keychain保存字符时出错：%@", error);
    }else{
        NSLog(@"Keychain保存字符成功！key:%@ value:%@",_str_username,_str_passwd);
    }
    return saved;
}

+(NSString *)getFromKeyChain:(NSString *)_str_username
{
    NSError *error;
    NSString * str_passwd = [SFHFKeychainUtils getPasswordForUsername:_str_username andServiceName:APP_BUNDLEID error:&error];
    if(error || !str_passwd){
        NSLog(@"从Keychain里获取字符出错：%@", error);
        return nil;
    }
    else{
        NSLog(@"从Keychain里获取加密字符成功！key:%@ value:%@",_str_username,str_passwd);
        return str_passwd;
    }
}

+(BOOL)isChinese
{
    NSString *_str_language = [commond getCurrentLanguage];
    if([@"zh-Hans-US" isEqualToString:_str_language]||
       [@"zh-Hant" isEqualToString:_str_language]||
       [_str_language rangeOfString:@"zh-Han"].location != NSNotFound)
    {
        return YES;
    }
    else
        return NO;
}

+ (NSString *)getCurrentLanguage
{
    NSArray *languages = [NSLocale preferredLanguages];
    NSString *currentLanguage = [languages objectAtIndex:0];
    NSLog( @"%@" , currentLanguage);
    return currentLanguage;
}
@end
