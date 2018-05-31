//
//  FGResetWifiViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/28.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGResetWifiViewController.h"
#import "Global.h"
#import "FGProgressStepDotView.h"
#import "FGRegisterQRCodeScanView.h"
@interface FGResetWifiViewController ()
{
    
}
@end

@implementation FGResetWifiViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
     appDelegate.slideViewController.needSwipeShowMenu=NO;
    isNeedViewMoveUpWhenKeyboardShow = NO;
     self.view_topPanel.iv_settings.hidden = YES;
     self.view_topPanel.btn_settings.hidden = YES;
     // Do any additional setup after loading the view from its nib.
     self.view_topPanel.str_title = multiLanguage(@"重置设备wifi连接");
     [view_progressDotView removeFromSuperview];
     view_progressDotView = nil;
     [view_qrCodeScan removeFromSuperview];
     view_qrCodeScan = nil;
     
     [self internalInitalConnectDeviceWifiPasswdView];
    view_connectDeviceWifiPasswd.hidden = NO;
    [view_connectDeviceWifiPasswd.ctf_homeWifiPasswd.tf becomeFirstResponder];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    if(!view_connectDeviceWifiPasswd)
        return;
    CGRect _frame = view_connectDeviceWifiPasswd.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height + 20;
    view_connectDeviceWifiPasswd.frame = _frame;
    view_connectDeviceWifiPasswd.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_connectDeviceWifiPasswd.center.y);
}

-(void)buttonAction_go2CreateAccount:(id)_sender
{
    if(!view_connectDeviceWifiPasswd)
        return;
    
    NSString *_str_wifiName = view_connectDeviceWifiPasswd.ctf_homeWifiName.tf.text;
    NSString *_str_wifiPasswd = view_connectDeviceWifiPasswd.ctf_homeWifiPasswd.tf.text;
    NSString *str_errorMessage = nil;
    
    if([StringValidate isEmpty:_str_wifiName])
        str_errorMessage = multiLanguage(@"可能您还没有连上wifi，请重新尝试连接wifi");
    else if([StringValidate isEmpty:_str_wifiPasswd])
        str_errorMessage = multiLanguage(@"你还没有填写wifi密码");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [view_connectDeviceWifiPasswd startConfigDevice];
        
    }
}

#pragma mark - FGRegisterConnectDeviceWifiPasswdViewDelegate
-(void)didConfigedDevice:(NSDictionary *)_dic_data
{
    NSLog(@":::::>didConfigedDevice _dic_data = %@",_dic_data);
    if(!_dic_data)
        return;
    if([_dic_data count]<=0)
        return;
    NSString *_str_tmp  = [_dic_data objectForKey:@"N"];
    NSInteger startIndex = [_str_tmp rangeOfString:@"("].location+1;
    NSInteger endIndex =  [_str_tmp rangeOfString:@")"].location;
    @try {
        NSString *_str_pureitDeviceMacAddress = [_str_tmp  substringWithRange:NSMakeRange(startIndex,endIndex - startIndex)];
        NSLog(@"_str_pureitDeviceMacAddress = %@",_str_pureitDeviceMacAddress);
        [commond alert:@"警告" message:@"设备配网成功!" callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {}];
        [nav_main popViewControllerAnimated:YES];
    }
    @catch (NSException *exception) {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"获取设备信息发生错误") callback:nil];
    }
}

-(void)didFailedConfigDevice:(int)_errortype
{
    NSLog(@":::::>didFailedConfigDevice %d",_errortype);
}

-(void)didTimeOutConfigDevice
{
    NSLog(@":::::>didTimeOutConfigDevice");
    [commond alert:multiLanguage(@"警告") message:multiLanguage(@"CONNECT WIFI FAILED") callback:nil];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
