//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterPhoneNumVerifyCodeView.h"
#import "Global.h"
#define MAXCOUNTER 60
@interface FGRegisterPhoneNumVerifyCodeView()
{
    NSTimer *timer;
    int timeCounter;
    UILabel *lb_OR;
}
@end

@implementation FGRegisterPhoneNumVerifyCodeView
@synthesize ctf_mobile;
@synthesize ctf_verifyCode;
@synthesize cb_next;
@synthesize cb_sendCode;
@synthesize lb_codeTimeLeft;
@synthesize lb_description;
@synthesize vsl_separator;
@synthesize cb_wechat_signIn;
@synthesize lb_title_wechatSignIn;
@synthesize view_wechatBg;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    ctf_mobile.delegate = self;
    ctf_verifyCode.delegate = self;
    timeCounter = MAXCOUNTER;
    
    ctf_mobile.tf.keyboardType = UIKeyboardTypeNumberPad;
    ctf_verifyCode.tf.keyboardType = UIKeyboardTypeNumberPad;
    ctf_verifyCode.tf.secureTextEntry = YES;
    ctf_mobile.tf.placeholder = multiLanguage(@"手机号码");
    ctf_verifyCode.tf.placeholder = multiLanguage(@"请输入6位验证码");
    
    ctf_mobile.maxInputLength = 11;
    ctf_verifyCode.maxInputLength = 6;
    
    lb_description.text = multiLanguage(@"Enter the one time password(OTP) that has been to sent to your mobile.");
    
    lb_description.hidden = YES;
    lb_codeTimeLeft.hidden = YES;
    ctf_verifyCode.hidden = YES;
    
    lb_description.font = font(FONT_NORMAL, 16);
    lb_codeTimeLeft.font = font(FONT_NORMAL, 16);
    
    
    [commond useDefaultRatioToScaleView:lb_codeTimeLeft];
    [commond useDefaultRatioToScaleView:lb_description];
    [commond useDefaultRatioToScaleView:ctf_mobile];
    [commond useDefaultRatioToScaleView:ctf_verifyCode];
    [commond useDefaultRatioToScaleView:cb_next];
    [commond useDefaultRatioToScaleView:cb_sendCode];
    
    if(H<=480)
    {
        isNeedViewMoveUpWhenKeyboardShow = YES;
    }
    else
    {
        isNeedViewMoveUpWhenKeyboardShow = NO;
    }
    
    
    [lb_description setLineSpace:7 * ratioH];
    
    cb_next.hidden = YES;
    
    if(cb_wechat_signIn)
    {
        lb_title_wechatSignIn.font = font(FONT_NORMAL, 16);
        lb_title_wechatSignIn.text = multiLanguage(@"Sign in through your WeChat ID");
        [commond useDefaultRatioToScaleView:cb_wechat_signIn];
        [commond useDefaultRatioToScaleView:lb_title_wechatSignIn];
        [commond useDefaultRatioToScaleView:vsl_separator];
        [commond useDefaultRatioToScaleView:view_wechatBg];
        
        lb_OR = [[UILabel alloc] initWithFrame:CGRectZero];
        lb_OR.textAlignment = NSTextAlignmentCenter;
        lb_OR.textColor = deepblue;
        lb_OR.text = multiLanguage(@"或者");
        lb_OR.font = font(FONT_NORMAL, 18);
        [lb_OR sizeToFit];
        lb_OR.userInteractionEnabled = YES;
    }
    else
    {
        ctf_mobile.layer.borderWidth = .5f;
        ctf_mobile.layer.borderColor = [UIColor lightGrayColor].CGColor;
        ctf_verifyCode.layer.borderWidth = .5f;
        ctf_verifyCode.layer.borderColor = [UIColor lightGrayColor].CGColor;

    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self setGetCodeButtonHighlighted:YES];
    [cb_next setFrame:cb_next.frame title:multiLanguage(@"下一步") arrimg:[UIImage imageNamed:@"arr-1.png"]
                thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20*ratioW font:font(FONT_BOLD, 22) needTitleLeftAligment:NO needIconBesideLabel:NO];
    
    if(cb_wechat_signIn)
    {
        [cb_wechat_signIn setFrame:cb_wechat_signIn.frame title:multiLanguage(@"WECHAT") arrimg:nil
                             thumb:[UIImage imageNamed:@"icon-wechat.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20*ratioW font:font(FONT_BOLD, 22) needTitleLeftAligment:NO needIconBesideLabel:NO];
        
        [vsl_separator setupByMiddleView:lb_OR padding:30 lineHeight:1 lineColor:deepblue];
    }
    
}

-(void)setGetCodeButtonHighlighted:(BOOL)_highlighted
{
    if(!_highlighted)
    {
        [cb_sendCode setFrame:cb_sendCode.frame title:multiLanguage(@"获取验证码") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:[UIColor lightGrayColor] padding:20 font:font(FONT_BOLD, 20) needTitleLeftAligment:NO needIconBesideLabel:NO];
        lb_description.hidden = NO;
        lb_codeTimeLeft.hidden = NO;
        cb_sendCode.userInteractionEnabled = NO;
        ctf_verifyCode.hidden = NO;
        if(!timer)
        {
            timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTimer) userInfo:nil repeats:YES];
            timeCounter = MAXCOUNTER;
        }
    }
    else
    {
        [cb_sendCode setFrame:cb_sendCode.frame title:multiLanguage(@"获取验证码") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:20 font:font(FONT_BOLD, 20) needTitleLeftAligment:NO needIconBesideLabel:NO];
        lb_description.hidden = YES;
        lb_codeTimeLeft.hidden = YES;
        ctf_verifyCode.hidden = YES;
        cb_sendCode.userInteractionEnabled = YES;
        [self cancelTimer];
    }
}

-(void)updateTimer
{
    timeCounter = timeCounter > 0 ? timeCounter - 1 : 0;
    lb_codeTimeLeft.text = [NSString stringWithFormat:@"(%d)",timeCounter];
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

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    ctf_mobile.delegate = nil;
    ctf_verifyCode.delegate = nil;
    [self cancelTimer];
}


#pragma mark -  FGCustomTextFieldDelegate
-(void)customTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string isLimited:(BOOL)_isLimited
{
    if([textField isEqual:ctf_verifyCode.tf])
    {
        if(_isLimited)
            cb_next.hidden = NO;
        else
            cb_next.hidden = YES;
    }
}

-(void)didClickDoneOnTextField:(UITextField *)_tf
{
    
}


@end
