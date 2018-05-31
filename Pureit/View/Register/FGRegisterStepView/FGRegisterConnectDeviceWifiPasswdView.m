//
//  FGRegisterConnectDeviceWifiPasswdView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/22.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGRegisterConnectDeviceWifiPasswdView.h"
#import "Global.h"
@interface FGRegisterConnectDeviceWifiPasswdView()
{
    NSString *passwordString;
    NSString *ssidString;
    NSDictionary *dic_deviceData;
}
@end

@implementation FGRegisterConnectDeviceWifiPasswdView
@synthesize ctf_homeWifiName;
@synthesize ctf_homeWifiPasswd;
@synthesize cb_next;
@synthesize delegate;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    ctf_homeWifiName.delegate = self;
    ctf_homeWifiPasswd.delegate = self;
    
    ctf_homeWifiPasswd.tf.secureTextEntry = YES;
    ctf_homeWifiName.tf.placeholder = multiLanguage(@"Wifi SSID*");
    ctf_homeWifiPasswd.tf.placeholder = multiLanguage(@"Wifi密码*");
    
    ctf_homeWifiName.maxInputLength = 100;
    ctf_homeWifiPasswd.maxInputLength = 100;
    
    
    [self setupWifiName];
    
    ctf_homeWifiName.layer.borderWidth=.5;
    ctf_homeWifiName.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_homeWifiPasswd.layer.borderWidth=.5;
    ctf_homeWifiPasswd.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    [commond useDefaultRatioToScaleView:ctf_homeWifiName];
    [commond useDefaultRatioToScaleView:ctf_homeWifiPasswd];
    [commond useDefaultRatioToScaleView:cb_next];
    
    if(H<=568)
    {
        isNeedViewMoveUpWhenKeyboardShow = YES;
    }
    else
    {
        isNeedViewMoveUpWhenKeyboardShow = NO;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [cb_next setFrame:cb_next.frame title:multiLanguage(@"下一步") arrimg:[UIImage imageNamed:@"arr-1.png"]
                thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20*ratioW font:font(FONT_BOLD, 22) needTitleLeftAligment:NO needIconBesideLabel:NO];
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    self.delegate = nil;
    ctf_homeWifiName.delegate = nil;
    ctf_homeWifiPasswd.delegate = nil;
    [self stopConfigDevice];
}

-(void)setupWifiName
{
    if( easylink_config == nil){
        easylink_config = [[EASYLINK alloc]initWithDelegate:self];
    }
    ssidString = [EASYLINK ssidForConnectedNetwork];
    ctf_homeWifiName.tf.text = ssidString;
}

-(void)startConfigDeviceBySSID:(NSString *)_str_ssid passwd:(NSString *)_str_passwd{
    [commond showLoading];
    NSMutableDictionary *wlanConfig = [NSMutableDictionary dictionaryWithCapacity:20];
    if( easylink_config == nil){
        easylink_config = [[EASYLINK alloc]initWithDelegate:self];
    }
    
    if(!_str_ssid)
        ssidString = [EASYLINK ssidForConnectedNetwork];
    if(!_str_passwd)
        passwordString = ctf_homeWifiPasswd.tf.text;
    
    
    NSLog(@"ssidString = %@",ssidString);
    NSLog(@"passwordString = %@",passwordString);
    if(![self isPassCheck])
        return;
    
    NSData *ssidData = [EASYLINK ssidDataForConnectedNetwork];
    [wlanConfig setObject:ssidData forKey:KEY_SSID];
    [wlanConfig setObject:passwordString forKey:KEY_PASSWORD];
    [wlanConfig setObject:[NSNumber numberWithBool:YES] forKey:KEY_DHCP];
    
    [easylink_config prepareEasyLink_withFTC:wlanConfig info:nil mode:EASYLINK_V2_PLUS];
    
    [easylink_config transmitSettings];
    
    ctf_homeWifiName.tf.text = ssidString;
    ctf_homeWifiPasswd.tf.text = passwordString;
    
    [self performSelector:@selector(doTimeout) withObject:nil afterDelay:60];//60秒后 timeout
    
    dic_deviceData = nil;
    
}

-(void)startConfigDevice
{
    [self startConfigDeviceBySSID:nil passwd:nil];
}

-(void)doTimeout
{
    if(delegate && [delegate respondsToSelector:@selector(didTimeOutConfigDevice)])
    {
        [delegate didTimeOutConfigDevice];
    }
    [self stopConfigDevice];
    
}

-(void)stopConfigDevice
{
    if(easylink_config)
    {
        [commond removeLoading];
        [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(doTimeout) object:nil];
        [easylink_config stopTransmitting];
        [easylink_config unInit];
        easylink_config=nil;
        
    }
}

#pragma mark - EasyLink delegate -
- (void)onFoundByFTC:(NSNumber *)ftcClientTag withConfiguration: (NSDictionary *)configDict
{
    NSLog(@"New device found!");
    [easylink_config configFTCClient:ftcClientTag
                   withConfiguration: [NSDictionary dictionary] ];
    dic_deviceData = [configDict copy];
#ifdef DEBUG_MODE
   // [commond alert:@"debug" message:[NSString stringWithFormat:@"%@",configDict] callback:^(TAlertView *alertView, NSInteger buttonIndex) {}];
#endif
}

- (void)onDisconnectFromFTC:(NSNumber *)ftcClientTag
{
    [self stopConfigDevice];
    NSLog(@"Device disconnected!");
    if(dic_deviceData)
    {
        if(delegate && [delegate respondsToSelector:@selector(didConfigedDevice:)])
        {
            [delegate didConfigedDevice:dic_deviceData];
        }
    }
    else
    {
        if(delegate && [delegate respondsToSelector:@selector(didFailedConfigDevice:)])
        {
            [delegate didFailedConfigDevice:0];
        }
        [commond alert:@"警告" message:multiLanguage(@"CONNECT WIFI FAILED") callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
            
        }];
    }
}

- (void)onEasyLinkSoftApStageChanged: (EasyLinkSoftApStage)stage;
{
    [self stopConfigDevice];
    
    
    [commond alert:@"警告" message:[NSString stringWithFormat:@"stage: %d",stage] callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
        
    }];
}

#pragma mark - FGCustomTextFieldViewDelegate
-(void)didClickRightButton:(UIButton *)_btn customTF:(id)_customTF
{
    
}

-(BOOL)isPassCheck
{

    if([StringValidate isEmpty:ssidString])
    {
        [commond alert:@"警告" message:@"可能您还没有连上wifi，请重新尝试连接wifi" callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
        }];
        [commond removeLoading];
        return NO;
    }
    if([StringValidate isEmpty:passwordString])
    {
        [commond alert:@"警告" message:@"您还没有填写Wifi密码" callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
        }];
        [commond removeLoading];
        return NO;
    }
    
    return YES;
}
@end
