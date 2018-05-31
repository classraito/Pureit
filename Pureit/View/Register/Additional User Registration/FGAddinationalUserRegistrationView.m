//
//  FGAddinationalUserRegistrationView.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGAddinationalUserRegistrationView.h"
#import "Global.h"

#import "FGCallHelpLineView.h"

static CGFloat kTransitionDuration = 0.3;

@interface FGAddinationalUserRegistrationView()
{
    
}
@end

@implementation FGAddinationalUserRegistrationView
@synthesize lb_title_top;
@synthesize lb_option_registerAdditionalUser;
@synthesize lb_option_signinAsAnExistingUser;
@synthesize lb_option_updateMyPhoneNo;
@synthesize iv_option1;
@synthesize iv_option2;
@synthesize iv_option3;
@synthesize view_lineSeparator;
@synthesize lb_title_bottom;
@synthesize iv_icon_phone;
@synthesize lb_callHelpLine;
@synthesize cb_continue;
@synthesize view_mask;
@synthesize btn_callHelpLine;
@synthesize btn_option1;
@synthesize btn_option2;
@synthesize btn_option3;
@synthesize view_whiteBg;
@synthesize option;
-(void)awakeFromNib
{
    [super awakeFromNib];
    [commond useDefaultRatioToScaleView:lb_title_top];
    [commond useDefaultRatioToScaleView:lb_title_bottom];
    [commond useDefaultRatioToScaleView:lb_option_registerAdditionalUser];
    [commond useDefaultRatioToScaleView:lb_option_signinAsAnExistingUser];
    [commond useDefaultRatioToScaleView:lb_option_updateMyPhoneNo];
    [commond useDefaultRatioToScaleView:iv_option1];
    [commond useDefaultRatioToScaleView:iv_option2];
    [commond useDefaultRatioToScaleView:iv_option3];
    [commond useDefaultRatioToScaleView:view_lineSeparator];
    [commond useDefaultRatioToScaleView:lb_callHelpLine];
    [commond useDefaultRatioToScaleView:iv_icon_phone];
    [commond useDefaultRatioToScaleView:cb_continue];
    [commond useDefaultRatioToScaleView:view_mask];
    [commond useDefaultRatioToScaleView:btn_callHelpLine];
    [commond useDefaultRatioToScaleView:view_whiteBg];
    [commond useDefaultRatioToScaleView:btn_option3];
    [commond useDefaultRatioToScaleView:btn_option2];
    [commond useDefaultRatioToScaleView:btn_option1];
    
    
    view_whiteBg.layer.cornerRadius = 10;
    view_whiteBg.layer.masksToBounds = YES;
    
    lb_title_top.font = font(FONT_BOLD, 16);
    lb_title_bottom.font = font(FONT_NORMAL, 16);
    lb_option_registerAdditionalUser.font = font(FONT_BOLD, 16);
    lb_option_signinAsAnExistingUser.font = font(FONT_BOLD, 16);
    lb_option_updateMyPhoneNo.font  = font(FONT_BOLD, 16);
    lb_callHelpLine.font = font(FONT_BOLD, 16);
    
    lb_title_top.text = multiLanguage(@"This device has already been registered.");
    lb_title_bottom.text = multiLanguage(@"Need Help call us.");
    
    lb_callHelpLine.text = multiLanguage(@"CALL HELPLINE");
    
    lb_option_registerAdditionalUser.text = multiLanguage(@"Register as an additional user");
    lb_option_signinAsAnExistingUser.text = multiLanguage(@"Sign in");
    lb_option_updateMyPhoneNo.text = multiLanguage(@"Update my Phone number");
    
    
    [cb_continue setFrame:cb_continue.frame title:multiLanguage(@"CONTINUE") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    
    option = Option_RegisterAsAnAdditionalUser;
    
    [lb_callHelpLine sizeToFit];
    lb_callHelpLine.center = CGPointMake(view_whiteBg.frame.size.width / 2, lb_callHelpLine.center.y);
    CGRect _frame = iv_icon_phone.frame;
    _frame.origin.x = lb_callHelpLine.frame.origin.x - iv_icon_phone.frame.size.width - 2;
    iv_icon_phone.frame = _frame;
    iv_icon_phone.center = CGPointMake(iv_icon_phone.center.x, lb_callHelpLine.center.y);
    
    [lb_title_top setLineSpace:6 * ratioH alignment:NSTextAlignmentCenter];
    [lb_title_bottom setLineSpace:6 * ratioH alignment:NSTextAlignmentCenter];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, W, H);
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 9.0)
    {
        self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:kTransitionDuration/1.5];
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
        self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
        [UIView commitAnimations];

    }
}

-(IBAction)buttonAction_callHelpLine:(id)_sender;
{
//    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://13111111111"]]; //拨号
    
    view_callhelpline = (FGCallHelpLineView *)[[[NSBundle mainBundle] loadNibNamed:@"FGCallHelpLineView" owner:nil options:nil] objectAtIndex:0];
    [self.superview addSubview:view_callhelpline];
    [self.superview bringSubviewToFront:view_callhelpline];
    
}

-(IBAction)buttonAction_option1:(id)_sender;
{
    option = Option_RegisterAsAnAdditionalUser;
    iv_option1.highlighted = YES;
    iv_option2.highlighted = NO;
    iv_option3.highlighted = NO;
}

-(IBAction)buttonAction_option2:(id)_sender;
{
    option = Option_SignInAsAnExistingUser;
    iv_option1.highlighted = NO;
    iv_option2.highlighted = YES;
    iv_option3.highlighted = NO;
}

-(IBAction)buttonAction_option3:(id)_sender;
{
    option = Option_UpdateMyPhoneNo;
    iv_option1.highlighted = NO;
    iv_option2.highlighted = NO;
    iv_option3.highlighted = YES;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

- (CGAffineTransform)transformForOrientation {
    UIInterfaceOrientation orientation = [UIApplication sharedApplication].statusBarOrientation;
    if (orientation == UIInterfaceOrientationLandscapeLeft) {
        return CGAffineTransformMakeRotation(M_PI*1.5);
    } else if (orientation == UIInterfaceOrientationLandscapeRight) {
        return CGAffineTransformMakeRotation(M_PI/2);
    } else if (orientation == UIInterfaceOrientationPortraitUpsideDown) {
        return CGAffineTransformMakeRotation(-M_PI);
    } else {
        return CGAffineTransformIdentity;
    }
}


- (void)bounce1AnimationStopped {
   
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce2AnimationStopped)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    self.transform = [self transformForOrientation];
    self.transform = CGAffineTransformScale([self transformForOrientation], 1, 1);
    [UIView commitAnimations];
    
}
@end
