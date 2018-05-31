//
//  FGAgreementViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/4.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGAgreementViewController.h"
#import "Global.h"

@interface FGAgreementViewController ()
{
    CGRect originalFrame_iv_logo;
    CGRect originalFrame_lb_agree;
    CGRect originalFrame_view_agreement;
    CGRect originalFrame_btn_agree;
    CGRect originalFrame_view_bottomBg;
    CGRect originalFrame_cb_next;
    CGRect originalFrame_iv_agreeBox;
    
    CGRect originalFrame_lb_top_title;
    
    BOOL isAgree;
}
@end

@implementation FGAgreementViewController
@synthesize iv_logo;
@synthesize lb_agree;
@synthesize view_agreement;
@synthesize btn_agree;
@synthesize view_bottomBg;
@synthesize cb_next;
@synthesize iv_agreeBox;
@synthesize iv_back;
@synthesize btn_back;
@synthesize is_agreementView_noneedlogo;
@synthesize lb_top_title;


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil needdelete_logo:(BOOL)needdelete_logo
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if(self)
    {
        //TODO::<peng> 2016_4_14 设置界面进入协议 不需要logo
        is_agreementView_noneedlogo = needdelete_logo;
        
    }
    return self;
}

-(void)viewDidLoad {
    [super viewDidLoad];
    self.view_topPanel.iv_settings.hidden = YES;
    self.view_topPanel.btn_settings.hidden = YES;
    // Do any additional setup after loading the view from its nib.
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;

    
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    [self setOriginalFrame];
    self.view.backgroundColor = [UIColor whiteColor];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    lb_agree.font = font(FONT_NORMAL,13);
    lb_agree.text = multiLanguage(@"我接受的条款和条件");
    [cb_next.button addTarget:self action:@selector(buttonAction_next:) forControlEvents:UIControlEventTouchUpInside];
    btn_back.hidden = YES;
    iv_back.hidden = YES;
    
    lb_top_title.hidden = YES;
    lb_top_title.font = font(FONT_BOLD, 25);
    lb_top_title.textColor = deepblue;
    lb_top_title.text = multiLanguage(@"Terms and Conditions");

    if (is_agreementView_noneedlogo) {
        [view_agreement setIs_needdelete_logo:YES];
    }
    else
    {
        [view_agreement setIs_needdelete_logo:NO];
    }

}

-(void)setOriginalFrame
{
    originalFrame_btn_agree = btn_agree.frame;
    originalFrame_cb_next = cb_next.frame;
    originalFrame_iv_logo = iv_logo.frame;
    originalFrame_lb_agree = lb_agree.frame;
    originalFrame_view_agreement = view_agreement.frame;
    originalFrame_view_bottomBg = view_bottomBg.frame;
    originalFrame_iv_agreeBox = iv_agreeBox.frame;
    
    originalFrame_lb_top_title = lb_top_title.frame;
}

-(void)prepareForSettingMenu
{
    
    lb_top_title.hidden = NO;
    
    [self manullyFixSize];
    self.iv_agreeBox.hidden = YES;
    self.btn_agree.hidden = YES;
    self.lb_agree.hidden = YES;
    self.iv_logo.hidden = YES;
    iv_back.hidden = NO;
    btn_back.hidden = NO;
    view_bottomBg.hidden = YES;
    originalFrame_view_bottomBg = view_bottomBg.frame;
    originalFrame_view_bottomBg.size.height = self.cb_next.frame.size.height + 5 * 2;
    originalFrame_view_bottomBg.origin.y = 568 - originalFrame_view_bottomBg.size.height;
    
    
    
     view_bottomBg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_bottomBg];
    [self.cb_next.button removeTarget:self action:@selector(buttonAction_agree:) forControlEvents:UIControlEventTouchUpInside];
    [self.cb_next.button addTarget:self action:@selector(buttonAction_close:) forControlEvents:UIControlEventTouchUpInside];
    [btn_back addTarget:self action:@selector(buttonAction_close:) forControlEvents:UIControlEventTouchUpInside];
   
}

-(void)buttonAction_close:(id)_sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    btn_agree.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_agree];
    cb_next.frame = [commond useDefaultRatioToScaleFrame:originalFrame_cb_next];
    iv_logo.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_logo];
    lb_agree.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_agree];
    view_agreement.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_agreement];
    
    view_bottomBg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_bottomBg];
    iv_agreeBox.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_agreeBox];
    
    lb_top_title.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_top_title];
    
    [cb_next setFrame:cb_next.frame title:multiLanguage(@"下一步") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:10 font:nil needTitleLeftAligment:NO needIconBesideLabel:NO];
    view_agreement.view_content.backgroundColor = [UIColor clearColor];
    if(self.iv_agreeBox.hidden)
    {
        self.cb_next.center = CGPointMake(self.cb_next.center.x, view_bottomBg.frame.size.height / 2);
        [self.cb_next setFrame:self.cb_next.frame title:multiLanguage(@"BACK") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:nil borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue padding:10 font:nil needTitleLeftAligment:NO needIconBesideLabel:NO];
    }
    
    CGRect _frame = view_agreement.frame;
    _frame.origin.y = 10;
    _frame.size.height = H - view_bottomBg.frame.size.height - 10;
    view_agreement.frame = _frame;
    
    if(!iv_back.hidden && !btn_back.hidden){
        CGRect _frame = view_agreement.frame;
        _frame.origin.y = btn_back.frame.origin.y + btn_back.frame.size.height;
        _frame.size.height = H - _frame.origin.y;
        view_agreement.frame = _frame;
    }
    view_agreement.tv_agreement.scrollsToTop = YES;
    [view_agreement.tv_agreement scrollRectToVisible:CGRectMake(0, 0, view_agreement.tv_agreement.frame.size.width, view_agreement.tv_agreement.frame.size.height) animated:NO];
}

-(IBAction)buttonAction_agree:(id)_sender
{
    isAgree = isAgree ? NO : YES;
    [self changeAgreeBox];

}

-(void)changeAgreeBox
{
    if(isAgree)
    {
        iv_agreeBox.highlighted = YES;
    }
    else
    {
        iv_agreeBox.highlighted = NO;
    }
}

-(void)buttonAction_next:(id)_sender
{
    if(!isAgree)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"您还没有勾选同意条款") callback:nil];
        return;
    }
    
    NSString *className = @"FGIntroViewController";//如果未注册过 进入注册页
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager initNavigation:&nav_main rootControllerName:className];//进入intro页
    [appDelegate initalSlideViewControllerWithRoot:nav_main];

    currentAppStatus = AppStatus_agreementReaded;
    [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
