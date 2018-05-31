//
//  FGRegisterConnectDeviceWifiPasswdView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/22.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomTextFieldView.h"
#import "FGDataPickeriView.h"
#import "FGCustomButton.h"
#import "EASYLINK.h"
@protocol FGRegisterConnectDeviceWifiPasswdViewDelegate<NSObject>
-(void)didConfigedDevice:(NSDictionary *)_dic_data;
-(void)didFailedConfigDevice:(int)_errortype;
-(void)didTimeOutConfigDevice;
@end

@interface FGRegisterConnectDeviceWifiPasswdView : UIView<FGCustomTextFieldViewDelegate,EasyLinkFTCDelegate>
{
    FGDataPickeriView *view_dataPicker;
    EASYLINK *easylink_config;
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_homeWifiName;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_homeWifiPasswd;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_next;
@property(nonatomic,assign)id<FGRegisterConnectDeviceWifiPasswdViewDelegate>delegate;
-(void)startConfigDeviceBySSID:(NSString *)_str_ssid passwd:(NSString *)_str_passwd;
-(void)startConfigDevice;
-(void)setupWifiName;
@end
