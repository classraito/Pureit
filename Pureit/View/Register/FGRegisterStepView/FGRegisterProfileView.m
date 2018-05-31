//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterProfileView.h"
#import "Global.h"
#import "FGRegisterStepViewController.h"
#define MAXCOUNTER 60
@interface  FGRegisterProfileView()
{
    NSTimer *timer;
    int timeCounter;
}
@end

@implementation FGRegisterProfileView
@synthesize ctf_name;
@synthesize ctf_email;
@synthesize ctf_mobile;
@synthesize cb_familyMember;
@synthesize cb_province;
@synthesize ctf_street;
@synthesize cb_submit;
@synthesize ctf_landline;
@synthesize ctf_verifyCode;
@synthesize cb_sendVerifyCode;
@synthesize lb_timeCounter;
@synthesize view_datapicker_province;
@synthesize view_datapicker_familyMember;
@synthesize delegate;
@synthesize cb_deviceType;
@synthesize view_datapicker_deviceType;
@synthesize  areaID;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    ctf_verifyCode.hidden = YES;
    cb_sendVerifyCode.hidden = YES;
    lb_timeCounter.hidden = YES;
    ctf_landline.hidden = NO;
    
    ctf_name.delegate = self;
    ctf_mobile.delegate = self;
    ctf_landline.delegate = self;
    
    ctf_email.delegate = self;
    ctf_street.delegate = self;
    
    ctf_mobile.tf.keyboardType = UIKeyboardTypeNumberPad;
    ctf_landline.tf.keyboardType = UIKeyboardTypeNumberPad;
    
    ctf_email.tf.keyboardType = UIKeyboardTypeEmailAddress;
    
    
    
    ctf_name.tf.placeholder = multiLanguage(@"姓名 *");
    ctf_email.tf.placeholder = multiLanguage(@"邮箱 *");
    ctf_mobile.tf.placeholder = multiLanguage(@"手机号码 *");
    ctf_landline.tf.placeholder = multiLanguage(@"备用号码");
    
    ctf_street.tf.placeholder = multiLanguage(@"街道，门牌号 *");
    
    ctf_landline.maxInputLength = 11;
    
    ctf_mobile.maxInputLength = 11;
    ctf_name.maxInputLength = 15;
    ctf_email.maxInputLength = 200;
    ctf_street.maxInputLength = 200;
    
    
    [commond useDefaultRatioToScaleView:ctf_name];
    [commond useDefaultRatioToScaleView:ctf_email];
    [commond useDefaultRatioToScaleView:ctf_mobile];
    [commond useDefaultRatioToScaleView:ctf_landline];
    
    
    [commond useDefaultRatioToScaleView:cb_familyMember];
    [commond useDefaultRatioToScaleView:cb_province];
    [commond useDefaultRatioToScaleView:ctf_street];
    [commond useDefaultRatioToScaleView:cb_submit];
    
    [commond useDefaultRatioToScaleView:cb_deviceType];
   
   
    ctf_name.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_email.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_mobile.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_landline.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    cb_familyMember.layer.borderColor = [UIColor lightGrayColor].CGColor;
    cb_province.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_street.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    cb_deviceType.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
    ctf_name.layer.borderWidth = .5;
    ctf_email.layer.borderWidth = .5;
    ctf_mobile.layer.borderWidth = .5;
    ctf_landline.layer.borderWidth = .5;
    
    cb_familyMember.layer.borderWidth = .5;
    cb_province.layer.borderWidth = .5;
    ctf_street.layer.borderWidth = .5;
    cb_deviceType.layer.borderWidth = .5;
    
    
    
    [cb_familyMember setFrame:cb_familyMember.frame title:multiLanguage(@"家庭成员 *") arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:rgb(200, 200, 200) bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL, 16) needTitleLeftAligment:YES needIconBesideLabel:NO];
    [cb_province setFrame:cb_province.frame title:multiLanguage(@"省份，城市，地区 *") arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:rgb(200, 200, 200) bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL,16) needTitleLeftAligment:YES needIconBesideLabel:NO];
   
    [cb_deviceType setFrame:cb_deviceType.frame title:multiLanguage(@"Device type *") arrimg:[UIImage imageNamed:@"editicon.png"] thumb:nil borderColor:nil textColor:rgb(200, 200, 200) bgColor:[UIColor whiteColor] padding:20 font:font(FONT_NORMAL, 16) needTitleLeftAligment:YES needIconBesideLabel:NO];
    
    [self updateResgisterButtonStatus];
    
    [cb_familyMember.button addTarget:self action:@selector(buttonAction_familyMember:) forControlEvents:UIControlEventTouchUpInside];
    [cb_province.button addTarget:self action:@selector(buttonAction_province:) forControlEvents:UIControlEventTouchUpInside];
   
     [cb_deviceType.button addTarget:self action:@selector(buttonAction_deviceType:) forControlEvents:UIControlEventTouchUpInside];
    isNeedViewMoveUpWhenKeyboardShow = YES;

    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
}

-(void)setupProfileWithOTP
{
    ctf_landline.hidden = YES;
    ctf_verifyCode.hidden = NO;
    cb_sendVerifyCode.hidden = NO;
    lb_timeCounter.hidden = NO;
    
    timeCounter = MAXCOUNTER;
    
    [commond useDefaultRatioToScaleView:ctf_verifyCode];
    [commond useDefaultRatioToScaleView:cb_sendVerifyCode];
    [commond useDefaultRatioToScaleView:lb_timeCounter];
    
    ctf_verifyCode.delegate = self;
    ctf_verifyCode.tf.keyboardType = UIKeyboardTypeNumberPad;
    ctf_verifyCode.tf.placeholder = multiLanguage(@"请输入6位验证码");
    ctf_verifyCode.maxInputLength = 11;
    ctf_verifyCode.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_verifyCode.layer.borderWidth = .5;
    
    [cb_sendVerifyCode setFrame:cb_sendVerifyCode.frame title:multiLanguage(@"获取验证码") arrimg:nil thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20 font:font(FONT_BOLD, 16) needTitleLeftAligment:NO needIconBesideLabel:NO];
    
    lb_timeCounter.font = font(FONT_NORMAL, 16);
    
    NSLog(@"cb_sendVerifyCode = %@",cb_sendVerifyCode);
    
}

-(void)setGetCodeButtonHighlighted:(BOOL)_highlighted
{
    if(!_highlighted)
    {
        [cb_sendVerifyCode setFrame:cb_sendVerifyCode.frame title:multiLanguage(@"获取验证码") arrimg:nil thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:[UIColor lightGrayColor] padding:20 font:font(FONT_BOLD, 16) needTitleLeftAligment:NO needIconBesideLabel:NO];
        lb_timeCounter.hidden = NO;
        cb_sendVerifyCode.userInteractionEnabled = NO;
        ctf_verifyCode.hidden = NO;
        if(!timer)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
            timeCounter = MAXCOUNTER;
        }
    }
    else
    {
        [cb_sendVerifyCode setFrame:cb_sendVerifyCode.frame title:multiLanguage(@"获取验证码") arrimg:nil thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20 font:font(FONT_BOLD, 16) needTitleLeftAligment:NO needIconBesideLabel:NO];
        lb_timeCounter.hidden = YES;
        ctf_verifyCode.hidden = YES;
        cb_sendVerifyCode.userInteractionEnabled = YES;
        [self cancelTimer];
    }
}

-(void)updateTimer
{
    timeCounter = timeCounter > 0 ? timeCounter - 1 : 0;
    lb_timeCounter.text = [NSString stringWithFormat:@"(%d)",timeCounter];
    if(timeCounter == 0)
    {
        [self cancelTimer];
        [self setGetCodeButtonHighlighted:YES];
    }
}

-(void)cancelTimer
{
    if(timer)
    {
        [timer invalidate];
        timer = nil;
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    cb_familyMember.lb_title.font = font(FONT_NORMAL, 16);
    cb_province.lb_title.font = font(FONT_NORMAL, 16);
    cb_deviceType.lb_title.font = font(FONT_NORMAL, 16);
    cb_familyMember.layer.cornerRadius = 0;
    cb_province.layer.cornerRadius = 0;
    cb_deviceType.layer.cornerRadius = 0;
    [cb_familyMember setNeedsDisplay];
    [cb_province setNeedsDisplay];
    [cb_deviceType setNeedsDisplay];
   
}

-(void)setMobileNumber:(NSString *)_str_registedMobileNumber{
    if(_str_registedMobileNumber)
    {
        ctf_mobile.tf.text = _str_registedMobileNumber;
        ctf_mobile.tf.textColor = [UIColor darkGrayColor];
        ctf_mobile.tf.userInteractionEnabled = NO;
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    delegate = nil;
    if(view_datapicker_province)
    {
        [view_datapicker_province removeFromSuperview];
        view_datapicker_province = nil;
    }
    if(view_datapicker_familyMember)
    {
        [view_datapicker_familyMember removeFromSuperview];
        view_datapicker_familyMember = nil;
    }
    if(view_datapicker_deviceType)
    {
        [view_datapicker_deviceType removeFromSuperview];
        view_datapicker_deviceType = nil;
    }
    [self cancelTimer];
}

-(void)closeAllPopupAndKeyboard
{
    [ctf_name.tf resignFirstResponder];
    [ctf_email.tf resignFirstResponder];
    [ctf_landline.tf resignFirstResponder];
    [ctf_verifyCode resignFirstResponder];
    [ctf_mobile.tf resignFirstResponder];
    [ctf_street.tf resignFirstResponder];
    [ctf_verifyCode.tf resignFirstResponder];
    [view_datapicker_province removeFromSuperview];
    view_datapicker_province = nil;
    [view_datapicker_familyMember removeFromSuperview];
    view_datapicker_familyMember = nil;
    [view_datapicker_deviceType removeFromSuperview];
    view_datapicker_deviceType = nil;
    [appDelegate viewMoveDown];
}


-(void)buttonAction_familyMember:(id)_sender
{
    if(view_datapicker_familyMember)
        return;
    [view_datapicker_familyMember becomeFirstResponder];
    [ctf_name.tf resignFirstResponder];
    [ctf_landline.tf resignFirstResponder];
    [ctf_verifyCode resignFirstResponder];
    [ctf_mobile.tf resignFirstResponder];
    [ctf_email.tf resignFirstResponder];
    [ctf_street.tf resignFirstResponder];
    [ctf_verifyCode.tf resignFirstResponder];
    [self removeProvincePicker];
    [self removeDeviceTypePicker];
    
    view_datapicker_familyMember = (FGDataPickeriView *)[[[NSBundle mainBundle] loadNibNamed:@"FGDataPickeriView" owner:nil options:nil] objectAtIndex:0];
    view_datapicker_familyMember.delegate = self;
    [view_datapicker_familyMember setupDatas:@[@"1",@"2",@"3",@"4",@"5",@"6"]];
    CGRect _frame = view_datapicker_familyMember.frame;
    _frame.size.width = self.frame.size.width;
    _frame.origin.y = H;
    view_datapicker_familyMember.frame = _frame;
    view_datapicker_familyMember.center = CGPointMake(self.frame.size.width / 2, view_datapicker_familyMember.center.y);
    [appDelegate.window addSubview:view_datapicker_familyMember];
    
    [self didSelectData:multiLanguage(@"1") picker:view_datapicker_familyMember];
    [UIView beginAnimations:nil context:nil];
    _frame = view_datapicker_familyMember.frame;
    _frame.origin.y = H - view_datapicker_familyMember.frame.size.height;
    view_datapicker_familyMember.frame = _frame;
    [UIView commitAnimations];
    
    /*这断代码指定所有textfield成为焦点时向上移动的高度,向上移动的方法是baseViewController中的moveUp方法*/
    CGRect convertedFrame = [self convertRect:cb_familyMember.frame toView:nav_main.view];
    //从接受对象(self.superview)的坐标系转换一个点(self.frame)到指定视图(nav_main.view)的坐标系
    heightNeedMoveWhenKeybaordShow = convertedFrame.origin.y;
    if(heightNeedMoveWhenKeybaordShow > currentKeyboardHeight )
    {
        heightNeedMoveWhenKeybaordShow =  currentKeyboardHeight;
    }
    [appDelegate viewMoveUp:heightNeedMoveWhenKeybaordShow];
}

-(void)buttonAction_province:(id)_sender
{
    if(view_datapicker_province)
        return;
    [view_datapicker_province becomeFirstResponder];
    [ctf_name.tf resignFirstResponder];
    [ctf_landline.tf resignFirstResponder];
    [ctf_verifyCode resignFirstResponder];
    [ctf_mobile.tf resignFirstResponder];
    [ctf_email.tf resignFirstResponder];
    [ctf_street.tf resignFirstResponder];
    [ctf_verifyCode.tf resignFirstResponder];
    [self removeFamilyMemberPicker];
    [self removeDeviceTypePicker];
    view_datapicker_province = (FGAreaPickerView *)[[[NSBundle mainBundle] loadNibNamed:@"FGAreaPickerView" owner:nil options:nil] objectAtIndex:0];
    view_datapicker_province.delegate = self;
    CGRect _frame = view_datapicker_province.frame;
    _frame.size.width = self.frame.size.width;
    _frame.origin.y = H;
    view_datapicker_province.frame = _frame;
    view_datapicker_province.center = CGPointMake(self.frame.size.width / 2, view_datapicker_province.center.y);
    [appDelegate.window addSubview:view_datapicker_province];
    
    view_datapicker_province.areaID = multiLanguage(@"5,549,514") ;
    view_datapicker_province.areaValue = multiLanguage(@"上海,上海,南汇");
    [self didSelectData:view_datapicker_province.areaValue picker:view_datapicker_province];
    [UIView beginAnimations:nil context:nil];
    _frame = view_datapicker_province.frame;
    _frame.origin.y = H-view_datapicker_province.frame.size.height;
    view_datapicker_province.frame = _frame;
    [UIView commitAnimations];
    
    /*这断代码指定所有textfield成为焦点时向上移动的高度,向上移动的方法是baseViewController中的moveUp方法*/
    CGRect convertedFrame = [self convertRect:cb_province.frame toView:nav_main.view];
    //从接受对象(self.superview)的坐标系转换一个点(self.frame)到指定视图(nav_main.view)的坐标系
    heightNeedMoveWhenKeybaordShow = convertedFrame.origin.y;
    if(heightNeedMoveWhenKeybaordShow > currentKeyboardHeight )
    {
        heightNeedMoveWhenKeybaordShow =  currentKeyboardHeight;
    }
    [appDelegate viewMoveUp:heightNeedMoveWhenKeybaordShow];

}


-(void)buttonAction_deviceType:(id)_sender
{
    if(view_datapicker_deviceType)
        return;
    [view_datapicker_deviceType becomeFirstResponder];
    [ctf_name.tf resignFirstResponder];
    [ctf_landline.tf resignFirstResponder];
    [ctf_verifyCode resignFirstResponder];
    [ctf_mobile.tf resignFirstResponder];
    [ctf_email.tf resignFirstResponder];
    [ctf_street.tf resignFirstResponder];
    [self removeProvincePicker];
    [self removeFamilyMemberPicker];
    
    view_datapicker_deviceType = (FGDataPickeriView *)[[[NSBundle mainBundle] loadNibNamed:@"FGDataPickeriView" owner:nil options:nil] objectAtIndex:0];
    view_datapicker_deviceType.delegate = self;
    [view_datapicker_deviceType setupDatas:@[@"Smart UTS RO"]];
    CGRect _frame = view_datapicker_deviceType.frame;
    _frame.size.width = self.frame.size.width;
    _frame.origin.y = H;
    view_datapicker_deviceType.frame = _frame;
    view_datapicker_deviceType.center = CGPointMake(self.frame.size.width / 2, view_datapicker_deviceType.center.y);
    [appDelegate.window addSubview:view_datapicker_deviceType];
    
    [self didSelectData:multiLanguage(@"Smart UTS RO") picker:view_datapicker_deviceType];
    [UIView beginAnimations:nil context:nil];
    _frame = view_datapicker_deviceType.frame;
    _frame.origin.y = H - view_datapicker_deviceType.frame.size.height;
    view_datapicker_deviceType.frame = _frame;
    [UIView commitAnimations];
    
    /*这断代码指定所有textfield成为焦点时向上移动的高度,向上移动的方法是baseViewController中的moveUp方法*/
    CGRect convertedFrame = [self convertRect:cb_deviceType.frame toView:nav_main.view];
    //从接受对象(self.superview)的坐标系转换一个点(self.frame)到指定视图(nav_main.view)的坐标系
    heightNeedMoveWhenKeybaordShow = convertedFrame.origin.y;
    if(heightNeedMoveWhenKeybaordShow > currentKeyboardHeight )
    {
        heightNeedMoveWhenKeybaordShow =  currentKeyboardHeight;
    }
    [appDelegate viewMoveUp:heightNeedMoveWhenKeybaordShow];
}

#pragma mark -  FGCustomTextFieldDelegate
-(void)didBeginEditing:(UITextField *)_tf customTF:(id)_customTF
{
    [self removeFamilyMemberPicker];
    [self removeProvincePicker];
    [self removeDeviceTypePicker];
    _tf.textColor = [UIColor blackColor];
//    _tf.text = @"";//不需要清空
    if(delegate && [delegate respondsToSelector:@selector(ctfDidBeginEditing:customTF:)])
    {
        [delegate ctfDidBeginEditing:_tf customTF:_customTF];
    }
}

- (void)customTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string isLimited:(BOOL)_isLimited;
{
     [self updateResgisterButtonStatus];
}
-(void)didClickDoneOnTextField:(UITextField *)_tf
{
    [self updateResgisterButtonStatus];
}

-(void)removeProvincePicker
{
    if(!view_datapicker_province)
        return;
    if(view_datapicker_province.frame.origin.y>=H)
        return;
    [ctf_name.tf resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        CGRect _frame = view_datapicker_province.frame;
        _frame.origin.y = H;
        view_datapicker_province.frame = _frame;
    }completion:^(BOOL _finished){
       if(_finished)
       {
           [view_datapicker_province removeFromSuperview];
           view_datapicker_province = nil;
       }
    }];
    [appDelegate viewMoveDown];
}

-(void)removeFamilyMemberPicker
{
    if(!view_datapicker_familyMember)
        return;
    if(view_datapicker_familyMember.frame.origin.y>=H)
        return;
    [ctf_name.tf resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        CGRect _frame = view_datapicker_familyMember.frame;
        _frame.origin.y = H;
        view_datapicker_familyMember.frame = _frame;
    }completion:^(BOOL _finished){
        if(_finished)
        {
            [view_datapicker_familyMember removeFromSuperview];
            view_datapicker_familyMember = nil;
        }
    }];
    [appDelegate viewMoveDown];
}


-(void)removeDeviceTypePicker
{
    if(!view_datapicker_deviceType)
        return;
    if(view_datapicker_deviceType.frame.origin.y>=H)
        return;
    [ctf_name.tf resignFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        CGRect _frame = view_datapicker_deviceType.frame;
        _frame.origin.y = H;
        view_datapicker_deviceType.frame = _frame;
    }completion:^(BOOL _finished){
        if(_finished)
        {
            [view_datapicker_deviceType removeFromSuperview];
            view_datapicker_deviceType = nil;
        }
    }];
    [appDelegate viewMoveDown];
}


-(void)didCloseDataPicker:(NSString *)_str_selected picker:(id)_dataPicker
{
    if([_dataPicker isEqual:view_datapicker_familyMember])
    {
        cb_familyMember.lb_title.text = _str_selected;
        cb_familyMember.lb_title.textColor = [UIColor blackColor];
        [self removeFamilyMemberPicker];
    }
    if([_dataPicker isEqual:view_datapicker_province])
    {
        areaID = view_datapicker_province.areaID;
        cb_province.lb_title.text = _str_selected;
        cb_province.lb_title.textColor = [UIColor blackColor];
        [self removeProvincePicker];
        
    }
    
    if([_dataPicker isEqual:view_datapicker_deviceType])
    {
        cb_deviceType.lb_title.text = _str_selected;
        cb_deviceType.lb_title.textColor = [UIColor blackColor];
        [self removeDeviceTypePicker];
    }
    
    if(delegate && [delegate respondsToSelector:@selector(ctfDidSelectData:picker:)])
    {
        [delegate ctfDidSelectData:_str_selected picker:_dataPicker];
    }
    [self updateResgisterButtonStatus];
}

-(void)didSelectData:(NSString *)_str_selected ids:(NSString *)_str_selectedID picker:(id)_dataPicker
{
    if([_dataPicker isEqual:view_datapicker_province])
    {
        cb_province.lb_title.text = _str_selected;
        cb_province.lb_title.textColor = [UIColor blackColor];
        areaID = view_datapicker_province.areaID;
    }
}

-(void)didSelectData:(NSString *)_str_selected picker:(id)_dataPicker
{
    if([_dataPicker isEqual:view_datapicker_familyMember])
    {
        cb_familyMember.lb_title.text = _str_selected;
        cb_familyMember.lb_title.textColor = [UIColor blackColor];
    }
    
    if([_dataPicker isEqual:view_datapicker_deviceType])
    {
        cb_deviceType.lb_title.text = _str_selected;
        cb_deviceType.lb_title.textColor = [UIColor blackColor];
    }
    
    [self updateResgisterButtonStatus];
}


- (void)updateResgisterButtonStatus
{
    
    
    if ([self isFinishedAllInfomation]) {
        NSString *_str_title =multiLanguage(@"下一步");
        if([cb_submit.lb_title.text isEqualToString:multiLanguage(@"UPDATE")])
            _str_title = multiLanguage(@"UPDATE");//UPDATE 说明是登陆后设置菜单里的个人资料,不是注册时的
        
        [cb_submit setFrame:cb_submit.frame title:_str_title  arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
         cb_submit.userInteractionEnabled = YES;
    }
    else
    {
        if(ctf_email.hidden)
        {
            cb_submit.userInteractionEnabled = YES;
            return;//没有email说明是第二个用户 不执行以下
        }
        
        
        
        NSString *_str_title =multiLanguage(@"下一步");
        if([cb_submit.lb_title.text isEqualToString:multiLanguage(@"UPDATE")])
            _str_title = multiLanguage(@"UPDATE");
        
        [cb_submit setFrame:cb_submit.frame title:_str_title  arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:[UIColor lightGrayColor]];
        
        cb_submit.userInteractionEnabled = NO;
    }
}




/**
 *  判断所有信息是否输入完毕
 */
-(BOOL)isFinishedAllInfomation
{
    if (!ctf_name.tf.text||[ctf_name.tf.text isEqualToString:@""]) {
        return NO;
    }
    if (!ctf_email.tf.text||[ctf_email.tf.text isEqualToString:@""]) {
        return NO;
    }
    if (!ctf_mobile.tf.text||[ctf_mobile.tf.text isEqualToString:@""]) {
        return NO;
    }
    if (!ctf_street.tf.text||[ctf_street.tf.text isEqualToString:@""]) {
        return NO;
    }
    
    if (!cb_familyMember.lb_title.text||[multiLanguage(@"家庭成员 *") isEqualToString: cb_familyMember.lb_title.text]||[cb_familyMember.lb_title.text isEqualToString: @""]) {
        return NO;
    }
    if (!cb_province.lb_title.text||[multiLanguage(@"省份，城市，地区 *") isEqualToString:cb_province.lb_title.text]||[cb_province.lb_title.text isEqualToString: @""]) {
        return NO;
    }
    if (!cb_deviceType.lb_title.text||[multiLanguage(@"Device type *") isEqualToString:cb_deviceType.lb_title.text ]||[cb_deviceType.lb_title.text isEqualToString: @""]) {
        return NO;
    }

    return YES;
}

@end
