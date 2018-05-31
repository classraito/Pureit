//
//  NetworkManager.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/10.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"

//API URL
#define URL_GetCityList @"/api/city.json"
#define URL_GetMobileCodeReg @"/api/Account/RegGetMobileCode.ashx"
#define URL_CheckMobileCodeReg @"/api/Account/RegCheckMobileCode.ashx"
#define URL_SubmitRegInfo @"/api/Account/SubmitRegInfo.ashx"
#define URL_GetMobileCodeLogin @"/api/Account/LoginGetMobileCode.ashx"
#define URL_CheckMobileCodeLogin @"/api/Account/LoginCheckMobileCode.ashx"
#define URL_ChangeMobile @"/api/Account/ChangeMobile.ashx"
#define URL_GetUserInfo @"/api/Account/GetUserInfo.ashx"
#define URL_CheckSerialNumberReg @"/api/Business/RegCheckSerialNumber.ashx"
#define URL_BindSerialNumber @"/api/Business/BindSerialNumber.ashx"
#define URL_GetData @"/api/data/get.ashx"
#define URL_GetRefreshData @"/api/data/home.ashx"
#define URL_GetGKK @"/api/data/gkk.ashx"
#define URL_BookGKK @"/api/Account/BookGkk.ashx"
#define URL_UpdateGetMobileCode @"/api/Account/UpdateGetMobileCode.ashx"
#define URL_UpdateCheckMobileCode @"/api/Account/UpdateCheckMobileCode.ashx"
#define URL_GetDevices @"/api/Account/GetDevices.ashx"
#define URL_DeleteDevices @"/api/Account/DeleteDevice.ashx"
#define URL_AddComplaint @"/api/Account/AddComplaint.ashx"
#define URL_AdditionalUserGetMobileCode @"/api/Account/AddiGetMobileCode.ashx"
#define URL_AdditionalUserCheckMobileCode @"/api/Account/AddiCheckMobileCode.ashx"
#define URL_SubmitAdditionalInfo @"/api/Account/SubmitAdditionalInfo.ashx"
#define URL_SetDefaultDevice @"/api/Account/SetDefault.ashx"
#define URL_SetUserInfo @"/api/Account/SetUserInfo.ashx"
#define URL_GetBookUserInfo @"/api/Account/GetBookUserInfo.ashx"
#define URL_OrderHistory @"/api/data/book.ashx"
#define URL_GetWeatherFromBaiduPrefix @"http://api.map.baidu.com/telematics/v3/weather"
#define URL_GetWeatherFromOpenWeatherOrg @"http://api.openweathermap.org/data/2.5/weather?lat=%f&lon=%f&APPID=02de0fe913175b596933e58c334f3154"
#define HOST(_str_url) [NSString stringWithFormat:@"%@%@",HOSTNAME,_str_url]
#define projectversion [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

#define KEY_LOGINTYPE @"KEY_LOGINTYPE"

#define KEY_SERIALNUMBER @"KEY_SERIALNUMBER"
#define KEY_DEVICE_MAC_ADDRESS @"KEY_DEVICE_MAC_ADDRESS"
#define KEY_ACCESSTOKEN @"KEY_ACCESSTOKEN"

@interface NetworkManager : NSObject<ASIHTTPRequestDelegate>
{

}
@property int refreshCode;;
+(NetworkManager *)sharedManager;//manager 单例初始化
/*通用请求方法*/
-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           params:(NSDictionary *)_dic_params
                          headers:(NSDictionary *)_dic_headers;

#pragma mark - request
#pragma mark - 注册获取手机验证码
-(void)postRequest_getMobileCodeReg:(NSString *)_str_mobile  userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 注册验证手机验证码
-(void)postRequest_checkMobileCodeReg:(NSString *)_str_mobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 提交注册信息
-(void)postRequest_submitRegInfo:(NSMutableDictionary *)_dic_infos  userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 登录获取手机验证码
-(void)postRequest_getMobileCodeLogin:(NSString *)_str_mobile   userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 登录验证手机验证码
-(void)postRequest_checkMobileCodeLogin:(NSString *)_str_mobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 修改手机号码
-(void)postRequest_changeMobileNumber:(NSString *)_str_oldMobile newMobile:(NSString *)_str_newMobile userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获取用户信息
-(void)postRequest_getUserInfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 修改用户信息
-(void)postRequest_setUserInfo:(NSMutableDictionary *)_dic_infos userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 注册 检查序列号状态
-(void)postRequest_CheckSerialNumberReg:(NSString *)_str_serialNumber userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_CheckSerialNumberReg:(NSString *)_str_serialNumber mac:(NSString *)_str_mac userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 登录 绑定序列号
-(void)postRequest_bindSerialNumber:(NSString *)_str_serialNumber userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获得首页数据
-(void)postRequest_getHomePageData:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获得图形数据
-(void)postRequest_getGraphData:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获得GKK数据
-(void)postRequest_getGKK:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 更新手机号码获取手机验证码
-(void)postRequest_getMobileCodeUpdateMobile:(NSString *)_str_oldMobile newMobile:(NSString *)_str_newMobile userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 更新手机号码验证手机验证码
-(void)postRequest_checkMobileCodeUpdateMobile:(NSString *)_str_oldMobile newMobile:(NSString *)_str_newMobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获取设备列表
-(void)postRequest_getDevices:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 删除设备
-(void)postRequest_deleteDevice:(NSString *)_SN userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 新增投诉
-(void)postRequest_addComplaint:(NSString *)_str_problemType problem:(NSString *)_str_problem userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 追加用户获取手机验证码
-(void)postRequest_GetMobileCodeAdditionalUser:(NSString *)_str_mobile userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 追加用户手机验证码
-(void)postRequest_checkMobileAdditionalUser:(NSString *)_str_mobile vCode:(NSString *)_str_vCode userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 追加用户
-(void)postRequest_SubmitAdditionalInfo:(NSString *)_str_mobile name:(NSString *)_str_name userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 预定GKK
-(void)postRequest_bookGkk:(NSString *)_str_name address:(NSString *)_str_address gkk:(int)_gkk userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 设置默认设备
-(void)postRequest_setDefaultDevice:(NSString *)_str_deviceId userinfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获取预定用户信息
-(void)postRequest_getBookUserInfo:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获取订单历史
-(void)postRequest_orderHistory:(NSMutableDictionary *)_dic_userinfo;
#pragma mark - 获得城市列表的json文件
-(void)postRequest_getCityList:(NSMutableDictionary *)_dic_userinfo;
@end









