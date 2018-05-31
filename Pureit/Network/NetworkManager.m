//
//  NetworkManager.m
//  MyStock
//
//  Created by Ryan Gong on 15/9/10.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//


#import "NetworkManager.h"
#import "Global.h"
#import "UIDevice+IdentifierAddition.h"
#import "AppDelegate.h"
static NetworkManager *manager;

@interface NetworkManager()
{
    
}
@end

@implementation NetworkManager
@synthesize refreshCode;
+(id)alloc
{
    @synchronized(self)     {
        NSAssert(manager == nil, @"企圖創建一個singleton模式下的NetworkManager");
        return [super alloc];
    }
    return nil;
}

+(NetworkManager *)sharedManager//用这个方法来初始化NetworkManager
{
    @synchronized(self)     {
        if(!manager)
        {
            manager=[[NetworkManager alloc]init];
//            [manager postRequest_test];
             return manager;
        }
    }
    return manager;
}



-(void)postRequest_test
{
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:@"上海" forKey:@"city"];
    [self requestUrl:@"http://ec2-54-222-145-231.cn-north-1.compute.amazonaws.com.cn/GetEventByCity.ashx" params:dic_params headers:nil userinfo:nil];
    
    
}
#pragma mark - request
#pragma mark - 注册获取手机验证码
-(void)postRequest_getMobileCodeReg:(NSString *)_str_mobile  userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [self requestUrl:HOST(URL_GetMobileCodeReg) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 注册验证手机验证码
-(void)postRequest_checkMobileCodeReg:(NSString *)_str_mobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [dic_params setObjectSafty:_str_vCode forKey:@"VCode"];
    [self requestUrl:HOST(URL_CheckMobileCodeReg) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 提交注册信息
-(void)postRequest_submitRegInfo:(NSMutableDictionary *)_dic_infos  userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    
    
   
    
    NSString *_str_name = [_dic_infos objectForKey:@"Name"];
    NSString *_str_email = [_dic_infos objectForKey:@"Email"];
    NSString *_str_mobile = [_dic_infos objectForKey:@"Mobile"];
    NSString *_str_landline = [_dic_infos objectForKey:@"LandLine"];
    NSNumber *_person = [_dic_infos objectForKey:@"Person"];
    NSString *_str_city = [_dic_infos objectForKey:@"City"];
    NSString *_str_cityId = [_dic_infos objectForKey:@"CityId"];
    NSString *_str_address = [_dic_infos objectForKey:@"Address"];
    
    NSString *str_serialNumber = (NSString *)[commond getUserDefaults:KEY_SERIALNUMBER];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:str_serialNumber forKey:@"SerialNumber"];
    [dic_params setObjectSafty:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    [dic_params setObjectSafty:_str_landline forKey:@"LandLine"];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [dic_params setObjectSafty:_str_name forKey:@"Name"];
    [dic_params setObjectSafty:_str_email forKey:@"Email"];
    [dic_params setObjectSafty:_person forKey:@"Person"];
    [dic_params setObjectSafty:_str_city forKey:@"City"];
    [dic_params setObjectSafty:_str_cityId forKey:@"CityId"];
    [dic_params setObjectSafty:_str_address forKey:@"Address"];
    NSString *_str_pureitDeviceMACAddress = (NSString *)[commond getUserDefaults:KEY_DEVICE_MAC_ADDRESS];//pureit设备MAC地址
    [dic_params setObjectSafty:_str_pureitDeviceMACAddress forKey:@"MAC"];
    [self requestUrl:HOST(URL_SubmitRegInfo) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 登录获取手机验证码
-(void)postRequest_getMobileCodeLogin:(NSString *)_str_mobile   userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [self requestUrl:HOST(URL_GetMobileCodeLogin) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 登录验证手机验证码
-(void)postRequest_checkMobileCodeLogin:(NSString *)_str_mobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [dic_params setObjectSafty:_str_vCode forKey:@"VCode"];
    [dic_params setObjectSafty:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    [self requestUrl:HOST(URL_CheckMobileCodeLogin) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 更新手机号码获取手机验证码
-(void)postRequest_getMobileCodeUpdateMobile:(NSString *)_str_oldMobile newMobile:(NSString *)_str_newMobile userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObjectSafty:_str_oldMobile forKey:@"Mobile"];
    [_dic_params setObjectSafty:_str_newMobile forKey:@"NewMobile"];
     NSString *str_serialNumber = (NSString *)[commond getUserDefaults:KEY_SERIALNUMBER];
    [_dic_params setObjectSafty:str_serialNumber forKey:@"SerialNumber"];
    [self requestUrl:HOST(URL_UpdateGetMobileCode) params:_dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 更新手机号码验证手机验证码
-(void)postRequest_checkMobileCodeUpdateMobile:(NSString *)_str_oldMobile newMobile:(NSString *)_str_newMobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_oldMobile forKey:@"Mobile"];
    [dic_params setObjectSafty:_str_newMobile forKey:@"NewMobile"];
    NSString *str_serialNumber = (NSString *)[commond getUserDefaults:KEY_SERIALNUMBER];
    [dic_params setObjectSafty:str_serialNumber forKey:@"SerialNumber"];
    [dic_params setObjectSafty:_str_vCode forKey:@"VCode"];
    [dic_params setObjectSafty:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    [self requestUrl:HOST(URL_UpdateCheckMobileCode) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 获取设备列表
-(void)postRequest_getDevices:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_GetDevices) params:nil headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 删除设备
-(void)postRequest_deleteDevice:(NSString *)_SN userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_SN forKey:@"SerialNumber"];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    
    [self requestUrl:HOST(URL_DeleteDevices) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 新增投诉
-(void)postRequest_addComplaint:(NSString *)_str_problemType problem:(NSString *)_str_problem userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_problemType forKey:@"Type"];
    [dic_params setObjectSafty:_str_problem forKey:@"Problem"];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_AddComplaint) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 修改手机号码
-(void)postRequest_changeMobileNumber:(NSString *)_str_oldMobile newMobile:(NSString *)_str_newMobile userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_oldMobile forKey:@"OldMobile"];
    [dic_params setObjectSafty:_str_newMobile forKey:@"NewMobile"];
    [dic_params setObjectSafty:@"" forKey:@"Name"];
    [self requestUrl:HOST(URL_ChangeMobile) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 获取用户信息
-(void)postRequest_getUserInfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_GetUserInfo) params:nil headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 修改用户信息
-(void)postRequest_setUserInfo:(NSMutableDictionary *)_dic_infos userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSString *_str_name = [_dic_infos objectForKey:@"Name"];
    NSString *_str_email = [_dic_infos objectForKey:@"Email"];
    NSNumber *_person = [_dic_infos objectForKey:@"Person"];
    NSString *_str_city = [_dic_infos objectForKey:@"City"];
    NSString *_str_address = [_dic_infos objectForKey:@"Address"];
    NSString *_str_LandLine = [_dic_infos objectForKey:@"LandLine"];
    NSString *_str_cityId = [_dic_infos objectForKey:@"CityId"];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_name forKey:@"Name"];
    [dic_params setObjectSafty:_str_email forKey:@"Email"];
    [dic_params setObjectSafty:_person forKey:@"Person"];
    [dic_params setObjectSafty:_str_city forKey:@"City"];
    [dic_params setObjectSafty:_str_address forKey:@"Address"];
    [dic_params setObjectSafty:_str_LandLine forKey:@"LandLine"];
    [dic_params setObjectSafty:_str_cityId forKey:@"CityId"];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_SetUserInfo) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 注册 检查序列号状态
-(void)postRequest_CheckSerialNumberReg:(NSString *)_str_serialNumber userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [self postRequest_CheckSerialNumberReg:_str_serialNumber mac:nil userinfo:_dic_userinfo];
}

-(void)postRequest_CheckSerialNumberReg:(NSString *)_str_serialNumber mac:(NSString *)_str_mac userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    [commond setUserDefaults:_str_serialNumber forKey:KEY_SERIALNUMBER];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_serialNumber forKey:@"SerialNumber"];
    if(_str_mac)
    {
        [dic_params setObjectSafty:_str_mac forKey:@"MAC"];
    }
    [self requestUrl:HOST(URL_CheckSerialNumberReg) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 登录 绑定序列号
-(void)postRequest_bindSerialNumber:(NSString *)_str_serialNumber userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_serialNumber forKey:@"SerialNumber"];
    [dic_params setObjectSafty:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_BindSerialNumber) params:dic_params headers:nil userinfo:dic_headers];
}

#pragma mark - 获得首页数据
-(void)postRequest_getHomePageData:(NSMutableDictionary *)_dic_userinfo
{

    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObject:[NSString stringWithFormat:@"%d",refreshCode] forKey:@"id"];
    [self requestUrl:HOST(URL_GetRefreshData) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获得图形数据
-(void)postRequest_getGraphData:(NSMutableDictionary *)_dic_userinfo
{
//    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    if(appDelegate.deviceToken && ![@"" isEqualToString:appDelegate.deviceToken])
    {
        NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
        [dic_params setObjectSafty:appDelegate.deviceToken forKey:@"DeviceToken"];
        [self requestUrl:HOST(URL_GetData) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
    }
    else
        [self requestUrl:HOST(URL_GetData) params:nil headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获得GKK数据
-(void)postRequest_getGKK:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_GetGKK) params:nil headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 预定GKK
-(void)postRequest_bookGkk:(NSString *)_str_name address:(NSString *)_str_address gkk:(int)_gkk userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_name forKey:@"Name"];
    [dic_params setObjectSafty:_str_address forKey:@"Address"];
    [dic_params setObjectSafty:[NSNumber numberWithInt:_gkk] forKey:@"GKK"];
    [self requestUrl:HOST(URL_BookGKK) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 追加用户获取手机验证码
-(void)postRequest_GetMobileCodeAdditionalUser:(NSString *)_str_mobile userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [self requestUrl:HOST(URL_AdditionalUserGetMobileCode) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 追加用户手机验证码 
-(void)postRequest_checkMobileAdditionalUser:(NSString *)_str_mobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [dic_params setObjectSafty:_str_vCode forKey:@"VCode"];
    [self requestUrl:HOST(URL_AdditionalUserCheckMobileCode) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 追加用户
-(void)postRequest_SubmitAdditionalInfo:(NSString *)_str_mobile name:(NSString *)_str_name userinfo:(NSMutableDictionary *)_dic_userinfo;
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_mobile forKey:@"Mobile"];
    [dic_params setObjectSafty:_str_name forKey:@"Name"];
    NSString *str_serialNumber = (NSString *)[commond getUserDefaults:KEY_SERIALNUMBER];
    [dic_params setObjectSafty:str_serialNumber forKey:@"SerialNumber"];
    [dic_params setObjectSafty:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    [self requestUrl:HOST(URL_SubmitAdditionalInfo) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 设置默认设备
-(void)postRequest_setDefaultDevice:(NSString *)_str_deviceId userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:_str_deviceId forKey:@"SerialNumber"];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_SetDefaultDevice) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获取预定用户信息
-(void)postRequest_getBookUserInfo:(NSMutableDictionary *)_dic_userinfo;
{
    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_GetUserInfo) params:nil headers:dic_headers userinfo:_dic_userinfo];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    NSString *str_serialNumber = (NSString *)[commond getUserDefaults:KEY_SERIALNUMBER];
    [dic_params setObjectSafty:str_serialNumber forKey:@"SerialNumber"];
    
    [self requestUrl:HOST(URL_GetBookUserInfo) params:dic_params headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获取订单历史
-(void)postRequest_orderHistory:(NSMutableDictionary *)_dic_userinfo
{
    [commond showLoading];
    NSMutableDictionary *dic_headers = [NSMutableDictionary dictionary];
    [dic_headers setObjectSafty:[commond getUserDefaults:KEY_ACCESSTOKEN] forKey:@"AccessToken"];
    [self requestUrl:HOST(URL_OrderHistory) params:nil headers:dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获得城市列表的json文件
-(void)postRequest_getCityList:(NSMutableDictionary *)_dic_userinfo;
{
    [commond showLoading];
    [self requestUrl:HOST(URL_GetCityList) method:@"GET" params:nil headers:nil userinfo:_dic_userinfo];
}

#pragma mark -
/*ASIHttpRequestDelegate 处理回调*/
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str_response = request.responseString;
    
    NSLog(@"str_response = %@",str_response);
    
    int responseCode = request.responseStatusCode;
    
    if(responseCode != 200)
    {
        [commond removeLoading];
        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"请检查您的网络!") callback:nil];
        return;//第一级检查返回码
    }
    NSString *_str_requestUrl = request.url.absoluteString;
    NSMutableDictionary *_dic_json = [str_response mutableObjectFromJSONString];
    
    if([HOST(URL_GetRefreshData) isEqualToString:_str_requestUrl])
    {
        refreshCode = [[_dic_json objectForKey:@"Code"] intValue];
        NSLog(@"refreshCode = %d",refreshCode);
    }
    else
    {
        [commond removeLoading];
    }
    
    if([HOST(URL_GetCityList) isEqualToString:_str_requestUrl])
    {
        str_response = [[NSString alloc] initWithData:request.responseData encoding:NSUTF8StringEncoding];
        _dic_json = [[str_response mutableObjectFromJSONString] mutableCopy];
    }
    else
    {
        NSLog(@":::::>response %@ %@ ",_str_requestUrl,_dic_json);
    }
    
    
    if(!_dic_json )
        return;
    
    if(![self isReturnCodePass:_dic_json url:_str_requestUrl])
    {
        NSDictionary *_dic_failedInfo = @{@"result":_dic_json,@"url":_str_requestUrl};
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_UpdateFailed object:_dic_failedInfo];
        return;
    }
    
    
    if([HOST(URL_SubmitRegInfo) isEqualToString:_str_requestUrl])
    {
        [self saveImportInfo:_dic_json];
    }
    if([HOST(URL_CheckMobileCodeLogin) isEqualToString:_str_requestUrl])
    {
        [self saveImportInfo:_dic_json];
    }//保存重要信息
    if([HOST(URL_SubmitAdditionalInfo) isEqualToString:_str_requestUrl])
    {
        [self saveImportInfo:_dic_json];
    }
    if([HOST(URL_UpdateCheckMobileCode) isEqualToString:_str_requestUrl])
    {
        [self saveImportInfo:_dic_json];
    }
    
    
    NSMutableDictionary *dic_info = nil;
    if(request.userInfo)
    {
        dic_info = [NSMutableDictionary dictionaryWithDictionary:request.userInfo];
    }
    else
    {
        dic_info =  [NSMutableDictionary dictionary];
    }
    [dic_info setObjectSafty:_str_requestUrl forKey:@"url"];
    
    [[DataManager sharedManager] saveData:_dic_json info:dic_info];
    //保存到数据内存中
    
    
}

/*处理连接错误*/
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"XXXXXXXXXXXXXX> response error:%@ url:%@",request.error,request.url);
    [commond removeLoading];
    [commond alert:multiLanguage(@"警告") message:multiLanguage(@"请检查您的网络!") callback:nil];
    
}

/* 子方法 */
-(void)clearAllRequeast
{
    
}

/*通用请求方法*/
-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           params:(NSMutableDictionary *)_dic_params
                          headers:(NSMutableDictionary *)_dic_headers
                         userinfo:(NSMutableDictionary *)_dic_userinfo;
{
    
    return [self requestUrl:_str_url method:@"POST" params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
}

/*通用请求方法*/
-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           method:(NSString *)_str_method
                           params:(NSMutableDictionary *)_dic_params
                          headers:(NSMutableDictionary *)_dic_headers
                         userinfo:(NSMutableDictionary *)_dic_userinfo;
{
    
    @try {
        if(![[Reachability reachabilityForInternetConnection] isReachable])
        {
            [commond removeLoading];
            [commond alert:multiLanguage(@"警告") message:multiLanguage(@"请检查您的网络!") callback:nil];
            return nil;
        }
        
        if(_dic_params && ![self isParameterValid:_dic_params])
            return nil;
        
        
        NSURL *url = [NSURL URLWithString:[_str_url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:url];
        [request setTimeOutSeconds:180];//TODO: 超时改到3分钟
        [request setRequestMethod:_str_method];
        [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
        [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
        if(_dic_userinfo)
            request.userInfo = _dic_userinfo;
        [request setValidatesSecureCertificate:NO];
        if(_dic_headers && [_dic_headers count]>0)
        {
            for(int i=0;i<[_dic_headers count];i++)
            {
                id key = [[_dic_headers allKeys] objectAtIndex:i];
                [request addRequestHeader:key value:[_dic_headers objectForKey:key]];
            }
        }
        if(_dic_params)
            [request appendPostData:[_dic_params JSONData]];
        request.delegate = self;
        
        [request startAsynchronous];
        NSLog(@"_dic_params = %@",_dic_params);
        NSLog(@"::::>request json:%@",[_dic_params JSONString]);
        NSLog(@"::::::::::::::::::>request:[%@] %@ %@",_str_url,_dic_params,request.requestHeaders);//TODO: fix it 5%左右的概率在这里奔溃
        return request;
    }
    @catch (NSException *exception) {
        NSLog(@"exception = %@",exception);
        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"网络发生异常，请检查您的网络连接") callback:nil];
        return nil;
    }
}

-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           params:(NSMutableDictionary *)_dic_params
                          headers:(NSMutableDictionary *)_dic_headers;
{
    
    
    return [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:nil];
    
    
    
}

-(void)saveImportInfo:(NSMutableDictionary *)_dic_result
{
    NSString *_str_accessToken = [_dic_result objectForKey:@"AccessToken"];
    [commond setUserDefaults:_str_accessToken forKey:KEY_ACCESSTOKEN];
}

/*判断返回码*/
-(BOOL)isReturnCodePass:(NSMutableDictionary *)_dic_result url:(NSString *)_str_requestUrl
{
    NSNumber *_num_returncode = [_dic_result objectForKey:@"Code"];
    NSInteger _returncode = [_num_returncode integerValue];
    if(_returncode == 0)
    {
         return YES;
    }//通常情况下返回值不是0说明有错误
    else if(_returncode==-101 && [HOST(URL_GetRefreshData) isEqualToString:_str_requestUrl])
    {
        return NO;//登录信息已过期，请重新登录！未找到对应设备，请先绑定设备！
    }
    else if(_returncode!=0 && [HOST(URL_GetRefreshData) isEqualToString:_str_requestUrl] && _returncode!=-101)
    {
        return YES;
    }//GetRefreshData接口返回的returnCode可以不是0 被记录到refreshCode变量中 用于下一次刷新时要传的id
    else
    {
        if([HOST(URL_CheckSerialNumberReg) isEqualToString:_str_requestUrl] && _returncode == 101)
            return NO;
        
        NSString *str_codeMsg = [_dic_result objectForKey:@"CodeMsg"];
        [commond alert:multiLanguage(@"警告") message:str_codeMsg callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
            [commond removeLoading];
        }];
    }
    return NO;
}


/*判断参数字典中是否有空值*/
-(BOOL)isParameterValid:(NSDictionary *)_dic_params
{
    for(NSString *str_key in [_dic_params allKeys])
    {
        NSString *str_value = [_dic_params objectForKey:str_key];
        if(!str_value)
            return NO;
    }
    return YES;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
