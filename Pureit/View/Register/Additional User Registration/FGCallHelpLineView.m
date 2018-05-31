//
//  FGCallHelpLineView.m
//  Pureit
//
//  Created by PengLei on 16/4/13.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGCallHelpLineView.h"
#import "Global.h"


static CGFloat kTransitionDuration = 0.3;

@implementation FGCallHelpLineView

@synthesize vi_maskview;
@synthesize vi_contentview;
@synthesize iv_close;
@synthesize iv_phone_call;
@synthesize lb_notice;
@synthesize lb_call_helpline;
@synthesize btn_close;
@synthesize btn_call_helpline;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [commond useDefaultRatioToScaleView:vi_maskview];
    [commond useDefaultRatioToScaleView:vi_contentview];
    [commond useDefaultRatioToScaleView:iv_phone_call];
    
    [commond useDefaultRatioToScaleView:iv_close];
    [commond useDefaultRatioToScaleView:btn_call_helpline];
    [commond useDefaultRatioToScaleView:btn_close];
    [commond useDefaultRatioToScaleView:lb_call_helpline];
    [commond useDefaultRatioToScaleView:lb_notice];
    
    vi_contentview.backgroundColor =[UIColor whiteColor];
    vi_contentview.layer.cornerRadius = 10;
    vi_contentview.layer.masksToBounds = YES;
    
    lb_notice.font = font(FONT_NORMAL, 16);
    lb_call_helpline.font = font(FONT_BOLD, 16);
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


- (IBAction)action_buttonCallHelp:(id)sender {
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006307878"]]; //拨号
}

- (IBAction)action_buttonClose:(id)sender {
    
    [self removeFromSuperview];
}
@end
