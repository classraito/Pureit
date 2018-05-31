//
//  FGResetDevicePopupView.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGResetDevicePopupView.h"
#import "Global.h"
static CGFloat kTransitionDuration = 0.3;
@interface FGResetDevicePopupView()
{
    
}
@end

@implementation FGResetDevicePopupView
@synthesize view_whiteBg;
@synthesize lb_title;
@synthesize lb_subtitle;
@synthesize lb_step1;
@synthesize lb_step2;
@synthesize lb_tips;
@synthesize cb_ok;
@synthesize iv_thumbnail;
@synthesize str_deviceID;
@synthesize iv_ss;
-(void)awakeFromNib
{
    [super awakeFromNib];
    view_whiteBg.layer.cornerRadius = 10;
    view_whiteBg.layer.masksToBounds = YES;
    
    if([commond isChinese])
    {
        iv_ss.image = [UIImage imageNamed:@"Popup_EnableWifi_CN.png"];
    }
    else
    {
        iv_ss.image = [UIImage imageNamed:@"Popup_EnableWifi.png"];
    }
    
    [commond useDefaultRatioToScaleView:view_whiteBg];
    [commond useDefaultRatioToScaleView:lb_title];
    [commond useDefaultRatioToScaleView:lb_subtitle];
    [commond useDefaultRatioToScaleView:lb_step1];
    [commond useDefaultRatioToScaleView:lb_step2];
    [commond useDefaultRatioToScaleView:lb_tips];
    [commond useDefaultRatioToScaleView:cb_ok];
    [commond useDefaultRatioToScaleView:iv_thumbnail];
    [commond useDefaultRatioToScaleView:iv_ss];
    
    [cb_ok setFrame:cb_ok.frame title:multiLanguage(@"CONNECT") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    
    lb_title.font = font(FONT_BOLD, 16);
    lb_subtitle.font = font(FONT_NORMAL, 14);
    lb_step1.font = font(FONT_BOLD, 14);
    lb_step2.font = font(FONT_BOLD, 14);
    lb_tips.font = font(FONT_NORMAL, 14);
    
    [lb_title setLineSpace:8];
    [lb_subtitle setLineSpace:8];
    [lb_step2 setLineSpace:8];
    [lb_tips setLineSpace:8];
    self.frame = CGRectMake(0, 0, W, H);
}



-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.frame = CGRectMake(0, 0, W, H);
//    [self showPopup];
}

-(void)showPopup
{
    self.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    self.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
    [UIView commitAnimations];

    [self.layer removeAllAnimations];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    str_deviceID = nil;
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
