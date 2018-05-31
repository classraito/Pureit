//
//  FGLoginUpdateProfileViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLoginUpdateProfileViewController.h"
#import "Global.h"
#import "FGRegisterPhoneNumVerifyCodeView.h"
#import "FGRegisterProfileView.h"
#import "FGRegisterFinishView.h"
#import "FGProgressStepDotView.h"
#import "FGDatePickerView.h"
#import "FGCustomTextFieldView.h"
#import "FGRegisterQRCodeScanView.h"
#import "FGRegisterConnectDeviceWifiPasswdView.h"
@interface FGLoginUpdateProfileViewController ()
{
    UserInfoBy userinfoBy;
}
@end

@implementation FGLoginUpdateProfileViewController

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoBy:(UserInfoBy)_userinfoBy
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate.slideViewController.needSwipeShowMenu=NO;
    self.view_topPanel.iv_settings.hidden = NO;
    self.view_topPanel.btn_settings.hidden = NO;
    
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"个人资料");
    [view_progressDotView removeFromSuperview];
    view_progressDotView = nil;
    [view_phonNumVerifyCode removeFromSuperview];
    view_phonNumVerifyCode = nil;
    [view_connectDeviceWifiPasswd removeFromSuperview];
    view_connectDeviceWifiPasswd = nil;
    [view_qrCodeScan removeFromSuperview];
    view_qrCodeScan = nil;
    
    [self internalInitalUpdateProfileView];
    
    [view_updateprofile.cb_submit setFrame:view_updateprofile.cb_submit.frame title:multiLanguage(@"UPDATE")  arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    [view_updateprofile.ctf_mobile setRightThumbnail:nil];

    
    
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObjectSafty:@"getCitylistBeforeUpdateProfile" forKey:@"getCitylistBeforeUpdateProfile"];
    [[NetworkManager sharedManager] postRequest_getCityList:dic_params];
    
    view_updateprofile.cb_submit.hidden = YES;
    view_updateprofile.delegate = self;
    
    view_updateprofile.cb_deviceType.lb_title.text = @"  ";
    view_updateprofile.cb_deviceType.hidden = YES;
}

-(void)internalInitalUpdateProfileView
{
    if(view_updateprofile)
        return;
    view_updateprofile = (FGUpdateProfileVIew *)[[[NSBundle mainBundle] loadNibNamed:@"FGUpdateProfileVIew" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_updateprofile];
    
    
    [view_updateprofile.cb_submit.button addTarget:self action:@selector(buttonAction_submit:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *img_thumbnail = [UIImage imageNamed:@"editicon.png"];
    [view_updateprofile.ctf_name setRightThumbnail:img_thumbnail];
    [view_updateprofile.ctf_email setRightThumbnail:img_thumbnail];
    
    view_updateprofile.ctf_mobile.tf.textColor = [UIColor darkGrayColor];
    view_updateprofile.ctf_mobile.tf.userInteractionEnabled = NO;
    
    view_updateprofile.ctf_customID.tf.textColor = [UIColor darkGrayColor];
    view_updateprofile.ctf_customID.tf.userInteractionEnabled = NO;
    
    [view_updateprofile.ctf_landline setRightThumbnail:img_thumbnail];
    [view_updateprofile.ctf_street setRightThumbnail:img_thumbnail];
}


-(void)doBindDataToUI:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_username = [_dic_userinfo objectForKey:@"Name"];
    NSString *_str_mobile = [_dic_userinfo objectForKey:@"Mobile"];
    NSString *_str_email = [_dic_userinfo objectForKey:@"Email"];
     NSString *_str_person = [_dic_userinfo objectForKey:@"Person"];
    NSString *_str_city = [_dic_userinfo objectForKey:@"City"];
    NSString *_str_cityId = [_dic_userinfo objectForKey:@"CityId"];
    NSString *_str_address = [_dic_userinfo objectForKey:@"Address"];
    NSString *_str_landLine = [_dic_userinfo objectForKey:@"LandLine"];
    NSString *_str_customID = @"";
    if([[_dic_userinfo allKeys] containsObject:@"CustomerID"])
    {
        _str_customID = [_dic_userinfo objectForKey:@"CustomerID"];
    }
    if(![StringValidate isEmpty:_str_username])
        view_updateprofile.ctf_name.tf.text = _str_username;
    
    if(![StringValidate isEmpty:_str_customID])
    {
        view_updateprofile.ctf_customID.tf.text = [NSString stringWithFormat:@"%@ : %@",multiLanguage(@"客户ID"),_str_customID];
        
    }
   
    
    if(![StringValidate isEmpty:_str_email])
    {
        
        view_updateprofile.ctf_email.tf.text = _str_email;
        
        if(![StringValidate isEmpty:_str_person] && ![multiLanguage(@"家庭成员 *") isEqualToString: _str_person])
        {
            view_updateprofile.cb_familyMember.lb_title.text = _str_person;
            view_updateprofile.cb_familyMember.lb_title.textColor = [UIColor blackColor];
        }
        
        if(![StringValidate isEmpty:_str_city] && ![multiLanguage(@"省份，城市，地区 *") isEqualToString: _str_city])
        {
            view_updateprofile.cb_province.lb_title.text = _str_city;
            view_updateprofile.cb_province.lb_title.textColor = [UIColor blackColor];
        }
        
        if(![StringValidate isEmpty:_str_mobile])
        {
            view_updateprofile.ctf_mobile.tf.text = _str_mobile;
            view_updateprofile.ctf_mobile.tf.textColor = [UIColor blackColor];
        }
        
        if(![StringValidate isEmpty:_str_address])
        {
            view_updateprofile.ctf_street.tf.text = _str_address;
            view_updateprofile.ctf_street.tf.textColor = [UIColor blackColor];
        }
        
        if(![StringValidate isEmpty:_str_landLine])
        {
            view_updateprofile.ctf_landline.tf.text = _str_landLine;
            view_updateprofile.ctf_landline.tf.textColor = [UIColor blackColor];
        }
        if(![StringValidate isEmpty:_str_cityId])
        {
            view_updateprofile.areaID = _str_cityId;
            
        }
        
    }
    else
    {
        view_updateprofile.ctf_email.hidden = YES;
        view_updateprofile.ctf_landline.hidden = YES;
        view_updateprofile.ctf_street.hidden = YES;
        view_updateprofile.cb_familyMember.hidden = YES;
        view_updateprofile.cb_province.hidden = YES;
        view_updateprofile.cb_deviceType.hidden = YES;
        view_updateprofile.ctf_mobile.frame = view_updateprofile.ctf_email.frame;
        
        if([StringValidate isEmpty:_str_customID])
        {
            view_updateprofile.ctf_mobile.frame = view_updateprofile.ctf_customID.frame;
            [view_updateprofile.ctf_customID removeFromSuperview];
            view_updateprofile.ctf_customID = nil;
        }//第二个注册的用户没有custom ID 移除该UI

    }
   
}

-(void)bindDataByWebApiInfoIfNeeded
{
    
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_userinfo = [dataManager getDataByUrl:HOST(URL_GetUserInfo)];
    [self doBindDataToUI:_dic_userinfo];
    NSString *_str_mobile = [_dic_userinfo objectForKey:@"Mobile"];
    if(![StringValidate isEmpty:_str_mobile])
    {
        view_updateprofile.ctf_mobile.tf.text = _str_mobile;
        view_updateprofile.ctf_mobile.tf.textColor = [UIColor darkGrayColor];
        view_updateprofile.ctf_mobile.userInteractionEnabled = NO;
    }

    
}

-(void)buttonAction_back:(id)_sender;
{
    view_updateprofile.delegate = nil;
    [appDelegate.slideViewController showRightViewController:YES];
    [nav_main popViewControllerAnimated:YES];
}

-(void)do_submitProfile
{
    [super do_submitProfile];
    
    view_registerFinish.lb_title.text = multiLanguage(@"恭喜");
    view_registerFinish.lb_description.text = multiLanguage(@"您的个人资料已经更新成功!");
    

}

-(void)buttonAction_submit:(id)_sender
{
    
    NSLog(@"view_updateprofile = %@",view_updateprofile);
    [view_updateprofile closeAllPopupAndKeyboard];
    [self getsture_cancelKeyboard:nil];
    
    NSString *_str_name = view_updateprofile.ctf_name.tf.text;
    NSString *_str_mobile = view_updateprofile.ctf_mobile.tf.text;
    NSString *_str_email = view_updateprofile.ctf_email.tf.text;
    NSString *_str_familyMember = view_updateprofile.cb_familyMember.lb_title.text;
    NSString *_str_province = view_updateprofile.cb_province.lb_title.text;
    NSString *_str_areaID = view_updateprofile.areaID;
    NSLog(@"_str_areID = %@",_str_areaID);
    NSString *_str_street = view_updateprofile.ctf_street.tf.text;
    NSString *_str_landline = view_updateprofile.ctf_landline.tf.text;
    NSString *str_errorMessage = nil;
    
    if([_str_name length]<=0)
    {
        view_updateprofile.ctf_name.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"请输入用户名");
        view_updateprofile.ctf_name.tf.text = str_errorMessage;
    }
    if([StringValidate isEmpty:_str_email] && !view_updateprofile.ctf_email.hidden)
    {
        view_updateprofile.ctf_email.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"您还没有填写电子邮件");
        view_updateprofile.ctf_email.tf.text = str_errorMessage;
    }
    if(![StringValidate isEmpty:_str_email]&&![StringValidate isEmail:_str_email ]&& !view_updateprofile.ctf_email.hidden)
    {
        view_updateprofile.ctf_email.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"电子邮件格式不正确");
        view_updateprofile.ctf_email.tf.text = str_errorMessage;
    }
    if([StringValidate isEmpty:_str_mobile])
    {
        view_updateprofile.ctf_mobile.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
        view_updateprofile.ctf_mobile.tf.text = str_errorMessage;
    }
    if(![StringValidate isMobileNum:_str_mobile ])
    {
        view_updateprofile.ctf_mobile.tf.textColor = [UIColor redColor];
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
        view_updateprofile.ctf_mobile.tf.text = str_errorMessage;
    }
    if([multiLanguage(@"家庭成员 *") isEqualToString: _str_familyMember]&& !view_updateprofile.cb_familyMember.hidden)
    {
        [view_updateprofile.cb_familyMember.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [view_updateprofile.cb_familyMember.button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        str_errorMessage = multiLanguage(@"您还没有选择您的家庭成员");
        [view_updateprofile.cb_familyMember setFrame:view_updateprofile.cb_familyMember.frame title:str_errorMessage arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:[UIColor redColor] bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL, 16) needTitleLeftAligment:YES needIconBesideLabel:NO];
        
    }
    if([multiLanguage(@"省份，城市，地区 *") isEqualToString: _str_province]&& !view_updateprofile.cb_province.hidden)
    {
        [view_updateprofile.cb_province.button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [view_updateprofile.cb_province.button setTitleColor:[UIColor redColor] forState:UIControlStateHighlighted];
        str_errorMessage = multiLanguage(@"您还没有选择您的城市或地区");
        [view_updateprofile.cb_province setFrame:view_updateprofile.cb_province.frame title:str_errorMessage arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:[UIColor redColor] bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL,16) needTitleLeftAligment:YES needIconBesideLabel:NO];
    }
    
    if([StringValidate isEmpty:_str_street]&& !view_updateprofile.ctf_street.hidden)
    {
        str_errorMessage = multiLanguage(@"你还没有填写街道信息");
        view_updateprofile.ctf_street.tf.textColor = [UIColor redColor];
        view_updateprofile.ctf_street.tf.text = str_errorMessage;
    }
    
    if(view_updateprofile.ctf_name.tf.textColor != [UIColor redColor]&&
       view_updateprofile.ctf_mobile.tf.textColor != [UIColor redColor]&&
       view_updateprofile.cb_familyMember.lb_title.textColor != [UIColor redColor]&&
       view_updateprofile.cb_province.lb_title.textColor != [UIColor redColor]&&
       view_updateprofile.ctf_street.tf.textColor != [UIColor redColor] &&
       !str_errorMessage )
    {
        
        if(view_updateprofile.ctf_email.hidden)
        {
            _str_street = @"";
            _str_province = @"";
        }
        
        NSMutableDictionary *_dic_reginfo = [NSMutableDictionary dictionary];
        [_dic_reginfo setObject:_str_name forKey:@"Name"];
        [_dic_reginfo setObject:_str_email forKey:@"Email"];
        [_dic_reginfo setObject:_str_mobile forKey:@"Mobile"];
        [_dic_reginfo setObject:_str_landline forKey:@"LandLine"];
        [_dic_reginfo setObject:[NSNumber numberWithInt:[_str_familyMember intValue]] forKey:@"Person"];
        [_dic_reginfo setObject:_str_province forKey:@"City"];
        [_dic_reginfo setObjectSafty:_str_areaID forKey:@"CityId"];
        [_dic_reginfo setObject:_str_street forKey:@"Address"];
        
        [[NetworkManager sharedManager] postRequest_setUserInfo:_dic_reginfo userinfo:nil];
        
    }
    
}



-(void)buttonAction_go2HomePage:(id)_sender
{
    [nav_main popViewControllerAnimated:YES];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    if(!view_updateprofile)
        return;
    CGRect _frame = view_updateprofile.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height + 20;
    _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y;
    view_updateprofile.frame = _frame;
    view_updateprofile.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_updateprofile.center.y);
    
}
#pragma mark - FGRegisterProfileViewDelegate
-(void)ctfDidBeginEditing:(UITextField *)_tf customTF:(id)_customTF
{
    view_updateprofile.cb_submit.hidden = NO;
}

//TODO::<peng> 2016_4_13 修复选择pickView 提交按钮不显示
-(void)ctfDidSelectData:(NSString *)_str_selected picker:(id)_dataPicker
{
    view_updateprofile.cb_submit.hidden = NO;
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    if([HOST(URL_GetCityList) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"getCitylistBeforeUpdateProfile"])
        {
            NSMutableDictionary *_dic_requestInfo = [NSMutableDictionary dictionary];
            [_dic_requestInfo setObject:@"UpdateProfile" forKey:@"GetUserInfo"];
            [[NetworkManager sharedManager] postRequest_getUserInfo:_dic_requestInfo];
        }
    }
    if([HOST(URL_GetUserInfo) isEqualToString:_str_url])
    {
        
        if([[_dic_requestInfo allKeys] containsObject:@"GetUserInfo"])
        {
            NSString *_str_getUserInfoType = [_dic_requestInfo objectForKey:@"GetUserInfo"];
            if([@"UpdateProfile" isEqualToString:_str_getUserInfoType])
                [self bindDataByWebApiInfoIfNeeded];
        }
    }
    if([HOST(URL_SetUserInfo) isEqualToString:_str_url])
    {
        [self do_submitProfile];
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
