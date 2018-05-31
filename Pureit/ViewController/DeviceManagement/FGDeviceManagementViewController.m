//
//  FGDeviceManagement.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDeviceManagementViewController.h"
#import "Global.h"
#define ANGLE_START -90
#define ANGLE_END 90

@interface FGDeviceManagementViewController ()
{
    
}
@end

@implementation FGDeviceManagementViewController
@synthesize iv_gkk1_indicator1;
@synthesize iv_gkk2_indicator2;
@synthesize iv_gkk1;
@synthesize iv_gkk2;
@synthesize iv_gkk1_alert;
@synthesize iv_gkk2_alert;
@synthesize lb_gkk1_value;
@synthesize lb_gkk2_value;
@synthesize lb_gkk1_key;
@synthesize lb_gkk2_key;
@synthesize btn_bookGkk;
@synthesize btn_bookGkk0;
@synthesize iv_barBg_level;
@synthesize iv_barBg_level1;
@synthesize iv_barBg_level3;
@synthesize iv_barIndicator;
@synthesize iv_barIndicator2;
@synthesize lb_levelTitle;
@synthesize iv_orderHistory;
@synthesize iv_complaints;
@synthesize iv_helloPureit;
@synthesize lb_orderHistory;
@synthesize lb_complaints;
@synthesize lb_helloPureits;
@synthesize btn_orderHistory;
@synthesize btn_complaints;
@synthesize btn_helloPureits;
@synthesize view_box_gkk1;
@synthesize view_box_gkk2;
@synthesize view_box_level;
@synthesize view_separatorLine1;
@synthesize view_separatorLine2;
@synthesize lb_level_score;
@synthesize lb_level_score2;
@synthesize lb_gkk1_tips;
@synthesize lb_gkk2_tips;
@synthesize btn_gkk1_showTips;
@synthesize btn_gkk2_showTips;
@synthesize lb_tds_tips;
@synthesize view_gkk1_container;
@synthesize view_gkk2_container;
@synthesize view_tds_container;
@synthesize btn_tds;

@synthesize iv_input_tds;
@synthesize iv_output_tds;
@synthesize lb_inupt_tds;
@synthesize lb_output_tds;

-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [[NetworkManager sharedManager] postRequest_getGKK:nil];
   
    btn_bookGkk0.tag = 1;
    btn_bookGkk.tag = 2;
    iv_gkk1_indicator1.layer.anchorPoint = CGPointMake(.5, .8);
    iv_gkk2_indicator2.layer.anchorPoint = CGPointMake(.5, .8);
    
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view_topPanel.str_title = multiLanguage(@"Manage Pureit");
    self.view_topPanel.lb_title.font = font(FONT_BOLD, 24);
    
    [commond useDefaultRatioToScaleView:iv_gkk1];
    [commond useDefaultRatioToScaleView:iv_gkk2];
    [commond useDefaultRatioToScaleView:iv_gkk1_alert];
    [commond useDefaultRatioToScaleView:iv_gkk2_alert];
    [commond useDefaultRatioToScaleView:lb_gkk1_key];
    [commond useDefaultRatioToScaleView:lb_gkk2_key];
    [commond useDefaultRatioToScaleView:lb_gkk1_value];
    [commond useDefaultRatioToScaleView:lb_gkk2_value];
    [commond useDefaultRatioToScaleView:btn_bookGkk];
    [commond useDefaultRatioToScaleView:btn_bookGkk0];
    [commond useDefaultRatioToScaleView:iv_barBg_level];
    [commond useDefaultRatioToScaleView:iv_barBg_level1];
    [commond useDefaultRatioToScaleView:iv_barBg_level3];
    [commond useDefaultRatioToScaleView:iv_barIndicator];
    
    [commond useDefaultRatioToScaleView:iv_barIndicator2];
    
    [commond useDefaultRatioToScaleView:lb_levelTitle];
    [commond useDefaultRatioToScaleView:iv_orderHistory];
    [commond useDefaultRatioToScaleView:iv_complaints];
    [commond useDefaultRatioToScaleView:iv_helloPureit];
    [commond useDefaultRatioToScaleView:lb_orderHistory];
    [commond useDefaultRatioToScaleView:lb_complaints];
    [commond useDefaultRatioToScaleView:lb_helloPureits];
    [commond useDefaultRatioToScaleView:btn_orderHistory];
    [commond useDefaultRatioToScaleView:btn_complaints];
    [commond useDefaultRatioToScaleView:btn_helloPureits];
    [commond useDefaultRatioToScaleView:view_box_level];
    [commond useDefaultRatioToScaleView:view_box_gkk1];
    [commond useDefaultRatioToScaleView:view_box_gkk2];
    [commond useDefaultRatioToScaleView:lb_gkk1_tips];
    [commond useDefaultRatioToScaleView:lb_gkk2_tips];
    [commond useDefaultRatioToScaleView:btn_gkk2_showTips];
    [commond useDefaultRatioToScaleView:btn_gkk1_showTips];
    
    [commond useDefaultRatioToScaleView:lb_level_score];
    [commond useDefaultRatioToScaleView:lb_level_score2];
    
    [commond useDefaultRatioToScaleView:view_separatorLine1];
    [commond useDefaultRatioToScaleView:view_separatorLine2];
    
    [commond useDefaultRatioToScaleView:lb_tds_tips];
    
    [commond useDefaultRatioToScaleView:view_tds_container];
    [commond useDefaultRatioToScaleView:view_gkk2_container];
    [commond useDefaultRatioToScaleView:view_gkk1_container];
    [commond useDefaultRatioToScaleView:btn_tds];
    
    //TODO::<peng> 2016_4_13 add new
    [commond useDefaultRatioToScaleView:iv_output_tds];
    [commond useDefaultRatioToScaleView:iv_input_tds];
    [commond useDefaultRatioToScaleView:lb_output_tds];
    [commond useDefaultRatioToScaleView:lb_inupt_tds];
    
    lb_inupt_tds.font = font(FONT_NORMAL, 8);
    lb_output_tds.font = font(FONT_NORMAL, 8);
    
    
    
    NSString *_str_imagefile;
    NSString *_str_imagefile2;
    float scale;
    if(H <= 568)
    {
        _str_imagefile2 = @"bartds_416";
        _str_imagefile = @"bartds1_416";  //图片宽度416 = imageView宽度208 * (1136 / 568)
        scale = 2;                          //scale = 实际像素 / 开发像素 (1136.0f / 568.0f) = 2
    }
    else if(H <= 667)
    {
        _str_imagefile2 = @"bartds_488";
        _str_imagefile = @"bartds1_488"; //图片宽度488 = imageView宽度208 * (1334 / 568)
        scale = 2;                        //scale = 实际像素 / 开发像素 (1334.0f / 667.0f) = 2
    }
    else if(H <= 736)
    {
        _str_imagefile2 = @"bartds_703";
        _str_imagefile = @"bartds1_703";//图片宽度703 = imageView宽度208 * (1920 / 568)
        scale = 1920.0f / 736.0f;       //scale = 实际像素 / 开发像素 (1920.0f / 736.0f) = 2.60869565
    }
    
    iv_barBg_level1.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_str_imagefile ofType:@"png"]] scale:scale];
    iv_barBg_level1.contentMode = UIViewContentModeTopLeft;
    
    
    iv_barBg_level3.image = [[UIImage alloc] initWithData:[NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:_str_imagefile2 ofType:@"png"]] scale:scale];
    iv_barBg_level3.contentMode = UIViewContentModeTopLeft;
    
    CGRect _frame = iv_gkk1_indicator1.frame;
    _frame.origin.y = 47;
    iv_gkk1_indicator1.frame = _frame;
    
    _frame = iv_gkk2_indicator2.frame;
    _frame.origin.y = 47;
    iv_gkk2_indicator2.frame = _frame;
    
    [commond useDefaultRatioToScaleView:iv_gkk1_indicator1];
    [commond useDefaultRatioToScaleView:iv_gkk2_indicator2];
    
    
    
    view_box_gkk1.backgroundColor = [UIColor clearColor];
    view_box_gkk2.backgroundColor = [UIColor clearColor];
    view_box_level.backgroundColor = [UIColor clearColor];
    
    view_box_gkk1.layer.cornerRadius = 5;
    view_box_gkk1.layer.masksToBounds = YES;
    view_box_gkk1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view_box_gkk1.layer.borderWidth = 1;
    
    view_box_gkk2.layer.cornerRadius = 5;
    view_box_gkk2.layer.masksToBounds = YES;
    view_box_gkk2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view_box_gkk2.layer.borderWidth = 1;
    
    view_box_level.layer.cornerRadius = 5;
    view_box_level.layer.masksToBounds = YES;
    view_box_level.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view_box_level.layer.borderWidth = 1;
    
    lb_gkk1_key.font = font(FONT_NORMAL, 16);
    lb_gkk1_value.font = font(FONT_NORMAL, 30);
    
    lb_gkk2_key.font = font(FONT_NORMAL, 16);
    lb_gkk2_value.font = font(FONT_NORMAL, 30);
    
    lb_levelTitle.font = font(FONT_NORMAL, 18);
    
    lb_orderHistory.font = font(FONT_NORMAL, 14);
    lb_complaints.font = font(FONT_NORMAL, 14);
    lb_helloPureits.font = font(FONT_NORMAL, 14);
    
    
    
    lb_level_score.font = font(FONT_BOLD, 12);
    lb_level_score2.font = font(FONT_BOLD, 12);
    
    btn_bookGkk0.titleLabel.font = font(FONT_BOLD, 18);
    btn_bookGkk.titleLabel.font = font(FONT_BOLD, 18);
    
    lb_gkk1_key.textColor = [UIColor lightGrayColor];
    lb_gkk2_key.textColor = [UIColor lightGrayColor];
    lb_gkk1_value.textColor = [UIColor darkGrayColor];
    lb_gkk2_value.textColor = [UIColor darkGrayColor];
    
    lb_levelTitle.textColor = [UIColor darkGrayColor];
    lb_orderHistory.textColor = [UIColor lightGrayColor];
    lb_complaints.textColor = [UIColor lightGrayColor];
    lb_helloPureits.textColor = [UIColor lightGrayColor];
    
    lb_gkk1_tips.font = font(FONT_BOLD, 20);
    lb_gkk2_tips.font = font(FONT_BOLD, 20);
    lb_tds_tips.font = font(FONT_BOLD, 20);
    
    [btn_bookGkk0 setTitle:multiLanguage(@"BOOK GKK NOW") forState:UIControlStateNormal];
    [btn_bookGkk0 setTitle:multiLanguage(@"BOOK GKK NOW") forState:UIControlStateHighlighted];
    [btn_bookGkk setTitle:multiLanguage(@"BOOK GKK NOW") forState:UIControlStateNormal];
    [btn_bookGkk setTitle:multiLanguage(@"BOOK GKK NOW") forState:UIControlStateHighlighted];
    
    lb_gkk1_key.text = multiLanguage(@"GKK1");
    lb_gkk2_key.text = multiLanguage(@"GKK2");
    
    
    lb_orderHistory.text = multiLanguage(@"My order history");
    lb_complaints.text = multiLanguage(@"Register a\ncomplaint");
    lb_helloPureits.text = multiLanguage(@"Call Pureit");
    
    iv_gkk1_alert.hidden = YES;
    iv_gkk2_alert.hidden = YES;
    
    btn_bookGkk.hidden = YES;
    btn_bookGkk0.hidden = YES;
    iv_gkk2_alert.hidden = YES;
    
    lb_gkk1_tips.alpha = 0;
    lb_gkk2_tips.alpha = 0;
    lb_tds_tips.alpha = 0;
    [lb_complaints setLineSpace:4 alignment:NSTextAlignmentCenter];
    [lb_orderHistory setLineSpace:4 alignment:NSTextAlignmentCenter];
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data = [dataManager getDataByUrl:HOST(URL_GetGKK)];
    CGFloat gkk1 = [[_dic_data objectForKey:@"GKK1"] floatValue];
    CGFloat gkk2 = [[_dic_data objectForKey:@"GKK2"] floatValue];
    CGFloat TDS = [[_dic_data objectForKey:@"TDS"] floatValue];
    CGFloat TDS_INPUT = TDS * 3.1578 + 305.92;
    CGFloat TDS_INPUT1 = TDS_INPUT-100;
    CGFloat TDS_INPUT2 = TDS_INPUT+100;
    
    CGFloat angle_gkk1 = ANGLE_END - ( ANGLE_END - ANGLE_START ) * ((float)(100 - gkk1) / 100.0f);
    CGFloat angle_gkk2 = ANGLE_END - ( ANGLE_END - ANGLE_START ) * ((float)(100 - gkk2) / 100.0f);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iv_gkk1_indicator1.transform = CGAffineTransformMakeRotation(RADIANS(angle_gkk1));
    iv_gkk2_indicator2.transform = CGAffineTransformMakeRotation(RADIANS(angle_gkk2));
    [UIView commitAnimations];
    
    lb_gkk1_value.text = [NSString stringWithFormat:@"%d%%\n%@",(int)gkk1,multiLanguage(@"remaining")];
    lb_gkk2_value.text = [NSString stringWithFormat:@"%d%%\n%@",(int)gkk2,multiLanguage(@"remaining")];
    
    
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lb_gkk1_value.text];
    NSRange range = [lb_gkk1_value.text rangeOfString:multiLanguage(@"remaining")];
    [attributedString addAttribute:NSFontAttributeName value:font(FONT_NORMAL, 12) range:range];
    lb_gkk1_value.attributedText = attributedString;
    attributedString = nil;
    
     attributedString = [[NSMutableAttributedString alloc] initWithString:lb_gkk2_value.text];
     range = [lb_gkk2_value.text rangeOfString:multiLanguage(@"remaining")];
    [attributedString addAttribute:NSFontAttributeName value:font(FONT_NORMAL, 12) range:range];
    lb_gkk2_value.attributedText = attributedString;
    attributedString = nil;
    
    
    
    lb_levelTitle.text = [NSString stringWithFormat:multiLanguage(@"YOUR TDS LEVEL %d PPM"),(int)TDS];
    lb_level_score.text = [NSString stringWithFormat:@"%d",(int)TDS];
    lb_level_score2.text = [NSString stringWithFormat:@"%d-%d",(int)TDS_INPUT1,(int)TDS_INPUT2];
    
    
    lb_tds_tips.text = multiLanguage(@"TDS levels above 500PPM is harmful for your health");
    [lb_tds_tips setLineSpace:12 alignment:NSTextAlignmentCenter];
    if(TDS >= 50 && TDS<=200)
    {
        iv_barIndicator.image = [UIImage imageNamed:@"bluebg.png"];//numberbg.png
        
        iv_barIndicator2.image = [UIImage imageNamed:@"redbg.png"];//numberbg.png
    }
    
    
//    [self calculateTDS:TDS];
    
    [self calculateTDS1:TDS_INPUT1 tds2:TDS_INPUT2 tds3:TDS];
    lb_gkk1_tips.text = multiLanguage(@"Your GKK1 is functioning well");
    lb_gkk2_tips.text = multiLanguage(@"Your GKK2 is functioning well");
    
    NSMutableDictionary *_dic_status1 = [_dic_data objectForKey:@"Status1"];
    NSMutableDictionary *_dic_status2 = [_dic_data objectForKey:@"Status2"];
    if([_dic_status1 count] > 0 )
    {
        int book = [[_dic_status1 objectForKey:@"Book"] intValue];
        if(book == 1||book==2)//TODO: fix it
        {
            iv_gkk1_alert.hidden = NO;
            btn_bookGkk0.hidden = NO;
            iv_gkk1_indicator1.image = [UIImage imageNamed:@"point_red.png"];
            lb_gkk1_tips.text = multiLanguage(@"Your GKK1 is low");
        }
        
    }
    
    if([_dic_status2 count] > 0)
    {
        int book = [[_dic_status2 objectForKey:@"Book"] intValue];
        if(book == 1||book==2)
        {
            iv_gkk2_alert.hidden = NO;
            iv_gkk2_indicator2.image = [UIImage imageNamed:@"point_red.png"];
            btn_bookGkk.hidden = NO;
            lb_gkk2_tips.text = multiLanguage(@"Your GKK2 is low");
        }
    }
    [lb_gkk1_tips setLineSpace:12 alignment:NSTextAlignmentCenter];
    [lb_gkk2_tips setLineSpace:12 alignment:NSTextAlignmentCenter];
}

-(void)calculateTDS:(CGFloat)_tds
{
    CGFloat TDSPADDING = 9.3 * ratioW;
    CGFloat startX = iv_barBg_level.frame.origin.x + TDSPADDING;//屏幕左边缘到图片0刻度的距离
    CGFloat TDS_startX;
    CGFloat width0_50 = 23 * ratioW;                //0-50的宽度
    CGFloat width50_200 = 37 * ratioW;              //50-200的宽度
    CGFloat width200_2000 = 128 * ratioW;           //200-2000的宽度
    
    CGFloat TDSMAXVALUE;
    CGFloat totalWidth;
    CGFloat _finalTDS;
    //因为图片的0-2000的刻度不是平均的 分为3段0-50 50-200 200-2000所以要判断TDS落在哪个区间里 然后分别处理 在区间内刻度是平均的
    if(_tds <= 50)
    {
        TDSMAXVALUE = 50;                               //50个刻度单位
        totalWidth = width0_50;
        TDS_startX = startX; //刻度0的x坐标
        _finalTDS = _tds;
    }
    else if(_tds <= 200)
    {
        TDSMAXVALUE = 200 - 50;                         //150个刻度单位
        totalWidth = width50_200;
        TDS_startX = startX + width0_50;//刻度50的x坐标
        _finalTDS = _tds - 50;
    }
    else
    {
        TDSMAXVALUE = 2000 - 200;                       //1800个刻度单位
        totalWidth = width200_2000;
        TDS_startX = startX + width50_200 + width0_50;//刻度200的x坐标
        _finalTDS = _tds - 200;
    }
    iv_barIndicator.center = CGPointMake(iv_barBg_level.frame.origin.x + iv_barBg_level.frame.size.width, iv_barIndicator.center.y);
    lb_level_score.center = CGPointMake(iv_barIndicator.center.x, lb_level_score.center.y);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
    iv_barIndicator.center = CGPointMake(TDS_startX + (_finalTDS / TDSMAXVALUE) * totalWidth, iv_barIndicator.center.y);
    lb_level_score.center = CGPointMake(iv_barIndicator.center.x, lb_level_score.center.y);
//    CGRect _frame = iv_barBg_level1.frame;
//    _frame.size.width = iv_barIndicator.center.x - iv_barBg_level.frame.origin.x;
//    iv_barBg_level1.frame = _frame;
//    iv_barBg_level1.clipsToBounds = YES;
//    [UIView commitAnimations];
    NSLog(@"scale = %f",iv_barBg_level1.image.scale);
    NSLog(@"[UIScreen mainScreen].scale = %f",[UIScreen mainScreen].scale);

}


-(void)calculateTDS1:(CGFloat)_tds tds2:(CGFloat)_tds2  tds3:(CGFloat)_tds3
{
    NSLog(@"testtestest");
//    CGFloat _tds = (_tds1 + _tds2)/2;
    CGFloat TDSPADDING = 9.3 * ratioW;
    CGFloat startX = iv_barBg_level.frame.origin.x + TDSPADDING;//屏幕左边缘到图片0刻度的距离
    CGFloat TDS_startX;
    CGFloat width0_50 = 23 * ratioW;                //0-50的宽度
    CGFloat width50_200 = 37 * ratioW;              //50-200的宽度
    CGFloat width200_2000 = 128 * ratioW;           //200-2000的宽度
    
    CGFloat TDSMAXVALUE;
    CGFloat totalWidth;
    CGFloat _finalTDS;
    CGFloat _finalTDS2;
    
    
    CGFloat TDSMAXVALUE3;
    CGFloat totalWidth3;
    CGFloat TDS_startX3;
    
    CGFloat _finalTDS3;
    //因为图片的0-2000的刻度不是平均的 分为3段0-50 50-200 200-2000所以要判断TDS落在哪个区间里 然后分别处理 在区间内刻度是平均的
    if(_tds <= 50)
    {
        TDSMAXVALUE = 50;                               //50个刻度单位
        totalWidth = width0_50;
        TDS_startX = startX; //刻度0的x坐标
        _finalTDS = _tds;
        _finalTDS2 = _tds2;
    }
    else if(_tds <= 200)
    {
        TDSMAXVALUE = 200 - 50;                         //150个刻度单位
        totalWidth = width50_200;
        TDS_startX = startX + width0_50;//刻度50的x坐标
        _finalTDS = _tds - 50;
        _finalTDS2 = _tds2 - 50;
      
    }
    else
    {
        TDSMAXVALUE = 2000 - 200;                       //1800个刻度单位
        totalWidth = width200_2000;
        TDS_startX = startX + width50_200 + width0_50;//刻度200的x坐标
        _finalTDS = _tds - 200;
        _finalTDS2 = _tds2 -200;
      
    }
    

    if(_tds3 <= 50)
    {
        TDSMAXVALUE3 = 50;                               //50个刻度单位
        totalWidth3 = width0_50;
        TDS_startX3 = startX; //刻度0的x坐标
      
        _finalTDS3 = _tds3;
    }
    else if(_tds3 <= 200)
    {
        TDSMAXVALUE3 = 200 - 50;                         //150个刻度单位
        totalWidth3 = width50_200;
        TDS_startX3 = startX + width0_50;//刻度50的x坐标

        _finalTDS3 = _tds3 - 50;
    }
    else
    {
        TDSMAXVALUE3 = 2000 - 200;                       //1800个刻度单位
        totalWidth3 = width200_2000;
        TDS_startX3 = startX + width50_200 + width0_50;//刻度200的x坐标

        _finalTDS3 = _tds3 -200;
    }
    
    //3
    iv_barIndicator.center = CGPointMake(iv_barBg_level.frame.origin.x + iv_barBg_level.frame.size.width, iv_barIndicator.center.y);
    lb_level_score.center = CGPointMake(iv_barIndicator.center.x, lb_level_score.center.y);
    
    iv_barIndicator2.center = CGPointMake(iv_barBg_level.frame.origin.x + iv_barBg_level.frame.size.width, iv_barIndicator2.center.y);
    lb_level_score2.center = CGPointMake(iv_barIndicator2.center.x, lb_level_score2.center.y);
   

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:2];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
//    iv_barIndicator2.center = CGPointMake(TDS_startX + (_finalTDS / TDSMAXVALUE) * totalWidth, iv_barIndicator2.center.y);
   
    //3
    iv_barIndicator.center = CGPointMake(TDS_startX3 + (_finalTDS3 / TDSMAXVALUE3) * totalWidth3, iv_barIndicator.center.y);
    lb_level_score.center = CGPointMake(iv_barIndicator.center.x, lb_level_score.center.y);
    
    
    iv_barIndicator2.center = CGPointMake(TDS_startX + ((_finalTDS+_finalTDS2)/2 / TDSMAXVALUE) * totalWidth, iv_barIndicator2.center.y);
    CGFloat startPoint = TDS_startX + (_finalTDS / TDSMAXVALUE) * totalWidth;
    CGFloat endXPoint = TDS_startX + (_finalTDS2 / TDSMAXVALUE) * totalWidth;
    
    lb_level_score2.center = CGPointMake(iv_barIndicator2.center.x, lb_level_score2.center.y);
    CGRect _frame = iv_barBg_level1.frame;
//    _frame.size.width = iv_barIndicator2.center.x - iv_barBg_level.frame.origin.x;
//    _frame.origin.x =  startPoint;//iv_barIndicator2.frame.origin.x;
    _frame.size.width = endXPoint - iv_barBg_level.frame.origin.x;//iv_barIndicator2.center.x;// - lb_level_score2.frame.origin.x;
    iv_barBg_level1.frame = _frame;
    iv_barBg_level1.clipsToBounds = YES;
//    [UIView commitAnimations];
    NSLog(@"scale = %f",iv_barBg_level1.image.scale);
    NSLog(@"[UIScreen mainScreen].scale = %f",[UIScreen mainScreen].scale);
    
    _frame = iv_barBg_level3.frame;
//    _frame.origin.x = iv_barBg_level.frame.origin.x;
    _frame.size.width = startPoint - iv_barBg_level.frame.origin.x;
    iv_barBg_level3.frame = _frame;
    iv_barBg_level3.clipsToBounds = YES;
    [UIView commitAnimations];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
}

-(void)buttonAction_back:(id)_sender;
{
    [appDelegate.slideViewController showRightViewController:YES];
    [nav_main popViewControllerAnimated:YES];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [self.view.layer removeAllAnimations];
    [lb_gkk1_tips.layer removeAllAnimations];
    [lb_gkk2_tips.layer removeAllAnimations];
    [lb_tds_tips.layer removeAllAnimations];
}

-(IBAction)buttonAction_bookGkk:(UIButton *)_sender
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data = [dataManager getDataByUrl:HOST(URL_GetGKK)];
    NSMutableDictionary *_dic_status1 = [_dic_data objectForKey:@"Status1"];
    NSMutableDictionary *_dic_status2 = [_dic_data objectForKey:@"Status2"];
    if([_dic_status1 count] > 0 )
    {
        int book = [[_dic_status1 objectForKey:@"Book"] intValue];
        if(book == 2)//TODO: fix it
        {
            [commond alert:multiLanguage(@"警告") message:multiLanguage(@"GKK has been booked") callback:nil];
            return;
        }
        
    }
    
    if([_dic_status2 count] > 0)
    {
        int book = [[_dic_status2 objectForKey:@"Book"] intValue];
        if(book == 2)
        {
            [commond alert:multiLanguage(@"警告") message:multiLanguage(@"GKK has been booked") callback:nil];
            return;
        }
    }

    NSInteger tag = _sender.tag;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    FGBookGkkViewController *vc_bookGkk = [[FGBookGkkViewController alloc] initWithNibName:@"FGBookGkkViewController" bundle:nil gkk:(int)tag];
    [manager pushController:vc_bookGkk navigationController:nav_main];
    
}

-(IBAction)buttonAction_orderHistory:(id)_sender;
{
    [[NetworkManager sharedManager] postRequest_orderHistory:nil]; //TODO: fix it
    
    
}

-(IBAction)buttonAction_complaints:(id)_sender;
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGSubmitComplaintsViewController" inNavigation:nav_main];
}

-(IBAction)buttonAction_helloPureits:(id)sender;
{
    NSArray * buttons = @[multiLanguage(@"YES"),multiLanguage(@"NO")];
    [commond alertWithButtons:buttons title:multiLanguage(@"警告") message:multiLanguage(@"Are you sure?") callback:^(FGCustomAlertView *alertView, NSInteger buttonIndex) {
        if(buttonIndex ==0)
        {
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://4006307878"]]; //拨号
        }
    }];
}

-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetGKK) isEqualToString:_str_url])
    {
        [self bindDataToUI];
    }
    if([HOST(URL_OrderHistory) isEqualToString:_str_url])
    {
        FGControllerManager *manager = [FGControllerManager sharedManager];
        [manager pushControllerByName:@"FGOrderHistroryViewController" inNavigation:nav_main];
    }
}

-(void)tipsFadeOut:(UILabel *)_lb_tips
{
    if(!_lb_tips)
        return;

    UIView *_containerView = nil;
    if([_lb_tips isEqual:lb_tds_tips])
        _containerView = view_tds_container;
    if([_lb_tips isEqual:lb_gkk1_tips])
        _containerView = view_gkk1_container;
    if([_lb_tips isEqual:lb_gkk2_tips])
        _containerView = view_gkk2_container;
   
    [UIView animateWithDuration:1 animations:^{
        _lb_tips.alpha = 0;
         _containerView.alpha = 1;
    }completion:^(BOOL finished){
    }];
}

-(void)tipsFadeIn:(UILabel *)_lb_tips hideView:(UIView *)_containerView
{
    if(!_lb_tips)
        return;
    
    [UIView animateWithDuration:1 animations:^{
        _lb_tips.alpha = 1;
        _containerView.alpha = 0;
    }completion:^(BOOL finished){
        if(finished)
        [self performSelector:@selector(tipsFadeOut:) withObject:_lb_tips afterDelay:5];
        
       
    }];
}

-(IBAction)buttonAction_gkk1ShowTips:(id)_sender;
{
    if(lb_gkk1_tips.alpha > 0)
    {
        //TODO::<peng> 2016_4_13 点击立即显示不用等待5s
        [self performSelector:@selector(tipsFadeOut:) withObject:lb_gkk1_tips afterDelay:0.1];
         return;
    }
    [self tipsFadeIn:lb_gkk1_tips hideView:view_gkk1_container];
}

-(IBAction)buttonAction_gkk2ShowTips:(id)_sender;
{
    if(lb_gkk2_tips.alpha > 0)
    {
        //TODO::<peng> 2016_4_13 点击立即显示不用等待5s
        [self performSelector:@selector(tipsFadeOut:) withObject:lb_gkk2_tips afterDelay:0.1];
        return;
    }

    [self tipsFadeIn:lb_gkk2_tips hideView:view_gkk2_container];
}

-(IBAction)buttonAction_showTDSTips:(id)_sender;
{
    if(lb_tds_tips.alpha > 0)
    {
        //TODO::<peng> 2016_4_13 点击立即显示不用等待5s
        [self performSelector:@selector(tipsFadeOut:) withObject:lb_tds_tips afterDelay:0.1];
        return;
    }
    [self tipsFadeIn:lb_tds_tips hideView:view_tds_container];
}

@end
