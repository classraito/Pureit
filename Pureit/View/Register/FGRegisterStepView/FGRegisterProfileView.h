//
//  FGRegisterPhoneNumPasswdView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
#import "FGCustomTextFieldView.h"
#import "FGAreaPickerView.h"
#import "FGDataPickeriView.h"
@protocol FGRegisterProfileViewDelegate<NSObject>
-(void)ctfDidBeginEditing:(UITextField *)_tf customTF:(id)_customTF;

//TODO::<peng> 2016_4_13 修复选择pickView 提交按钮不显示
-(void)ctfDidSelectData:(NSString *)_str_selected picker:(id)_dataPicker;
@end

@interface FGRegisterProfileView : UIView<FGCustomTextFieldViewDelegate,FGDataPickerViewDelegate,FGAreaPickerViewDelegate>
{
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_name;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_email;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_mobile;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_landline;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_verifyCode;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_sendVerifyCode;
@property(nonatomic,assign)IBOutlet UILabel *lb_timeCounter;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_familyMember;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_province;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_street;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_submit;

@property(nonatomic,assign)IBOutlet FGCustomButton *cb_deviceType;


@property (nonatomic,assign) FGDataPickeriView *view_datapicker_familyMember;
@property (nonatomic,assign) FGAreaPickerView *view_datapicker_province;
@property (nonatomic,assign) FGDataPickeriView *view_datapicker_deviceType;
@property (nonatomic,copy) NSString *areaID;
@property(nonatomic,assign)id<FGRegisterProfileViewDelegate> delegate;
-(void)setMobileNumber:(NSString *)_str_registedMobileNumber;
- (void) updateResgisterButtonStatus;
-(void)setupProfileWithOTP;
-(void)setGetCodeButtonHighlighted:(BOOL)_highlighted;
-(void)buttonAction_familyMember:(id)_sender;
-(void)buttonAction_province:(id)_sender;
-(void)buttonAction_deviceType:(id)_sender;
-(void)closeAllPopupAndKeyboard;
@end
