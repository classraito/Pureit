//
//  FGHomeScreenView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//
int tipsShowCount;
int tipsShowCount1;
#import "FGHomeScreenView.h"
#import "Global.h"
@implementation FGHomeScreenView
@synthesize lb_key_today;
@synthesize view_separatorLine_today;
@synthesize lb_value_today;
@synthesize lb_key_average;
@synthesize view_separatorLine_average;
@synthesize lb_value_average;
@synthesize lb_tds;
@synthesize lb_tds_value_in;
@synthesize lb_tds_value_out;
@synthesize iv_arr_down;
@synthesize iv_arr_up;
@synthesize iv_arrowDown;
@synthesize btn_average;
@synthesize btn_today;
@synthesize lb_tips;
@synthesize lb_tips1;

-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    [commond useDefaultRatioToScaleView:lb_key_today];
    [commond useDefaultRatioToScaleView:view_separatorLine_today];
    [commond useDefaultRatioToScaleView:lb_value_today];
    [commond useDefaultRatioToScaleView:lb_key_average];
    [commond useDefaultRatioToScaleView:view_separatorLine_average];
    [commond useDefaultRatioToScaleView:lb_value_average];
    [commond useDefaultRatioToScaleView:lb_tds];
    [commond useDefaultRatioToScaleView:lb_tds_value_in];
    [commond useDefaultRatioToScaleView:lb_tds_value_out];
    [commond useDefaultRatioToScaleView:iv_arr_down];
    [commond useDefaultRatioToScaleView:iv_arr_up];
    [commond useDefaultRatioToScaleView:iv_arrowDown];
    [commond useDefaultRatioToScaleView:btn_today];
    [commond useDefaultRatioToScaleView:btn_average];
    [commond useDefaultRatioToScaleView:lb_tips];
    [commond useDefaultRatioToScaleView:lb_tips1];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidToBackground)
                                                 name:UIApplicationWillResignActiveNotification object:nil];//监听是否触发home键挂起程序.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];//监听是否重新进入程序程序.
   
    
    lb_tips.font = font(FONT_NORMAL, 16);
    lb_tips.alpha = 0;
    
    lb_tips1.font = font(FONT_NORMAL, 16);
    lb_tips1.alpha = 0;
    
    lb_key_today.font = font(FONT_NORMAL, 17);
    lb_key_average.font = font(FONT_NORMAL, 14);
    lb_value_average.font = font(FONT_ULTRALIGHT, 25);
    if(H<=480)
        lb_value_today.font = font(FONT_ULTRALIGHT, 60);
    else
        lb_value_today.font = font(FONT_ULTRALIGHT, 70);
    
    lb_key_today.text = multiLanguage(@"您的\n家庭今天的用水量") ;
    [lb_key_today setLineSpace:3 alignment:NSTextAlignmentCenter];
    lb_key_average.text = multiLanguage(@"国内平均数据") ;
    
    [self bindDataToUI];
    
//    [self arrowFadeOut];
    
    
    NSMutableArray *arr_imgs = [NSMutableArray array];
    for(int i=0;i<22;i++)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"u_arr%d.png",i+1 ]];
        [arr_imgs addObject:img];
        
    }
    iv_arrowDown.animationImages = arr_imgs;
    iv_arrowDown.animationDuration = 1;
    iv_arrowDown.animationRepeatCount = 0;
    [iv_arrowDown startAnimating];
    
}

-(void)appDidToBackground
{
    [iv_arrowDown.layer removeAllAnimations];
    [lb_tips.layer removeAllAnimations];
    [lb_tips1.layer removeAllAnimations];
}

-(void)appDidActive
{
    lb_tips.alpha = 0;
    lb_tips1.alpha = 0;
    tipsShowCount = 0;
    tipsShowCount1=0;
    [self showData1];
    [self showData2];
    [iv_arrowDown startAnimating];
}

-(void)hideData1
{
    lb_key_today.alpha = 0;
    lb_value_today.alpha = 0;
    view_separatorLine_today.alpha = 0;
//    btn_today.hidden = YES;
}

-(void)hideData2
{
    lb_key_average.alpha = 0;
    lb_value_average.alpha = 0;
    view_separatorLine_average.alpha = 0;
//    btn_average.hidden = YES;
}

-(void)showData1
{
    lb_key_today.alpha = 1;
    lb_value_today.alpha = 1;
    view_separatorLine_today.alpha = 1;
//    btn_today.hidden = NO;
//    isStop_trip = NO;
}

-(void)showData2
{
    lb_key_average.alpha = 1;
    lb_value_average.alpha = 1;
    view_separatorLine_average.alpha =1;
//    btn_average.hidden = NO;
//    isStop_trip1 = NO;
}

-(void)arrowFadeOut
{
    if(!iv_arrowDown)
        return;
    
    [UIView animateWithDuration:1 animations:^{
        iv_arrowDown.alpha = .2;
    }completion:^(BOOL finished){
        if(finished)
        [self arrowFadeIn];
    }];
}

-(void)arrowFadeIn
{
    if(!iv_arrowDown)
        return;
    
    [UIView animateWithDuration:1 animations:^{
        iv_arrowDown.alpha = 1;
    }completion:^(BOOL finished){
        if(finished)
        [self arrowFadeOut];
    }];
}

-(void)tipsFadeOut
{
    if(!lb_tips)
        return;
    
    if(tipsShowCount >3)
    {
        tipsShowCount = 0;
        [UIView beginAnimations:nil context:nil];
        lb_tips.alpha = 0;
        [self showData1];
        [UIView commitAnimations];
        return;
    }
    
    
    [UIView animateWithDuration:1 animations:^{
        
        if (!isStop_trip) {
            lb_tips.alpha = .5;
        }
    }completion:^(BOOL finished){
        if(finished)
        {
            if (isStop_trip) {
                lb_tips.alpha = 0;
                return ;
            }
            [self tipsFadeIn];
            tipsShowCount ++;
        }
        
    }];
}

-(void)tipsFadeIn
{
    if(!lb_tips || isStop_trip)
    {
        return;
    }
    [UIView animateWithDuration:1 animations:^{
        lb_tips.alpha = 1;
        [self hideData1];
    }completion:^(BOOL finished){
        if(finished)
        [self tipsFadeOut];
    }];
}

-(void)tips1FadeOut
{
    if(!lb_tips1)
        return;
    
    if(tipsShowCount1 >3)
    {
        tipsShowCount1 = 0;
        [UIView beginAnimations:nil context:nil];
        lb_tips1.alpha = 0;
        [self showData2];
        [UIView commitAnimations];
        return;
    }
    
    
    [UIView animateWithDuration:1 animations:^{
        
        if (!isStop_trip1) {
            lb_tips1.alpha = .5;
        }
        
    }completion:^(BOOL finished){
        if(finished)
        {
            if (isStop_trip1) {
                lb_tips1.alpha = 0;
                return;
            }
            [self tips1FadeIn];
            tipsShowCount1 ++;
        }
    }];
}

-(void)tips1FadeIn
{
    if(!lb_tips1 || isStop_trip1)
    {
        return;
    }
    
    [UIView animateWithDuration:1 animations:^{
        lb_tips1.alpha = 1;
        [self hideData2];
    }completion:^(BOOL finished){
        if(finished)
        [self tips1FadeOut];
    }];
}

-(void)bindDataToUI
{
    DataManager *datamanager = [DataManager sharedManager];
    NSMutableDictionary *dic_info = [datamanager getDataByUrl:HOST(URL_GetRefreshData)];
    NSNumber *num_family = [dic_info objectForKey:@"Family"] ;
    NSNumber *num_china = [dic_info objectForKey:@"China"] ;
    
    //TODO::<peng> 2016_4_14 处理显示数据保留一位小数
    NSString * str_valueToday = [NSString stringWithFormat:@"%.1f L",[num_family floatValue]];
    NSString * str_valueAverage = [NSString stringWithFormat:@"%.1f L",[num_china floatValue]];
    
    lb_value_today.text = str_valueToday;//[NSString stringWithFormat:@"%@ L",num_family];
    lb_value_average.text = str_valueAverage;// [NSString stringWithFormat:@"%@ L",num_china];
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lb_value_today.text];
    NSRange range = [lb_value_today.text rangeOfString:@"L"];
    [attributedString addAttribute:NSFontAttributeName value:font(FONT_ULTRALIGHT, 30) range:range];
    lb_value_today.attributedText = attributedString;
    attributedString = nil;
    
    attributedString = [[NSMutableAttributedString alloc] initWithString:lb_value_average.text];
    range = [lb_value_average.text rangeOfString:@"L"];
    [attributedString addAttribute:NSFontAttributeName value:font(FONT_LIGHT, 12) range:range];
    lb_value_average.attributedText = attributedString;
    attributedString = nil;

}


-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(IBAction)buttonAction_today:(id)_sender;
{
    if(lb_tips.alpha !=0)//TODO::<peng> 2016_4_14 取消动画
    {
        isStop_trip = YES;
        tipsShowCount = 4;
        [self performSelector:@selector(tipsFadeOut) withObject:nil afterDelay:0.2];
        return;
    }
    lb_tips.text = [NSString stringWithFormat:multiLanguage(@"Today, you have consumed %@,\nmeasured from 12:00 AM until now."),lb_value_today.text];
    tipsShowCount = 0;
    [lb_tips setLineSpace:4 alignment:NSTextAlignmentCenter];
  
    isStop_trip = NO;
    if(lb_tips.alpha==0)
        [self tipsFadeIn];
}

-(IBAction)buttonAction_average:(id)_sender;
{
    if(lb_tips1.alpha !=0)//TODO::<peng> 2016_4_14 取消动画
    {
        isStop_trip1 = YES;
        tipsShowCount1 = 4;
        [self performSelector:@selector(tips1FadeOut) withObject:nil afterDelay:0.2];
        return;
    }
    lb_tips1.text = [NSString stringWithFormat:multiLanguage(@"Today, the average consumption of Chinese users\n is %@, measured from 12:00 AM until now."),lb_value_average.text];
    tipsShowCount1 = 0;
    [lb_tips1 setLineSpace:4 alignment:NSTextAlignmentCenter];
  
    isStop_trip1 = NO;
    if(lb_tips1.alpha==0)
        [self tips1FadeIn];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [self.layer removeAllAnimations];
    [iv_arrowDown.layer removeAllAnimations];
    [lb_tips.layer removeAllAnimations];
    [lb_tips1.layer removeAllAnimations];
}
@end
