//
//  FGGraphTipsAlertView.m
//  Pureit
//
//  Created by Ryan Gong on 16/5/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGGraphTipsAlertView.h"
#import "Global.h"
static CGFloat kTransitionDuration = 0.3;

@interface FGGraphTipsAlertView()
{
    
}
@property (strong, nonatomic) void (^callBackBlock)(FGGraphTipsAlertView *alertView, NSInteger buttonIndex);
@end

@implementation FGGraphTipsAlertView
@synthesize view_alertBox;
@synthesize view_bg;
@synthesize iv_bg;
@synthesize iv_close;
@synthesize iv_checkBox;
@synthesize btn_close;
@synthesize btn_checkBox;
@synthesize lb_top;
@synthesize lb_bottom;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    lb_top.font = font(FONT_LIGHT, 15);
    lb_bottom.font = font(FONT_LIGHT, 15);
    
    [commond useDefaultRatioToScaleView:lb_bottom];
    [commond useDefaultRatioToScaleView:btn_checkBox];
    [commond useDefaultRatioToScaleView:btn_close];
    [commond useDefaultRatioToScaleView:view_bg];
    [commond useDefaultRatioToScaleView:view_alertBox];
    [commond useDefaultRatioToScaleView:iv_bg];
    [commond useDefaultRatioToScaleView:iv_checkBox];
    [commond useDefaultRatioToScaleView:iv_close];
  
    iv_checkBox.highlighted = NO;
    
}

-(void)setupWithTitle:(NSString*)title message:(NSString*)message andCallBack:(void (^)(FGGraphTipsAlertView *alertView, NSInteger buttonIndex))callBackBlock
{
    
    _callBackBlock  = callBackBlock;
    
    if(title)
    {
        lb_top.text = title;
        [lb_top setLineSpace:4 alignment:NSTextAlignmentCenter];
        [lb_top sizeToFit];
        
        [commond useDefaultRatioToScaleView:lb_top];
        lb_top.center = CGPointMake(W/2, lb_top.center.y);
    }
    
    if(message){
        lb_bottom.text = message;
        
    }
    
    [self layoutMyCustomUI];
    [self showPopup];
}

-(void)layoutMyCustomUI
{
    view_alertBox.center = CGPointMake(W/2, H/2);
    self.frame = CGRectMake(0, 0, W, H);
    
}


-(void)addToSuperview
{
    if ([appDelegate respondsToSelector:@selector(window)]) {
        UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
        [window addSubview:self];
    }
}

-(void)show
{
    [self addToSuperview];
    [self becomeFirstResponder];
}

-(void)showPopup
{
    view_alertBox.transform = CGAffineTransformScale([self transformForOrientation], 0.001, 0.001);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/1.5];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(bounce1AnimationStopped)];
    view_alertBox.transform = CGAffineTransformScale([self transformForOrientation], 1.1, 1.1);
    [UIView commitAnimations];
    
    [view_alertBox.layer removeAllAnimations];
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
    view_alertBox.transform = CGAffineTransformScale([self transformForOrientation], 0.9, 0.9);
    
    [UIView commitAnimations];
}

- (void)bounce2AnimationStopped {
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:kTransitionDuration/2];
    view_alertBox.transform = [self transformForOrientation];
    view_alertBox.transform = CGAffineTransformScale([self transformForOrientation], 1, 1);
    [UIView commitAnimations];
    
}

-(IBAction)buttonAction_checkBox:(UIButton *)_sender;
{
    NSInteger buttonIndex = _sender.tag - 1;
    if (_callBackBlock) {
        _callBackBlock(self, buttonIndex);
    }
    
    iv_checkBox.highlighted = iv_checkBox.highlighted ? NO : YES;
    
}

-(IBAction)buttonAction_close:(UIButton *)_sender;
{
    NSInteger buttonIndex = _sender.tag - 1;
    if (_callBackBlock) {
        _callBackBlock(self, buttonIndex);
    }
    [commond setUserDefaults:[NSNumber numberWithBool:iv_checkBox.highlighted] forKey:KEY_TIPS_STATUS];
    [self removeFromSuperview];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    _callBackBlock = nil;
}
@end
