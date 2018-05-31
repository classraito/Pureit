//
//  FGRegisterStepViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "Scan_VC.h"
#import "FGRegisterConnectDeviceWifiPasswdView.h"
#import "FGCustomTextFieldView.h"
#import "WXApiWrapper.h"
@class FGProgressStepDotView;
@class FGRegisterPhoneNumVerifyCodeView;
@class FGRegisterProfileView;
@class FGRegisterFinishView;
@class FGRegisterConnectDeviceWifiPasswdView;
@class FGRegisterQRCodeScanView;
@class FGAddinationalUserRegistrationView;
@class FGAddinationalUserPhoneNumVerifyCodeView;
@class FGLoginView;
@class FGAddinationalUserUpdateMobileView;
@class FGResetDevicePopupView;
@class FGAdditionalUserRegistOptionView;


@interface FGRegisterStepViewController : FGBaseViewController<ScanVCDelegate,FGRegisterConnectDeviceWifiPasswdViewDelegate,FGCustomTextFieldViewDelegate,WXApiWrapperDelegate>
{
    FGProgressStepDotView *view_progressDotView;
    FGRegisterPhoneNumVerifyCodeView *view_phonNumVerifyCode;
    FGRegisterProfileView *view_profile;
    FGRegisterFinishView *view_registerFinish;
    FGRegisterConnectDeviceWifiPasswdView *view_connectDeviceWifiPasswd;
    FGRegisterQRCodeScanView *view_qrCodeScan;
    FGAddinationalUserRegistrationView *view_additionalUserRegistrationView;
    FGAddinationalUserPhoneNumVerifyCodeView *view_additionalUserPhoneNumView;
    FGAdditionalUserRegistOptionView *view_additionalRegistOption;
    FGLoginView *view_login;
    FGAddinationalUserUpdateMobileView *view_additionalUserUpdateMobile;
    FGResetDevicePopupView *view_resetPopup;
    
   
}
@property(retain,nonatomic)NSString *areaID;

-(void)internalInitalProfileView;
-(void)internalInitalConnectDeviceWifiPasswdView;
-(void)do_submitProfile;
@end
