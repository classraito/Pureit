//
//  FGRegisterViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomeMenuViewController.h"
#import "Global.h"

@interface FGHomeMenuViewController()
{
    UserInfoBy userinfoby;
}
@end

@implementation FGHomeMenuViewController
@synthesize cb_setup;
@synthesize lb_title;
//@synthesize cb_signIn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    //self.view_topPanel.str_title = multiLanguage(@"开始吧");
    [self.view_topPanel.btn_back removeFromSuperview];
    [self.view_topPanel.iv_back removeFromSuperview];
    self.view_topPanel.btn_back = nil;
    self.view_topPanel.iv_back=nil;
    self.iv_bg.image = [UIImage imageNamed:@"splash.jpg"];
   [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    self.view_topPanel.lb_title.font = font(FONT_BOLD, 28);
    CGRect _frame = self.view_topPanel.lb_title.frame;
    _frame.size.width = W;
    self.view_topPanel.lb_title.frame = _frame;
    
   appDelegate.slideViewController.needSwipeShowMenu=NO;
    self.view_topPanel.iv_settings.hidden = YES;
    self.view_topPanel.btn_settings.hidden = YES;
    
    //[commond useDefaultRatioToScaleView:cb_signIn];
    [commond useDefaultRatioToScaleView:cb_setup];
    [commond useDefaultRatioToScaleView:lb_title];
    
    lb_title.font = font(FONT_BOLD, 25);
    lb_title.text = multiLanguage(@"开始吧");
    
    
    //[cb_signIn.button addTarget:self action:@selector(buttonAction_go2Login:) forControlEvents:UIControlEventTouchUpInside];
    [cb_setup.button addTarget:self action:@selector(buttonAction_go2Setup:) forControlEvents:UIControlEventTouchUpInside];
    
    //cb_signIn.hidden = YES;
}


-(void)manullyFixSize
{
    [super manullyFixSize];
    //[cb_signIn setFrame:cb_signIn.frame title:multiLanguage(@"登陆") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    [cb_setup setFrame:cb_setup.frame title:multiLanguage(@"配置你的Pureit") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    
}

#pragma mark - buttonAction
-(void)buttonAction_go2Login:(id)_sender
{
    [commond removeAllAlertViewInWindow];
}

-(void)buttonAction_go2Setup:(id)_sender
{
    [commond removeAllAlertViewInWindow];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGRegisterStepViewController" inNavigation:nav_main withAnimtae:NO];
}

-(void)dealloc 
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}



#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    /*if([HOST(URL_Login) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"UserInfoBy"])
        {
            userinfoby = [[_dic_requestInfo objectForKey:@"UserInfoBy"] intValue];
            
            NSMutableDictionary *_dic_requestInfo = [NSMutableDictionary dictionary];
            [_dic_requestInfo setObject:@"CheckUserInfo" forKey:@"GetUserInfo"];
            [[NetworkManager sharedManager] postRequest_getUserInfo:_dic_requestInfo];//从微博或微信登录成功后 请求用户信息
        }
    }*/
}


@end
