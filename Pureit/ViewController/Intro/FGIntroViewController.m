//
//  FGIntroViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGIntroViewController.h"
#import "Global.h"
#import "FGIntroView.h"

@interface FGIntroViewController ()
{
    
    NSTimer *timer_autoScroll;
    BOOL isPreviousSwiped;
    CGFloat lastOffsetX;
}
@end

@implementation FGIntroViewController
@synthesize cb_skip;
@synthesize sv;
@synthesize pc;
@synthesize iv_arr_left;
@synthesize iv_arr_right;
- (void)viewDidLoad {
    [super viewDidLoad];
    appDelegate.slideViewController.needSwipeShowMenu=NO;
    
    iv_arr_left.hidden = YES;
    /*去掉标题栏和状态栏*/
    
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    sv.frame = CGRectMake(0, 0, W, H);
    /*跳过按钮*/
    [cb_skip.button addTarget:self action:@selector(buttonAction_skip:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [commond useDefaultRatioToScaleView:cb_skip];
    [commond useDefaultRatioToScaleView:pc];
    [commond useDefaultRatioToScaleView:iv_arr_right];
    [commond useDefaultRatioToScaleView:iv_arr_left];
    
    [self internalInitalDatas];
    
    [self internalInitalIntros];
    
    timer_autoScroll = [NSTimer scheduledTimerWithTimeInterval:5 target:self selector:@selector(timer_nextPage) userInfo:nil repeats:YES];
}

-(void)timer_nextPage
{
    pc.currentPage = pc.currentPage < ([arr_titles count]-1)? pc.currentPage + 1 : ([arr_titles count]-1);
    
    if(pc.currentPage <= 2)
    {
     [sv scrollRectToVisible:CGRectMake(sv.frame.size.width * pc.currentPage, 0, sv.frame.size.width, sv.frame.size.height) animated:YES];
    }
}

-(void)internalInitalDatas
{
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;
    self.view_topPanel.iv_settings.hidden = YES;
    self.view_topPanel.btn_settings.hidden = YES;
    
    arr_titles = [[NSMutableArray alloc] initWithObjects:multiLanguage(@"LIVE THE SMART LIFE"),
                  multiLanguage(@"TRACK"),
                  //multiLanguage(@"COMPARE"),
                  multiLanguage(@"MANAGE"), nil];
    
    arr_descriptions = [[NSMutableArray alloc] initWithObjects:multiLanguage(@"Connect your device with\nthe Pureit app"),
                        multiLanguage(@"Track your daily Pureit\nwater consumption."),
                        //   multiLanguage(@"Compare with other Pureit\nfamilies across China."),
                        multiLanguage(@"Receive alerts for timely\nfilter change"),nil];
}

-(void)internalInitalIntros
{
    for(int i=0;i<[arr_titles count];i++)
    {
        FGIntroView *view_intro = (FGIntroView *)[[[NSBundle mainBundle] loadNibNamed:@"FGIntroView" owner:nil options:nil] objectAtIndex:0];
        view_intro.backgroundColor = [UIColor clearColor];
        view_intro.iv.image = [UIImage imageNamed:[NSString stringWithFormat:@"intro%d.png",i+1]];
        view_intro.lb_description.text = [arr_descriptions objectAtIndex:i];
        [view_intro.lb_description setLineSpace:7 * ratioH alignment:NSTextAlignmentCenter];
        [view_intro setupVSLTitle:[arr_titles objectAtIndex:i]];
        
        view_intro.frame = CGRectMake(i * sv.frame.size.width, 0, sv.frame.size.width, sv.frame.size.height);
        [sv addSubview:view_intro];
    }
    sv.contentSize = CGSizeMake(sv.frame.size.width * [arr_titles count], sv.frame.size.height);
    sv.showsHorizontalScrollIndicator = NO;
    sv.showsVerticalScrollIndicator = NO;
    sv.pagingEnabled = YES;
    sv.delegate = self;
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    self.iv_bg.hidden = YES;
    self.view_contentView.frame = CGRectMake(0, 0, W, H);
    
    CGRect _frame = cb_skip.frame;
    _frame = cb_skip.frame;
    _frame.origin.y = self.view.frame.size.height - cb_skip.frame.size.height - 20;
    cb_skip.frame = _frame;
    cb_skip.center = CGPointMake(self.view.frame.size.width / 2, cb_skip.center.y);
    [cb_skip setFrame:cb_skip.frame title:multiLanguage(@"跳过") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
}
#pragma mark - button action
-(void)buttonAction_skip:(id)_sender
{
    [self go2NextLogicWithAnimate:NO];
    
    if(timer_autoScroll)
    {
        [timer_autoScroll invalidate];
        timer_autoScroll = nil;
    }
    
}

-(void)go2NextLogicWithAnimate:(BOOL)_animate
{
    currentAppStatus = AppStatus_introReaded;
    [commond setUserDefaults:[NSNumber numberWithInt:currentAppStatus] forKey:KEY_APPSTATUS];
    
    NSString *className = @"FGHomeMenuViewController";//如果未注册过 进入注册页
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:className inNavigation:nav_main withAnimtae:NO];
    
    [manager.vc_homeMenu buttonAction_go2Setup:nil];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
    pc.currentPage =  scrollView.contentOffset.x / scrollView.frame.size.width;
    if(pc.currentPage == 0)
        iv_arr_left.hidden = YES;
    else
        iv_arr_left.hidden = NO;
    
    if(pc.currentPage == [arr_titles count]-1)
        iv_arr_right.hidden = YES;
    else
        iv_arr_right.hidden = NO;
    
    if(pc.currentPage == [arr_titles count]-1 || isPreviousSwiped)
    {
         [cb_skip setFrame:cb_skip.frame title:multiLanguage(@"GO") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    }
    else
    {
        [cb_skip setFrame:cb_skip.frame title:multiLanguage(@"跳过") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    }
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    lastOffsetX = scrollView.contentOffset.x;
}

-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    
    if(timer_autoScroll)
    {
        [timer_autoScroll invalidate];
        timer_autoScroll = nil;
    }
    
   if (scrollView.contentOffset.x < lastOffsetX )
    {
        isPreviousSwiped = YES;
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    cb_skip = nil;
    arr_descriptions = nil;
    arr_titles = nil;
    
}
@end
