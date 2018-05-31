//
//  FGRegisterStepViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterStepViewController.h"
#import "Global.h"
#import "FGRegisterPhoneNumVerifyCodeView.h"
#import "FGRegisterProfileView.h"
#import "FGRegisterFinishView.h"
#import "FGProgressStepDotView.h"
#import "FGDatePickerView.h"
#import "FGRegisterConnectDeviceWifiPasswdView.h"
#import "FGRegisterQRCodeScanView.h"
#import "FGAddinationalUserRegistrationView.h"
#import "FGAddinationalUserPhoneNumVerifyCodeView.h"
#import "FGLoginView.h"
#import "FGAddinationalUserUpdateMobileView.h"
#import "FGResetDevicePopupView.h"
#import "FGAdditionalUserRegistOptionView.h"
#define KEYBOARD_HEIGHT 100
@interface FGRegisterStepViewController ()
{
    NSString *str_currentRegistedMobileNumber;
    CGRect originalFrame_view_qrCodeScan;
    Reachability *hostReach;
}

@end

@implementation FGRegisterStepViewController
@synthesize areaID;
- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myReachabilityChanged:) name:kReachabilityChangedNotification object:nil];
    hostReach = [Reachability reachabilityForInternetConnection];//可以以多种形式初始化
    [hostReach startNotifier]; //开始监听,会启动一个run loop
    
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"配置你的Pureit");
    self.view.backgroundColor = bgGray;
    self.view_statusBarBg.hidden = NO;
    [self internalInitalProgressDotView];
    [self internalInitalQRCodeScanView];
    [self internalInitalConnectDeviceWifiPasswdView];
    self.view_topPanel.iv_settings.hidden = YES;
    self.view_topPanel.btn_settings.hidden = YES;
}

#pragma kReachabilityChangedNotification

-(void)myReachabilityChanged:(NSNotification *)note
{
    if(!view_connectDeviceWifiPasswd )
        return;
    
    Reachability *currReach = [note object];
    NSParameterAssert([currReach isKindOfClass:[Reachability class]]);
    BOOL isReachableViaWifi = [[Reachability reachabilityForLocalWiFi] isReachable];
    NSLog(@"isReachableViaWifi = %d",isReachableViaWifi);
    if(isReachableViaWifi)
    {
        [view_connectDeviceWifiPasswd setupWifiName];
    }
    else
    {
        if(view_connectDeviceWifiPasswd.hidden)
            return;
        
        view_connectDeviceWifiPasswd.ctf_homeWifiName.tf.text = @"";
        [commond removeLoading];
        [commond alert:@"警告" message:multiLanguage(@"检测到您的手机还没有连接wifi,手机和pureit设备必须在同一个wifi环境中，才能让pureit设备连接wifi") callback:nil];
    }
}

-(void)dealloc
{
    [hostReach stopNotifier];
    hostReach = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kReachabilityChangedNotification object:nil];
    if(str_currentRegistedMobileNumber)
        str_currentRegistedMobileNumber = nil;
    
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - 初始化子视图
-(void)internalInitalProgressDotView
{
    if(view_progressDotView)
        return;
    view_progressDotView = (FGProgressStepDotView *)[[[NSBundle mainBundle] loadNibNamed:@"FGProgressStepDotView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_progressDotView];
    [commond useDefaultRatioToScaleView:view_progressDotView];
    
}

-(void)internalInitalConnectDeviceWifiPasswdView
{
    if(view_connectDeviceWifiPasswd)
        return;
    view_connectDeviceWifiPasswd = (FGRegisterConnectDeviceWifiPasswdView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterConnectDeviceWifiPasswdView" owner:nil options:nil] objectAtIndex:0];
    view_connectDeviceWifiPasswd.delegate = self;
    [self.view_contentView addSubview:view_connectDeviceWifiPasswd];
    [view_connectDeviceWifiPasswd.cb_next.button addTarget:self action:@selector(buttonAction_go2CreateAccount:) forControlEvents:UIControlEventTouchUpInside];
    view_connectDeviceWifiPasswd.hidden = YES;
}

-(void)internalInitalQRCodeScanView
{
    if(view_qrCodeScan)
        return;
    view_qrCodeScan = (FGRegisterQRCodeScanView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterQRCodeScanView" owner:nil options:nil] objectAtIndex:0];
    view_qrCodeScan.ctf_deviceID.delegate = self;
    [self.view_contentView addSubview:view_qrCodeScan];
    [view_qrCodeScan.cb_scanQR.button addTarget:self action:@selector(buttonAction_go2QRCodeScan:) forControlEvents:UIControlEventTouchUpInside];
    originalFrame_view_qrCodeScan = view_qrCodeScan.frame;
}

-(void)internalInitalPhoneNumVerifyCodeView
{
    if(view_phonNumVerifyCode)
        return;
    view_phonNumVerifyCode = (FGRegisterPhoneNumVerifyCodeView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterPhoneNumVerifyCodeView" owner:nil options:nil] objectAtIndex:1];//1-带微信注册按钮的界面 0-不带微信注册按钮
    [self.view_contentView addSubview:view_phonNumVerifyCode];
    [view_phonNumVerifyCode.cb_sendCode.button addTarget:self action:@selector(buttonAction_sendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [view_phonNumVerifyCode.cb_next.button addTarget:self action:@selector(buttonAction_go2Profile:) forControlEvents:UIControlEventTouchUpInside];
    [view_phonNumVerifyCode.cb_wechat_signIn.button addTarget:self action:@selector(buttonAction_weChatSignIn:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)internalInitalProfileView
{
    if(view_profile)
        return;
    view_profile = (FGRegisterProfileView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterProfileView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_profile];
    
    
    [view_profile.cb_submit.button addTarget:self action:@selector(buttonAction_submit:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *img_thumbnail = [UIImage imageNamed:@"editicon.png"];
    [view_profile.ctf_name setRightThumbnail:img_thumbnail];
    [view_profile.ctf_email setRightThumbnail:img_thumbnail];
    if(!str_currentRegistedMobileNumber)
    {
        [view_profile.ctf_mobile setRightThumbnail:img_thumbnail];
    }
    else
    {
        [view_profile setMobileNumber:str_currentRegistedMobileNumber];
    }
    
    [view_profile.ctf_landline setRightThumbnail:img_thumbnail];
    [view_profile.ctf_street setRightThumbnail:img_thumbnail];
}



-(void)internalInitalRegisterFinishView
{
    if(view_registerFinish)
        return;
    
    view_registerFinish = (FGRegisterFinishView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterFinishView" owner:nil options:nil] objectAtIndex:0];
    self.view_topPanel.str_title = multiLanguage(@"注册完成");
    [self.view_contentView addSubview:view_registerFinish];
    [view_registerFinish.cb_done.button addTarget:self action:@selector(buttonAction_go2HomePage:) forControlEvents:UIControlEventTouchUpInside];
    
    self.view_topPanel.lb_title.hidden = YES;
}

-(void)internalInitalAdditionalRegistrationUserView
{
    if(view_additionalUserRegistrationView)
        return;
    
    
    view_qrCodeScan.ctf_deviceID.delegate = nil;
    [view_progressDotView highlightedByIndex:1];
    [view_qrCodeScan removeFromSuperview];
    view_qrCodeScan = nil;
    view_connectDeviceWifiPasswd.delegate = nil;
    [view_connectDeviceWifiPasswd removeFromSuperview];
    view_connectDeviceWifiPasswd = nil;
    
    
    view_additionalUserRegistrationView = (FGAddinationalUserRegistrationView *)[[[NSBundle mainBundle] loadNibNamed:@"FGAddinationalUserRegistrationView" owner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:view_additionalUserRegistrationView];
    [view_additionalUserRegistrationView.cb_continue.button addTarget:self action:@selector(buttonAction_additionalRegistrationUserContinue:) forControlEvents:UIControlEventTouchUpInside ];
    [self manullyFixSize];
    [self.view bringSubviewToFront:view_additionalUserRegistrationView];
    
}

-(void)internalInitalPopupView:(NSString *)_str_devicdId
{
    if(view_resetPopup)
        return;
    
    view_resetPopup = (FGResetDevicePopupView *)[[[NSBundle mainBundle] loadNibNamed:@"FGResetDevicePopupView" owner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:view_resetPopup];
    view_resetPopup.str_deviceID = _str_devicdId;
    [view_resetPopup.cb_ok.button addTarget:self action:@selector(buttonAction_ok:) forControlEvents:UIControlEventTouchUpInside ];
    [self manullyFixSize];
    [self.view bringSubviewToFront:view_resetPopup];
}


-(void)internalInitalRegisteOptionView
{
    if(view_additionalRegistOption)
        return;
    
    view_progressDotView.lb3.hidden = YES;
    view_progressDotView.view_line2.hidden = YES;
    view_progressDotView.btn3.hidden = YES;
   
    view_additionalRegistOption = (FGAdditionalUserRegistOptionView *)[[[NSBundle mainBundle] loadNibNamed:@"FGAdditionalUserRegistOptionView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_additionalRegistOption];
    [view_additionalRegistOption.cb_wecheat.button addTarget:self action:@selector(buttonAction_weChatSignIn:) forControlEvents:UIControlEventTouchUpInside];
    [view_additionalRegistOption.cb_mobile.button addTarget:self action:@selector(do_go2AdditionalUserPhoneNum) forControlEvents:UIControlEventTouchUpInside];
    [self manullyFixSize];
}

-(void)internalInitalAdditionalUserPhoneNumView
{
    if(view_additionalUserPhoneNumView)
        return;

    view_progressDotView.lb3.hidden = YES;
    view_progressDotView.view_line2.hidden = YES;
    view_progressDotView.btn3.hidden = YES;
    
    
    view_additionalUserPhoneNumView = (FGAddinationalUserPhoneNumVerifyCodeView *)[[[NSBundle mainBundle] loadNibNamed:@"FGAddinationalUserPhoneNumVerifyCodeView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_additionalUserPhoneNumView];
    [view_additionalUserPhoneNumView.cb_sendCode.button addTarget:self action:@selector(buttonAction_additionalUserSendVerifyCode:) forControlEvents:UIControlEventTouchUpInside];
    [view_additionalUserPhoneNumView.cb_next.button addTarget:self action:@selector(buttonAction_additionalUserVerifyPhoneNum:) forControlEvents:UIControlEventTouchUpInside];
    [self manullyFixSize];
    
}

-(void)internalInitalLoginView
{
    if(view_login)
        return;
    
    view_login = (FGLoginView *)[[[NSBundle mainBundle] loadNibNamed:@"FGLoginView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_login];
    [view_login.cb_sendCode.button addTarget:self action:@selector(buttonAction_loginSendCode:) forControlEvents:UIControlEventTouchUpInside];
    [view_login.cb_next.button addTarget:self action:@selector(buttonAction_login:) forControlEvents:UIControlEventTouchUpInside];
    [self manullyFixSize];
}

-(void)internalInitalUpdateMobile
{
    if(view_additionalUserUpdateMobile)
        return;
    view_additionalUserUpdateMobile = (FGAddinationalUserUpdateMobileView *)[[[NSBundle mainBundle] loadNibNamed:@"FGAddinationalUserUpdateMobileView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_additionalUserUpdateMobile];
    [view_additionalUserUpdateMobile.cb_sendCode.button addTarget:self action:@selector(buttonAction_updateMobileSendCode:) forControlEvents:UIControlEventTouchUpInside];
    [view_additionalUserUpdateMobile.cb_next.button addTarget:self action:@selector(buttonAction_updateMobileVerifyPhoneNum:) forControlEvents:UIControlEventTouchUpInside];
    [self manullyFixSize];
    
    view_additionalUserUpdateMobile.lb_description.text = [NSString stringWithFormat:multiLanguage(@"we have sent a verification code to your email address %@."),@"(al**.Wa**dh@gmail.com)"];
}


#pragma mark - 布局子视图
-(void)internalLayoutFinishView
{
    view_registerFinish.frame = CGRectMake(0, LAYOUT_STATUSBAR_HEIGHT + LAYOUT_TOPVIEW_HEIGHT, self.view.frame.size.width, self.view.frame.size.height - LAYOUT_TOPVIEW_HEIGHT - LAYOUT_STATUSBAR_HEIGHT);
    
}

-(void)internalLayoutQRCodeScanView
{
    if(!view_qrCodeScan)
        return;
    CGRect _frame = view_qrCodeScan.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height+20*ratioH;
    _frame.size.height = originalFrame_view_qrCodeScan.size.height * ratioH;
    view_qrCodeScan.frame = _frame;
    view_qrCodeScan.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_qrCodeScan.center.y);
}

-(void)internalLayoutConnectDeviceWifiPasswdView
{
    if(!view_connectDeviceWifiPasswd)
        return;
    CGRect _frame = view_connectDeviceWifiPasswd.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_qrCodeScan.frame.origin.y + view_qrCodeScan.frame.size.height+20*ratioH;
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_connectDeviceWifiPasswd.frame = _frame;
    view_connectDeviceWifiPasswd.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_connectDeviceWifiPasswd.center.y);
}

-(void)internalLayoutPhoneNumVerifyCodeView
{
    if(!view_phonNumVerifyCode)
        return;
    CGRect _frame = view_phonNumVerifyCode.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height + 20 * ratioH;
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_phonNumVerifyCode.frame = _frame;
    view_phonNumVerifyCode.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_phonNumVerifyCode.center.y);
}

-(void)internalLayoutProfileView
{
    if(!view_profile)
        return;
    CGRect _frame = view_profile.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height;
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y + 5;
    view_profile.frame = _frame;
    view_profile.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_profile.center.y);
    [view_profile setNeedsLayout];
}

-(void)internalLayoutProgressDotView
{
    if(!view_progressDotView)
        return;
    CGRect _frame = view_progressDotView.frame;
    _frame.origin.y = LAYOUT_TOPVIEW_HEIGHT + LAYOUT_STATUSBAR_HEIGHT;
    _frame.size.width = self.view_contentView.frame.size.width;
    view_progressDotView.frame = _frame;
    view_progressDotView.center = CGPointMake(self.view_contentView.frame.size.width/2, view_progressDotView.center.y);
}

-(void)internalLayoutAdditionalRegistrationUserView
{
    if(!view_additionalUserRegistrationView)
        return;
    
    view_additionalUserRegistrationView.frame = CGRectMake(0, 0, W, H);
}

-(void)internalLayoutAdditionalUserRegistOptionView
{
    if(!view_additionalRegistOption)
        return;
    
    CGRect _frame = view_additionalRegistOption.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height+20*ratioH;
    
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_additionalRegistOption.frame = _frame;
    view_additionalRegistOption.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_additionalRegistOption.center.y);
    //TODO:居中
    CGPoint progressDotView_center = view_progressDotView.center;
    CGFloat line1_CenterX = (CGRectGetMinX(view_progressDotView.btn1.frame) + CGRectGetMaxX(view_progressDotView.btn2.frame))/2;
    CGFloat x_value = progressDotView_center.x - line1_CenterX;
    view_progressDotView.btn1.center = CGPointMake(view_progressDotView.btn1.center.x+x_value, view_progressDotView.btn1.center.y);
    view_progressDotView.btn2.center = CGPointMake(view_progressDotView.btn2.center.x+x_value, view_progressDotView.btn2.center.y);
    view_progressDotView.view_line1.center = CGPointMake(view_progressDotView.view_line1.center.x+x_value, view_progressDotView.view_line1.center.y);
    view_progressDotView.lb1.center = CGPointMake(view_progressDotView.lb1.center.x+x_value, view_progressDotView.lb1.center.y);
    view_progressDotView.lb2.center = CGPointMake(view_progressDotView.lb2.center.x+x_value, view_progressDotView.lb2.center.y);

}

-(void)internalLayoutAdditionalUserPhoneNumView
{
    if(!view_additionalUserPhoneNumView)
        return;
    
    CGRect _frame = view_additionalUserPhoneNumView.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
//    _frame.origin.y = self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height+ 20 * ratioH;
    
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height+20*ratioH;
    
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_additionalUserPhoneNumView.frame = _frame;
    view_additionalUserPhoneNumView.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_additionalUserPhoneNumView.center.y);
    
    //TODO:居中
    CGPoint progressDotView_center = view_progressDotView.center;
    CGFloat line1_CenterX = (CGRectGetMinX(view_progressDotView.btn1.frame) + CGRectGetMaxX(view_progressDotView.btn2.frame))/2;
    CGFloat x_value = progressDotView_center.x - line1_CenterX;
    view_progressDotView.btn1.center = CGPointMake(view_progressDotView.btn1.center.x+x_value, view_progressDotView.btn1.center.y);
     view_progressDotView.btn2.center = CGPointMake(view_progressDotView.btn2.center.x+x_value, view_progressDotView.btn2.center.y);
     view_progressDotView.view_line1.center = CGPointMake(view_progressDotView.view_line1.center.x+x_value, view_progressDotView.view_line1.center.y);
     view_progressDotView.lb1.center = CGPointMake(view_progressDotView.lb1.center.x+x_value, view_progressDotView.lb1.center.y);
     view_progressDotView.lb2.center = CGPointMake(view_progressDotView.lb2.center.x+x_value, view_progressDotView.lb2.center.y);
}

-(void)internalLayoutAdditionalLoginView
{
    if(!view_login)
        return;
    
    if(view_progressDotView)
    {
        [view_progressDotView removeFromSuperview];
        view_progressDotView = nil;
    }
    
    self.view_topPanel.str_title = multiLanguage(@"Sign in");
    
    CGRect _frame = view_login.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height + 20 * ratioH;
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_login.frame = _frame;
    view_login.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_login.center.y);
}

-(void)internalLayoutAdditionalUserUpdateMobile
{
    if(!view_additionalUserUpdateMobile)
        return;
    
    if(view_progressDotView)
    {
        [view_progressDotView removeFromSuperview];
        view_progressDotView = nil;
    }
    
    self.view_topPanel.str_title = multiLanguage(@"Update Mobile");
    
    CGRect _frame = view_additionalUserUpdateMobile.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height + 20 * ratioH;
    

    
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_additionalUserUpdateMobile.frame = _frame;
    view_additionalUserUpdateMobile.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_additionalUserUpdateMobile.center.y);
}

-(void)internalLayoutResetPopupView
{
    if(!view_resetPopup)
        return;
    
//    [view_resetPopup showPopup];
    
    view_resetPopup.frame = CGRectMake(0, 0, W, H);
}

/*-(void)showPopup
 {
 FGDialogView *_dialog = [[FGDialogView alloc] init];
 _dialog.delegate_dialog = self;
 [_dialog show];
 [_dialog addContentView:fgMapView];
 [_dialog release];
 }*/

#pragma mark - 从父类继承的手动布局方法,将在viewDidAppear和viewWillAppear时被调用
-(void)manullyFixSize
{
    [super manullyFixSize];
    
    [self internalLayoutProgressDotView];
    [self internalLayoutQRCodeScanView];
    [self internalLayoutConnectDeviceWifiPasswdView];
    [self internalLayoutPhoneNumVerifyCodeView];
    [self internalLayoutProfileView];
    [self internalLayoutFinishView];
    [self internalLayoutAdditionalRegistrationUserView];
    [self internalLayoutAdditionalUserRegistOptionView];
    [self internalLayoutAdditionalUserPhoneNumView];
    [self internalLayoutAdditionalLoginView];
    [self internalLayoutAdditionalUserUpdateMobile];
    
    [self internalLayoutResetPopupView];
}

#pragma mark - 界面跳转操作

-(void)do_go2CreateAccount
{
    
    view_qrCodeScan.ctf_deviceID.delegate = nil;
    [view_progressDotView highlightedByIndex:1];
    [view_qrCodeScan removeFromSuperview];
    view_qrCodeScan = nil;
    view_connectDeviceWifiPasswd.delegate = nil;
    [view_connectDeviceWifiPasswd removeFromSuperview];
    view_connectDeviceWifiPasswd = nil;
    
    [self internalInitalPhoneNumVerifyCodeView];
}

-(void)do_go2Profile
{
    [view_qrCodeScan.ctf_deviceID.tf resignFirstResponder];//移除键盘
    
    [view_phonNumVerifyCode cancelTimer];
    [view_progressDotView highlightedByIndex:2];
    [view_phonNumVerifyCode removeFromSuperview];
    view_phonNumVerifyCode = nil;
    [self internalInitalProfileView];
    [self manullyFixSize];
}

-(void)do_go2ProfileWithOTP
{
    [self do_go2Profile];
    [view_profile setupProfileWithOTP];
    [view_profile.cb_sendVerifyCode.button addTarget:self action:@selector(buttonAction_sendVerifyCodeInProfileView:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)do_go2AdditionalUserPhoneNum
{
    [view_additionalRegistOption removeFromSuperview];
    view_additionalRegistOption = nil;
    [self internalInitalAdditionalUserPhoneNumView];
    
}

-(void)do_submitProfile
{
    if(view_progressDotView)
    {
        [view_progressDotView removeFromSuperview];
        view_progressDotView = nil;
    }
    [view_profile removeFromSuperview];
    view_profile = nil;
    
    [self internalInitalRegisterFinishView];
    [self manullyFixSize];
}

-(void)do_afterSendVerifyCode
{
    if(view_progressDotView)
    {
        [view_progressDotView removeFromSuperview];
        view_progressDotView = nil;
    }
    [self internalInitalRegisterFinishView];
    [self manullyFixSize];
}


#pragma mark - button in FGRegisterPhoneNumPasswdView

-(void)buttonAction_go2QRCodeScan:(id)_sender
{
    Scan_VC*vc=[[Scan_VC alloc]init];
    vc.delegate = self;
    [self.navigationController pushViewController:vc animated:YES];
}

-(void)buttonAction_go2CreateAccount:(id)_sender
{
    if(!view_connectDeviceWifiPasswd)
        return;
    if(!view_qrCodeScan)
        return;
    
    NSString *_str_deviceId = view_qrCodeScan.ctf_deviceID.tf.text;
    NSString *_str_wifiName = view_connectDeviceWifiPasswd.ctf_homeWifiName.tf.text;
    NSString *_str_wifiPasswd = view_connectDeviceWifiPasswd.ctf_homeWifiPasswd.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_deviceId])
        str_errorMessage = multiLanguage(@"你还没有填写设备ID,你可以扫描设备上的二维码或直接输入");
    else if([StringValidate isEmpty:_str_wifiName])
        str_errorMessage = multiLanguage(@"可能您还没有连上wifi，请重新尝试连接wifi");
    else if([StringValidate isEmpty:_str_wifiPasswd])
        str_errorMessage = multiLanguage(@"你还没有填写wifi密码");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [appDelegate viewMoveDown];
        [appDelegate dismissKeyboard:self.view];
        [self internalInitalPopupView:view_qrCodeScan.ctf_deviceID.tf.text];
        
    }
}

-(void)buttonAction_sendVerifyCode:(id)_sender
{
    if(!view_phonNumVerifyCode)
        return;
    
    NSString *_str_mobile = view_phonNumVerifyCode.ctf_mobile.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        
        [[NetworkManager sharedManager] postRequest_getMobileCodeReg:_str_mobile userinfo:nil];
    }
}

-(void)buttonAction_sendVerifyCodeInProfileView:(id)_sender
{
    if(!view_profile)
        return;
    NSString *_str_mobile = view_profile.ctf_mobile.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        
        [[NetworkManager sharedManager] postRequest_getMobileCodeReg:_str_mobile userinfo:nil];
    }

}

-(void)buttonAction_additionalUserSendVerifyCode:(id)_sender
{
    if(!view_additionalUserPhoneNumView)
        return;
    NSString *_str_mobile = view_additionalUserPhoneNumView.ctf_mobile.tf.text;
    NSString *_str_name = view_additionalUserPhoneNumView.ctf_name.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    else if([StringValidate isEmpty:_str_name])
        str_errorMessage = multiLanguage(@"请填写您的姓名");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        
        [[NetworkManager sharedManager] postRequest_GetMobileCodeAdditionalUser:_str_mobile userinfo:nil];
    }
}

-(void)buttonAction_additionalUserVerifyPhoneNum:(id)_sender
{
    NSString *_str_mobile = view_additionalUserPhoneNumView.ctf_mobile.tf.text;
    NSString *_str_name = view_additionalUserPhoneNumView.ctf_name.tf.text;
    NSString *_str_verifyCode = view_additionalUserPhoneNumView.ctf_verifyCode.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    else if([StringValidate isEmpty:_str_name])
        str_errorMessage = multiLanguage(@"请填写您的姓名");
    else if([_str_verifyCode length] != 6 )
        str_errorMessage = multiLanguage(@"验证码必须要6位数字");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        
        [[NetworkManager sharedManager] postRequest_checkMobileAdditionalUser:_str_mobile vCode:_str_verifyCode userinfo:nil];
    }
}

-(void)buttonAction_loginSendCode:(id)_sender
{
    if(!view_login)
        return;
    NSString *_str_mobile = view_login.ctf_mobile.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        
        [[NetworkManager sharedManager] postRequest_getMobileCodeLogin:_str_mobile userinfo:nil];
    }
    
}

-(void)buttonAction_login:(id)_sender
{
    NSString *_str_mobile = view_login.ctf_mobile.tf.text;
    NSString *_str_verifyCode = view_login.ctf_verifyCode.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    else if([_str_verifyCode length] != 6 )
        str_errorMessage = multiLanguage(@"验证码必须要6位数字");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [[NetworkManager sharedManager] postRequest_checkMobileCodeLogin:_str_mobile vCode:_str_verifyCode userinfo:nil];
    }
    
}

-(void)buttonAction_updateMobileSendCode:(id)_sender
{
    if(!view_additionalUserUpdateMobile)
        return;
    NSString *_str_currentMobile = view_additionalUserUpdateMobile.ctf_currentMobile.tf.text;
    NSString *_str_newMobile = view_additionalUserUpdateMobile.ctf_newMobile.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_currentMobile])
        str_errorMessage = multiLanguage(@"旧手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_currentMobile ])
        str_errorMessage = multiLanguage(@"旧手机号码格式不正确");
    else if([StringValidate isEmpty:_str_newMobile])
        str_errorMessage = multiLanguage(@"新手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_newMobile ])
        str_errorMessage = multiLanguage(@"新手机号码格式不正确");
    else if([_str_newMobile isEqualToString:_str_currentMobile])
        str_errorMessage = multiLanguage(@"新手机号码和旧手机号码不能相同");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        
        [[NetworkManager sharedManager] postRequest_getMobileCodeUpdateMobile:_str_currentMobile newMobile:_str_newMobile userinfo:nil];
    }

}

-(void)buttonAction_updateMobileVerifyPhoneNum:(id)_sender
{
    NSString *_str_currentMobile = view_additionalUserUpdateMobile.ctf_currentMobile.tf.text;
    NSString *_str_newMobile = view_additionalUserUpdateMobile.ctf_newMobile.tf.text;
    NSString *_str_verifyCode = view_additionalUserUpdateMobile.ctf_verifyCode.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_currentMobile])
        str_errorMessage = multiLanguage(@"旧手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_currentMobile ])
        str_errorMessage = multiLanguage(@"旧手机号码格式不正确");
    else if([StringValidate isEmpty:_str_newMobile])
        str_errorMessage = multiLanguage(@"新手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_newMobile ])
        str_errorMessage = multiLanguage(@"新手机号码格式不正确");
    else if([_str_newMobile isEqualToString:_str_currentMobile])
        str_errorMessage = multiLanguage(@"新手机号码和旧手机号码不能相同");
    else if([_str_verifyCode length] != 6 )
        str_errorMessage = multiLanguage(@"验证码必须要6位数字");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [view_additionalUserUpdateMobile.ctf_currentMobile.tf resignFirstResponder];
        [view_additionalUserUpdateMobile.ctf_newMobile.tf resignFirstResponder];
        [view_additionalUserUpdateMobile.ctf_verifyCode.tf resignFirstResponder];
        [appDelegate viewMoveDown];
        [[NetworkManager sharedManager] postRequest_checkMobileCodeUpdateMobile:_str_currentMobile newMobile:_str_newMobile vCode:_str_verifyCode userinfo:nil];
    }
}

-(void)buttonAction_go2Profile:(id)_sender
{
    NSString *_str_mobile = view_phonNumVerifyCode.ctf_mobile.tf.text;
    NSString *_str_verifyCode = view_phonNumVerifyCode.ctf_verifyCode.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    else if([_str_verifyCode length] != 6 )
        str_errorMessage = multiLanguage(@"验证码必须要6位数字");
    
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        str_currentRegistedMobileNumber = [_str_mobile mutableCopy];
        [[NetworkManager sharedManager] postRequest_checkMobileCodeReg:_str_mobile vCode:_str_verifyCode userinfo:nil];
        //[self do_go2Profile];//TODO:fix it ,it's just for test
    }
    
}


-(void)buttonAction_submit:(id)_sender
{
    NSString *_str_name = view_profile.ctf_name.tf.text;
    NSString *_str_mobile = view_profile.ctf_mobile.tf.text;
    NSString *_str_email = view_profile.ctf_email.tf.text;
    NSString *_str_familyMember = view_profile.cb_familyMember.lb_title.text;
    NSString *_str_province = view_profile.cb_province.lb_title.text;
    NSString *_str_areaID = view_profile.areaID;
    NSString *_str_street = view_profile.ctf_street.tf.text;
    NSString *_str_landline = view_profile.ctf_landline.tf.text;
    NSString *_str_verifyCode = view_profile.ctf_verifyCode.tf.text;
    
    
    NSString *str_errorMessage = nil;
    
    if([_str_name length]<=0)
    {
        view_profile.ctf_name.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"请输入用户名");
        view_profile.ctf_name.tf.text = str_errorMessage;
    }
    if([StringValidate isEmpty:_str_email])
    {
        view_profile.ctf_email.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"您还没有填写电子邮件");
        view_profile.ctf_email.tf.text = str_errorMessage;
    }
    if(![StringValidate isEmpty:_str_email]&&![StringValidate isEmail:_str_email ])
    {
        view_profile.ctf_email.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"电子邮件格式不正确");
        view_profile.ctf_email.tf.text = str_errorMessage;
    }
    if([StringValidate isEmpty:_str_mobile])
    {
        view_profile.ctf_mobile.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
        view_profile.ctf_mobile.tf.text = str_errorMessage;
    }
    if(![StringValidate isMobileNum:_str_mobile ])
    {
        view_profile.ctf_mobile.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
        view_profile.ctf_mobile.tf.text = str_errorMessage;
    }
    if([multiLanguage(@"家庭成员 *") isEqualToString: _str_familyMember])
    {
        [view_profile.cb_familyMember.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [view_profile.cb_familyMember.button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        str_errorMessage = multiLanguage(@"您还没有选择您的家庭成员");
        [view_profile.cb_familyMember setFrame:view_profile.cb_familyMember.frame title:str_errorMessage arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:[UIColor redColor] bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL, 16) needTitleLeftAligment:YES needIconBesideLabel:NO];
    }
    if([multiLanguage(@"省份，城市，地区 *") isEqualToString: _str_province])
    {
        [view_profile.cb_province.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [view_profile.cb_province.button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        str_errorMessage = multiLanguage(@"您还没有选择您的城市或地区");
        [view_profile.cb_province setFrame:view_profile.cb_province.frame title:str_errorMessage arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:[UIColor redColor] bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL,16) needTitleLeftAligment:YES needIconBesideLabel:NO];
    }
    if([StringValidate isEmpty:_str_street])
    {
        str_errorMessage = multiLanguage(@"你还没有填写街道信息");
        view_profile.ctf_street.tf.textColor = [UIColor redColor];
        view_profile.ctf_street.tf.text = str_errorMessage;
    }
    
    if(!view_profile.ctf_verifyCode.hidden)
    {
        if([StringValidate isEmpty:_str_verifyCode] || [_str_verifyCode length] != 6)
        {
            
            view_profile.ctf_verifyCode.tf.textColor = [UIColor redColor];
            str_errorMessage = multiLanguage(@"验证码必须要6位数字");
            view_profile.ctf_verifyCode.tf.text = str_errorMessage;
        }
    }
    
    if(view_profile.ctf_name.tf.textColor != [UIColor redColor]&&
       view_profile.ctf_mobile.tf.textColor != [UIColor redColor]&&
       view_profile.cb_familyMember.lb_title.textColor != [UIColor redColor]&&
       view_profile.cb_province.lb_title.textColor != [UIColor redColor]&&
       view_profile.ctf_street.tf.textColor != [UIColor redColor] &&
       !str_errorMessage )
    {
        NSMutableDictionary *_dic_reginfo = [NSMutableDictionary dictionary];
        [_dic_reginfo setObject:_str_name forKey:@"Name"];
        [_dic_reginfo setObject:_str_email forKey:@"Email"];
        [_dic_reginfo setObject:_str_mobile forKey:@"Mobile"];
        [_dic_reginfo setObject:_str_landline forKey:@"LandLine"];
        [_dic_reginfo setObject:[NSNumber numberWithInt:[_str_familyMember intValue]] forKey:@"Person"];
        [_dic_reginfo setObject:_str_province forKey:@"City"];
        [_dic_reginfo setObject:_str_areaID forKey:@"CityId"];
        [_dic_reginfo setObject:_str_street forKey:@"Address"];
        
        if(view_profile.ctf_verifyCode.hidden)
            [[NetworkManager sharedManager] postRequest_submitRegInfo:_dic_reginfo userinfo:nil];//没有OTP直接提交
        else
        {
            str_currentRegistedMobileNumber = [_str_mobile mutableCopy];
            [[NetworkManager sharedManager] postRequest_checkMobileCodeReg:_str_mobile vCode:_str_verifyCode userinfo:_dic_reginfo];
        }//有OTP先检查验证码是否正确
        
    }
    [view_profile closeAllPopupAndKeyboard];
    [self getsture_cancelKeyboard:nil];
}

-(void)buttonAction_additionalRegistrationUserContinue:(id)_sender
{
    if(!view_additionalUserRegistrationView)
        return;
    
    switch (view_additionalUserRegistrationView.option) {
        case Option_RegisterAsAnAdditionalUser:
            [self internalInitalRegisteOptionView];
            break;
            
        case Option_SignInAsAnExistingUser:
            [self internalInitalLoginView];
            break;
            
        case Option_UpdateMyPhoneNo:
            [self internalInitalUpdateMobile];
            break;
    }
    
    [view_additionalUserRegistrationView removeFromSuperview];
    view_additionalUserRegistrationView = nil;
}



-(void)buttonAction_go2HomePage:(id)_sender
{
    [commond showLoading];
    [NetworkManager sharedManager].refreshCode = 0;
    [[NetworkManager sharedManager] postRequest_getHomePageData:nil];
}


-(void)buttonAction_ok:(id)_sender
{
    if(!view_resetPopup)
        return;
    

    //============================开发版预编译========================
#if defined (DEVELOPER)
    //以下代码直接上传测试机的mac地址可以跳过设备适配，用于模拟器测试*/
    NSMutableDictionary *_userinfo = [NSMutableDictionary dictionary];
    [_userinfo setObject:@"NEXT" forKey:@"STATUS"];
    [[NetworkManager sharedManager] postRequest_CheckSerialNumberReg:view_qrCodeScan.ctf_deviceID.tf.text mac:@"c89346c5d955" userinfo:_userinfo];
    [commond setUserDefaults:@"c89346c5d955" forKey:KEY_DEVICE_MAC_ADDRESS];
    //测试机器MAC地址:c89346c5d955 帐号:13512332312 deviceId:1234567890
#else
    [view_connectDeviceWifiPasswd startConfigDevice];//============================正式版预编译========================
#endif
    
    [view_resetPopup removeFromSuperview];
    view_resetPopup  = nil;
}

-(void)buttonAction_weChatSignIn:(id)_sender
{
   
    
    WXApiWrapper *wxapiWrapper = [WXApiWrapper sharedManager];
    wxapiWrapper.delegate = self;
    [wxapiWrapper loginInViewController:nav_main];
    
}

-(void)getsture_cancelKeyboard:(id)_sender
{
    [super getsture_cancelKeyboard:nil];
    if(view_profile)
    {
        [view_profile.view_datapicker_familyMember buttonAction_done:nil];
        [view_profile.view_datapicker_province buttonAction_done:nil];
        [view_profile.view_datapicker_deviceType buttonAction_done:nil];
        [view_profile updateResgisterButtonStatus];
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
        
        [commond setUserDefaults:_str_pureitDeviceMacAddress forKey:KEY_DEVICE_MAC_ADDRESS];
        NSString *_str_deviceId = (NSString *)[commond getUserDefaults:KEY_SERIALNUMBER];
        NSMutableDictionary *_userinfo = [NSMutableDictionary dictionary];
        [_userinfo setObject:@"NEXT" forKey:@"STATUS"];
        [[NetworkManager sharedManager] postRequest_CheckSerialNumberReg:_str_deviceId mac:_str_pureitDeviceMacAddress userinfo:_userinfo];
        
        
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
    [commond alert:multiLanguage(@"警告") message:multiLanguage(@"timeout") callback:nil];
}

#pragma mark - ScanVCDelegate
-(void)didScanQRCode:(NSString *)_str_qrCode
{
    if(!view_qrCodeScan)
        return;
    
    view_qrCodeScan.ctf_deviceID.tf.text = _str_qrCode;
}

-(void)customTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string isLimited:(BOOL)_isLimited
{
    if(!view_qrCodeScan)
        return;
    
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    NSLog(@"newLength = %ld" , newLength);
    if([textField isEqual:view_qrCodeScan.ctf_deviceID.tf])
    {
        if(_isLimited)
        {
            NSString *_str_deviceId = [textField.text stringByReplacingCharactersInRange: range withString: string];
            if(newLength==10)
                [[NetworkManager sharedManager] postRequest_CheckSerialNumberReg:_str_deviceId userinfo:nil];
            
        }
        else
        {
            view_connectDeviceWifiPasswd.hidden = YES;
        }
    }
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_CheckSerialNumberReg) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"STATUS"])
        {
            [self do_go2CreateAccount];
            [commond alert:@"警告" message:@"设备配网成功!" callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {}];
        }//上传MAC地址和deviceID成功
        else
        {
            if(view_qrCodeScan)
            {
                [view_qrCodeScan.ctf_deviceID.tf resignFirstResponder];
            }
//            [self internalInitalPopupView:view_qrCodeScan.ctf_deviceID.tf.text];
            view_connectDeviceWifiPasswd.hidden = NO;
            [view_connectDeviceWifiPasswd setupWifiName];
            isNeedViewMoveUpWhenKeyboardShow = YES;
            [view_connectDeviceWifiPasswd.ctf_homeWifiName becomeFirstResponder];
        }//检查deviceID成功
    }//根据STATUS 做 检查deviceID或上传mac地址
    
    if([HOST(URL_SubmitRegInfo) isEqualToString:_str_url])
    {
        [self do_submitProfile];
        currentAppStatus = AppStatus_userinfoSetted;
        [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];//设置app状态为用户已注册,并且已设置用户信息
    }//注册提交个人信息

    if([HOST(URL_GetMobileCodeReg) isEqualToString:_str_url])
    {
        if(view_phonNumVerifyCode)
        {
            isNeedViewMoveUpWhenKeyboardShow = YES;
            [view_phonNumVerifyCode.ctf_verifyCode.tf becomeFirstResponder];
            [view_phonNumVerifyCode setGetCodeButtonHighlighted:NO];
        }
        
        if(view_profile)
            [view_profile setGetCodeButtonHighlighted:NO];
        
    }//注册获取验证码
    
    if([HOST(URL_GetCityList) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"do_go2ProfileWithOTP"])
        {
           [self do_go2ProfileWithOTP];// 更UI
        }
        else if([[_dic_requestInfo allKeys] containsObject:@"do_go2profile"])
        {
            [self do_go2Profile];
        }//注册去下一页

    }//获得城市列表数据
    
    if([HOST(URL_CheckMobileCodeReg) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"LandLine"])
        {
            [[NetworkManager sharedManager] postRequest_submitRegInfo:_dic_requestInfo userinfo:nil];//有OTP 检查完验证码后 提交表单
        }
        else
        {
          // [self do_go2Profile];
            NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
            [dic_params setObjectSafty:@"do_go2profile" forKey:@"do_go2profile"];
            [[NetworkManager sharedManager] postRequest_getCityList:dic_params];
        }//注册去下一页
        
        
    }//提交表单结束
    
    if([HOST(URL_AdditionalUserGetMobileCode) isEqualToString:_str_url])
    {
        if(view_additionalUserPhoneNumView)
        {
            isNeedViewMoveUpWhenKeyboardShow = YES;
            [view_additionalUserPhoneNumView.ctf_verifyCode.tf becomeFirstResponder];
             [view_additionalUserPhoneNumView setGetCodeButtonHighlighted:NO];
        }
        
    }//追加用户获取验证码
    
    if([HOST(URL_AdditionalUserCheckMobileCode) isEqualToString:_str_url])
    {
        [[NetworkManager sharedManager] postRequest_SubmitAdditionalInfo:view_additionalUserPhoneNumView.ctf_mobile.tf.text name:view_additionalUserPhoneNumView.ctf_name.tf.text userinfo:nil];
    }//追加用户验证验证码
    
    if([HOST(URL_SubmitAdditionalInfo) isEqualToString:_str_url])
    {
        if(view_additionalUserPhoneNumView)
        {
            [view_additionalUserPhoneNumView removeFromSuperview];
            view_additionalUserPhoneNumView = nil;
        }
        [self do_afterSendVerifyCode];
    }//追加用户提交信息
    
    if([HOST(URL_GetMobileCodeLogin) isEqualToString:_str_url])
    {
        if(view_login)
        {
            [view_login setGetCodeButtonHighlighted:NO];
            isNeedViewMoveUpWhenKeyboardShow = YES;
            [view_login.ctf_verifyCode.tf becomeFirstResponder];
        }
        
    }//登录获得验证码
    
    if([HOST(URL_CheckMobileCodeLogin) isEqualToString:_str_url])
    {
        if(view_login)
        {
            [view_login removeFromSuperview];
            view_login = nil;
        }
        [self do_afterSendVerifyCode];
        view_registerFinish.lb_title.text = multiLanguage(@"Welcome Back");
        view_registerFinish.lb_description.text = multiLanguage(@"We missed you & we're glad to have you back");
    }//登录去完成页
    
    if([HOST(URL_UpdateGetMobileCode) isEqualToString:_str_url])
    {
        if(view_additionalUserUpdateMobile)
        {
            [view_additionalUserUpdateMobile setGetCodeButtonHighlighted:NO];
            isNeedViewMoveUpWhenKeyboardShow = YES;
            [view_additionalUserUpdateMobile.ctf_verifyCode.tf becomeFirstResponder];
        }
        
    }//更新手机号码获得验证码
    
    if([HOST(URL_UpdateCheckMobileCode) isEqualToString:_str_url])
    {
        
        [self do_afterSendVerifyCode];
        view_registerFinish.lb_title.text = multiLanguage(@"Welcome Back");
        view_registerFinish.lb_description.text = multiLanguage(@"We missed you & we're glad to have you back");
    }//更新手机号码去完成页
    
    if([HOST(URL_GetRefreshData) isEqualToString:_str_url])
    {
        if(![[_dic_requestInfo allKeys] containsObject:@"STATUS"])
        {
            
            [self go2HomeScreen];
        }
    }//获得首页实时刷新的数据
    
}

-(void)requestFailedFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_CheckSerialNumberReg) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"result"])
        {
            int code = [[[_dic_requestInfo objectForKey:@"result"] objectForKey:@"Code"] intValue];
            if(code == 101)//该设备已经被其他用户绑定，不可以在此绑定，请进入选项界面，继续绑定!
            {
              
                [self internalInitalAdditionalRegistrationUserView];
                
            }
        }
    }
}

#pragma mark - WXApiWrapperDelegate
-(void)wxDidReceiveUserInfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_dic_userinfo)
        return;
    if([_dic_userinfo count]<=0)
        return;
    NSLog(@"_dic_userinfo = %@",_dic_userinfo);
    dispatch_async(dispatch_get_main_queue(), ^{
        if(view_phonNumVerifyCode)
        {
            //[self do_go2ProfileWithOTP];// 更UI
            NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
            [dic_params setObjectSafty:@"do_go2ProfileWithOTP" forKey:@"do_go2ProfileWithOTP"];
            [[NetworkManager sharedManager] postRequest_getCityList:dic_params];

        }
        
        else if(view_additionalRegistOption)
            [self do_go2AdditionalUserPhoneNum];
    });
    
    
}
@end
