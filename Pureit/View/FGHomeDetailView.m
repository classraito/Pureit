//
//  FGHomeDetailView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGHomeDetailView.h"
#import "Global.h"
#import "FGMyRankView.h"
#import "FGMyGraphView.h"
#import "FGDrawGraphBGView.h"
#import "FGDrawGraphChartView.h"
#import "FGViewWithSepratorLineView.h"
@interface FGHomeDetailView()
{
    NSMutableArray *arr_descriptions;
    AVPlayerLayer *playerLayer;
}
@end

@implementation FGHomeDetailView
@synthesize lb_description;
@synthesize lb_me;
@synthesize lb_china;
@synthesize view_line_me;
@synthesize view_line_china;
@synthesize view_myGraph;
@synthesize sv;
@synthesize upc;
@synthesize view_roundBoxBG;
@synthesize view_roundDot;
@synthesize lb_title;
@synthesize view_videoContent;
@synthesize vsl_title;
@synthesize btn_daily;
@synthesize btn_weekly;
@synthesize btn_monthly;
@synthesize btn_daily_big;
@synthesize btn_weekly_big;
@synthesize btn_monthly_big;
@synthesize iv_arrowDown;
@synthesize lb_Y_axis;
@synthesize lb_X_axis;
-(void)awakeFromNib
{
    [super awakeFromNib];
   
    
    self.backgroundColor = [UIColor clearColor];
    lb_description.font = font(FONT_NORMAL, 15);
    lb_title.font = font(FONT_NORMAL, 13);
    lb_title.textColor = [UIColor lightGrayColor];
   
    arr_descriptions = [[NSMutableArray alloc] initWithObjects:
                        multiLanguage(@"weather default text"),
                        //night
                        multiLanguage(@"Its late at night and you are still awake. Its time to grab a glass of water. By drinking water before bed, your hormones, energy levels and muscles become balanced. This helps you relax and feel rejuvenated in the morning."),
                        //rain
                        multiLanguage(@"Its a good day to carry your umbrella, also don’t forget your daily water intake. You need to keep hydrated even though the weather is wet. Water helps maintain the balance of body fluids."),
                        //<=10c
                        multiLanguage(@"Its cold outside right now, please dress warmly and don’t forget to drink a glass of water. Water helps hydrate your skin, removes dryness and keeps your skin looking good."),
                        //>=30c
                        multiLanguage(@"Today is a hot day and you’ve done well to keep yourself hydrated. Even mild dehydration can drain your energy and make you feel tired. Keep drinking water to be alert and to reduce fatigue."),nil];
    
    
   
    lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
    lb_me.text = multiLanguage(@"ME");
    lb_china.text = multiLanguage(@"CHINA");
    lb_title.text = multiLanguage(@"TDS 004PPM");
    
    lb_Y_axis.text = multiLanguage(@"Days");
    lb_X_axis.text = multiLanguage(@"Ltrs");
    
    [commond useDefaultRatioToScaleView:sv];
    [commond useDefaultRatioToScaleView:upc];
    [commond useDefaultRatioToScaleView:lb_description];
    [commond useDefaultRatioToScaleView:lb_me];
    [commond useDefaultRatioToScaleView:lb_china];
    [commond useDefaultRatioToScaleView:view_line_me];
    [commond useDefaultRatioToScaleView:view_line_china];
    [commond useDefaultRatioToScaleView:view_myGraph];
    [commond useDefaultRatioToScaleView:view_roundDot];
    [commond useDefaultRatioToScaleView:view_roundBoxBG];
    [commond useDefaultRatioToScaleView:lb_title];
    [commond useDefaultRatioToScaleView:vsl_title];
    [commond useDefaultRatioToScaleView:btn_monthly];
    [commond useDefaultRatioToScaleView:btn_daily];
    [commond useDefaultRatioToScaleView:btn_weekly];
    [commond useDefaultRatioToScaleView:btn_monthly_big];
    [commond useDefaultRatioToScaleView:btn_weekly_big];
    [commond useDefaultRatioToScaleView:btn_daily_big];
    [commond useDefaultRatioToScaleView:iv_arrowDown];
    
    [commond useDefaultRatioToScaleView:lb_Y_axis];
    [commond useDefaultRatioToScaleView:lb_X_axis];
    
    btn_daily.titleLabel.font = font(FONT_BOLD, 16);
    btn_weekly.titleLabel.font = font(FONT_BOLD, 16);
    btn_monthly.titleLabel.font = font(FONT_BOLD, 16);
    
    
    btn_daily.layer.cornerRadius = btn_daily.frame.size.width / 5.5;
    btn_daily.layer.masksToBounds = YES;
    
    btn_weekly.layer.cornerRadius = btn_weekly.frame.size.width / 5.5;
    btn_weekly.layer.masksToBounds = YES;
    
    btn_monthly.layer.cornerRadius = btn_monthly.frame.size.width / 6;
    btn_monthly.layer.masksToBounds = YES;
    
    [btn_daily setTitle:multiLanguage(@"按天") forState:UIControlStateNormal];
    [btn_weekly setTitle:multiLanguage(@"按周") forState:UIControlStateNormal];
    [btn_monthly setTitle:multiLanguage(@"按月") forState:UIControlStateNormal];
    
    UILabel *_lb_title = [[UILabel alloc] init];
    _lb_title.textAlignment = NSTextAlignmentCenter;
    _lb_title.textColor = [UIColor blackColor];
    _lb_title.backgroundColor = [UIColor clearColor];
    _lb_title.font = font(FONT_BOLD, 16);
    _lb_title.text = multiLanguage(@"我的用水量分析");
    [_lb_title sizeToFit];
    [vsl_title setupByMiddleView:_lb_title padding:15 lineHeight:1 lineColor:[UIColor blackColor]];
    
    
    view_roundBoxBG.backgroundColor = [UIColor clearColor];
  /*  view_roundBoxBG.layer.borderColor = [UIColor lightGrayColor].CGColor;
    view_roundBoxBG.layer.borderWidth = .5;
    view_roundBoxBG.layer.cornerRadius = 4;
    view_roundBoxBG.layer.masksToBounds = YES;*///圆角边框不要了
    
    view_roundDot.backgroundColor = rgb(49, 243, 46);
    view_roundDot.layer.borderColor = [UIColor clearColor].CGColor;
    view_roundDot.layer.cornerRadius = view_roundDot.frame.size.width / 2;
    view_roundDot.layer.masksToBounds = YES;
    
    [self performSelector:@selector(buttonAction_me:) withObject:nil afterDelay:.1];
    [self performSelector:@selector(buttonAction_china:) withObject:nil afterDelay:.1];
    
    
    sv.contentSize = CGSizeMake(sv.frame.size.width * 3, sv.frame.size.height);
    sv.pagingEnabled = YES;
    sv.scrollEnabled = NO;
    [lb_description setLineSpace:8 alignment:NSTextAlignmentCenter];
    
    NSMutableArray *arr_imgs = [NSMutableArray array];
    for(int i=0;i<22;i++)
    {
        UIImage *img = [UIImage imageNamed:[NSString stringWithFormat:@"arr%d.png",i+1 ]];
        [arr_imgs addObject:img];
        
    }
    iv_arrowDown.animationImages = arr_imgs;
    iv_arrowDown.animationDuration = 1;
    iv_arrowDown.animationRepeatCount = 0;
    [iv_arrowDown startAnimating];

    // [self internalInitalTitles]; //UI改变了
    
    /*[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(playerItemDidReachEnd:) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(pauseVideo)
                                                 name:UIApplicationWillResignActiveNotification object:nil];//监听是否触发home键挂起程序.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(playVideo)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];//监听是否重新进入程序程序.
    [self internalInitalVideoView];
    [self initVideo];*/ //视频不要了
    [FGLocationManagerWrapper sharedManager].delegate = self;
    
}

#pragma mark- FGLocationManagerWrapperDelegate
-(void)wrapperDidUpdateToLocationLat:(CLLocationDegrees)currentLatitude Lng:(CLLocationDegrees)currentLontitude city:(NSString *)_str_city
{
    NSLog(@"_str_city = %@",_str_city);
//    [self getRequest_getWeatherFromBaidu:_str_city];
    [self getRequest_getWeatherFromOpenWeatherOrg:currentLatitude lng:currentLontitude];
}

-(void)getRequest_getWeatherFromBaidu:(NSString *)_str_city
{
    NSString *str_url = [NSString stringWithFormat:@"%@?location=%@&output=json&ak=tWNMFeF2xtcQ4TYQu33HmAS1",URL_GetWeatherFromBaiduPrefix,_str_city];
    str_url = [str_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"str_url = %@",str_url);
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:str_url]];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:@"GET"];
    [request setValidatesSecureCertificate:NO];
    request.delegate = self;
    [request startAsynchronous];
}

-(void)getRequest_getWeatherFromOpenWeatherOrg:(CLLocationDegrees)_lat lng:(CLLocationDegrees)_lng
{
    NSString *str_url = [NSString stringWithFormat:URL_GetWeatherFromOpenWeatherOrg,_lat,_lng];
    str_url = [str_url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSLog(@"str_url = %@",str_url);
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:str_url]];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:@"GET"];
    [request setValidatesSecureCertificate:NO];
    request.delegate = self;
    [request startAsynchronous];
}


-(void)setupDescriptionCustomStyle:(NSString *)_str_matchedText color:(UIColor *)_color
{
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:lb_description.text];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = 2;//调整行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, lb_description.text.length)];
    NSRange range = [lb_description.text rangeOfString:_str_matchedText];
    [attributedString addAttribute:NSForegroundColorAttributeName value:_color range:range];
    [attributedString addAttribute:NSFontAttributeName value:font(FONT_BOLD, 16) range:range];
    lb_description.attributedText = attributedString;
    attributedString = nil;
    paragraphStyle = nil;

}



-(void)internalInitalVideoView
{
    if(view_videoContent)
        return;
    
    view_videoContent = [[UIView alloc] init];
    [view_myGraph addSubview:view_videoContent];
    [view_myGraph sendSubviewToBack:view_videoContent];
    CGRect _frame = view_videoContent.frame;
    _frame.origin.x = 0;
    _frame.size.width = W;
    _frame.size.height = W / DEFAULT_VIDEOWIDTH * DEFAULT_VIDEOHEIGHT;
    _frame.origin.y = view_myGraph.frame.size.height - _frame.size.height/2;
    view_videoContent.frame = _frame;
    view_videoContent.alpha = .0f;
}

-(void)initVideo
{
    
    NSString *str_filepath = [[NSBundle mainBundle] pathForResource:@"stock-footage-water-waves-fps" ofType:@"mp4"];
    AVURLAsset *videoasset = [AVURLAsset URLAssetWithURL:[NSURL fileURLWithPath:str_filepath] options:nil];
    AVPlayerItem *currentItem = [AVPlayerItem playerItemWithAsset:videoasset];
    
    AVPlayer *player = [[AVPlayer alloc]initWithPlayerItem:currentItem];
    player.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    playerLayer = [AVPlayerLayer playerLayerWithPlayer:player];
    playerLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    [view_videoContent.layer addSublayer:playerLayer];
    playerLayer.frame = view_videoContent.bounds;
    [self playVideo];
    
}

-(void)playVideo
{
    if(!playerLayer)
        return;
    [playerLayer.player play];
}

-(void)pauseVideo
{
    if(!playerLayer)
        return;
    [playerLayer.player pause];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)playerItemDidReachEnd:(NSNotification *)notification {
    if(playerLayer)
    {
        if(playerLayer.player.status == AVPlayerItemStatusReadyToPlay)
        {
            [playerLayer.player.currentItem seekToTime: kCMTimeZero
                                       toleranceBefore: kCMTimeZero
                                        toleranceAfter: kCMTimeZero
                                     completionHandler: ^(BOOL finished)
             {
                 if(finished)
                 {
                     [playerLayer.player play];
                 }
             }];
        }
        return ;
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_descriptions = nil;
    view_videoContent = nil;
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillResignActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidBecomeActiveNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
}

#pragma mark - buttonAction
-(IBAction)buttonAction_me:(id)_sender;
{
    
    view_myGraph.view_drawGraph_days.view_chart.isDrawMe =YES;
    view_myGraph.view_drawGraph_weeks.view_chart.isDrawMe = YES;
    view_myGraph.view_drawGraph_month.view_chart.isDrawMe = YES;
   
    [view_myGraph setNeedsDisplay];
}

-(IBAction)buttonAction_china:(id)_sender;
{
    
    view_myGraph.view_drawGraph_days.view_chart.isDrawChina = YES;
    view_myGraph.view_drawGraph_weeks.view_chart.isDrawChina = YES;
    view_myGraph.view_drawGraph_month.view_chart.isDrawChina = YES;
    
    [view_myGraph setNeedsDisplay];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;
{
   
    int currentPage = scrollView.contentOffset.x / scrollView.frame.size.width;
    upc.currentPage = currentPage;
    
    view_myGraph.sv.contentOffset =  scrollView.contentOffset;
    [view_myGraph scrollViewDidScroll:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView;
{
    [view_myGraph scrollViewDidEndScrollingAnimation:scrollView];
}

#define button_deepblue rgb(32, 42, 118)

-(IBAction)buttonAction_daily:(id)_sender;
{
    lb_Y_axis.text = multiLanguage(@"Days");
    btn_daily.backgroundColor = button_deepblue;
    btn_weekly.backgroundColor = [UIColor whiteColor];
    btn_monthly.backgroundColor  = [UIColor whiteColor];
    [btn_daily setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_weekly setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn_monthly setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [sv scrollRectToVisible:CGRectMake(0, 0, sv.frame.size.width, sv.frame.size.height) animated:YES];
}

-(IBAction)buttonAction_weekly:(id)_sender;
{
    lb_Y_axis.text = multiLanguage(@"Weeks");
    
    btn_daily.backgroundColor = [UIColor whiteColor];
    btn_weekly.backgroundColor = button_deepblue;
    btn_monthly.backgroundColor  = [UIColor whiteColor];
    [btn_daily setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn_weekly setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn_monthly setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    
    [sv scrollRectToVisible:CGRectMake(sv.frame.size.width , 0, sv.frame.size.width, sv.frame.size.height) animated:YES];
    
}

-(IBAction)buttonAction_monthly:(id)_sender;
{
    lb_Y_axis.text = multiLanguage(@"Months");
    
    btn_daily.backgroundColor = [UIColor whiteColor];
    btn_weekly.backgroundColor = [UIColor whiteColor];
    btn_monthly.backgroundColor  = button_deepblue;
    [btn_daily setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn_weekly setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    [btn_monthly setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [sv scrollRectToVisible:CGRectMake(sv.frame.size.width * 2 , 0, sv.frame.size.width, sv.frame.size.height) animated:YES];
}

#pragma mark - 此方法作废不掉用了
-(void)internalInitalTitles
{
    
    for(int i=0;i<3;i++)
    {
        UILabel *_lb_title = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, sv.frame.size.width, 0)];
        _lb_title.textAlignment = NSTextAlignmentCenter;
        _lb_title.textColor = [UIColor blackColor];
        _lb_title.backgroundColor = [UIColor clearColor];
        _lb_title.font = font(FONT_NORMAL, 16);
        _lb_title.text = multiLanguage(@"我的用水量分析");
        [_lb_title sizeToFit];
        [sv addSubview:_lb_title];
        
        UIView *view_separatorLine_left = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20 * ratioW, .5f)];
        view_separatorLine_left.backgroundColor = [UIColor blackColor];
        [sv addSubview:view_separatorLine_left];
        
        UIView *view_separatorLine_right = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 20 * ratioW, .5f)];
        view_separatorLine_right.backgroundColor = [UIColor blackColor];
        [sv addSubview:view_separatorLine_right];
        
        UILabel *lb_subtitle = [[UILabel alloc] initWithFrame:CGRectMake(i*sv.frame.size.width, 0, sv.frame.size.width, 0)];
        lb_subtitle.textAlignment = NSTextAlignmentCenter;
        lb_subtitle.textColor = [UIColor blackColor];
        lb_subtitle.backgroundColor = [UIColor clearColor];
        lb_subtitle.font = font(FONT_NORMAL, 16);
        NSString *str_day;
        if(i==0)
            str_day = multiLanguage(@"按天") ;
        else if(i==1)
            str_day = multiLanguage(@"按周") ;
        else if(i==2)
            str_day = multiLanguage(@"按月") ;
        lb_subtitle.text = str_day;
        [lb_subtitle sizeToFit];
        
        [sv addSubview:lb_subtitle];
        
        lb_subtitle.center = CGPointMake(sv.frame.size.width/2 + i * sv.frame.size.width, 0);
        _lb_title.center = CGPointMake(sv.frame.size.width/2 + i*sv.frame.size.width, 0);
        
        CGRect _frame = _lb_title.frame;
        _frame.origin.y = 120 * ratioH;
        _lb_title.frame = _frame;
        
        _frame = lb_subtitle.frame;
        _frame.origin.y = _lb_title.frame.origin.y + 2 + _lb_title.frame.size.height;
        lb_subtitle.frame = _frame;
        
        view_separatorLine_left.center = CGPointMake(0, _lb_title.center.y);
        view_separatorLine_right.center = CGPointMake(0, _lb_title.center.y);
        
        _frame = view_separatorLine_left.frame;
        _frame.origin.x = _lb_title.frame.origin.x - 10 * ratioW - view_separatorLine_left.frame.size.width;
        view_separatorLine_left.frame = _frame;
        
        _frame = view_separatorLine_right.frame;
        _frame.origin.x = _lb_title.frame.origin.x + _lb_title.frame.size.width + 10*ratioW;
        view_separatorLine_right.frame = _frame;
    }
}

-(void)do_readWeatherInfoFromBaidu:(NSMutableDictionary *)_dic_json
{
    if(!_dic_json )
        return;
    if([[_dic_json objectForKey:@"error"] intValue]!=0)
        return;
    
    NSMutableDictionary *_dic_singleData = nil;
    @try {
        NSMutableDictionary *_dic_result = [[_dic_json objectForKey:@"results"] objectAtIndex:0];
        NSMutableArray *_arr_datas = [_dic_result objectForKey:@"weather_data"];
        _dic_singleData = [_arr_datas objectAtIndex:0];
    }
    @catch (NSException *exception) {
        lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
    }
    
    //===========温度
    @try {
        
        NSString *str_date = [_dic_singleData objectForKey:@"date"];//周一 04月11日 (实时：16℃)
        str_date = [str_date substringFromIndex:[str_date rangeOfString:@"(实时："].location];//(实时：16℃)
        str_date = [str_date stringByReplacingOccurrencesOfString:@"(实时：" withString:@""];//16℃)
        str_date = [str_date stringByReplacingOccurrencesOfString:@"℃)" withString:@""];//16
        CGFloat temprature = [str_date floatValue];
        
        if(temprature >= 30)
        {
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_hot];
        }
        else if(temprature <= 10)
        {
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_cold];
        }
        else
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
        
    }
    @catch (NSException *exception) {
        lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
    }
    
    //=========是否下雨
    @try {
        
        BOOL isRanning = NO;
        NSString *str_weather = [_dic_singleData objectForKey:@"weather"];
        if([str_weather rangeOfString:@"雨"].location != NSNotFound)
        {
            isRanning = YES;
        }
        
        if(isRanning)
        {
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_rain];
        }
    }
    @catch (NSException *exception) {
        lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
    }
    
    
    //=========时间
    @try {
        
        NSString *_str_currentDate =  [commond stringFromDate:[NSDate date]];
        NSString *_str_HH = [_str_currentDate substringToIndex:[_str_currentDate rangeOfString:@":"].location];
        NSInteger HH = [_str_HH integerValue];
        if(HH>=19)
        {
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_night];
        }
    }
    @catch (NSException *exception) {
        lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
    }
    
    
    [lb_description setLineSpace:8 alignment:NSTextAlignmentCenter];
}

-(void)do_readWeatherInfoFromOpenWeatherOrg:(NSMutableDictionary *)_dic_json
{
    if(!_dic_json )
        return;
    if([[_dic_json objectForKey:@"cod"] intValue]!=200)
        return;

    @try {
        NSMutableDictionary *_dic_main = [_dic_json objectForKey:@"main"] ;
        
        NSString *_str_temp = [_dic_main objectForKey:@"temp"];
        float temprature = [_str_temp floatValue] - 273;
        NSLog(@"temprature = %f",temprature);
        //===========温度
        @try {
            
            if(temprature >= 30)
            {
                lb_description.text = [arr_descriptions objectAtIndex:WeatherType_hot];
            }
            else if(temprature <= 10)
            {
                lb_description.text = [arr_descriptions objectAtIndex:WeatherType_cold];
            }
            else
                lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
            
        }
        @catch (NSException *exception) {
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
        }

        
        //=========是否下雨
        if( [[_dic_main allKeys] containsObject:@"rain"] )
        {
            
            @try {
                lb_description.text = [arr_descriptions objectAtIndex:WeatherType_rain];
            }
            @catch (NSException *exception) {
                lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
            }
            
        }

        //=========时间
        @try {
            
            NSString *_str_currentDate =  [commond stringFromDate:[NSDate date]];
            NSString *_str_HH = [_str_currentDate substringToIndex:[_str_currentDate rangeOfString:@":"].location];
            NSInteger HH = [_str_HH integerValue];
            if(HH>=19)
            {
                lb_description.text = [arr_descriptions objectAtIndex:WeatherType_night];
            }
        }
        @catch (NSException *exception) {
            lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
        }
        
        
        [lb_description setLineSpace:8 alignment:NSTextAlignmentCenter];
        
    }
    @catch (NSException *exception) {
        lb_description.text = [arr_descriptions objectAtIndex:WeatherType_default];
    }

}

-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str_response = request.responseString;
    NSLog(@"str_response = %@",str_response);
    
    int responseCode = request.responseStatusCode;
    [commond removeLoading];
    if(responseCode != 200)
    {
        [commond removeLoading];
//        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"请检查您的网络!") callback:nil];
        return;//第一级检查返回码
    }
    NSString *_str_requestUrl = request.url.absoluteString;
    NSMutableDictionary *_dic_json = [str_response mutableObjectFromJSONString];
    NSLog(@":::::>response %@ %@ ",_str_requestUrl,_dic_json);
//    [self do_readWeatherInfoFromBaidu:_dic_json];
    [self do_readWeatherInfoFromOpenWeatherOrg:_dic_json];
}

/*处理连接错误*/
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"XXXXXXXXXXXXXX> response error:%@ url:%@",request.error,request.url);
    [commond removeLoading];
    [commond alert:multiLanguage(@"警告") message:multiLanguage(@"请检查您的网络!") callback:nil];
    
}
@end
