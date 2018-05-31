//
//  FGMyRankView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/6.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGMyRankView.h"
#import "Global.h"


#define ANGLE_START 240
#define ANGLE_END -60

@interface FGMyRankView()
{
    NSTimer *timer;
    CGFloat curPercent;
    ADTickerLabel *tickerLabel;
    UILabel *lb_percent;
    CGFloat radius;
    
    NSMutableArray *arr_points_inner;
    NSMutableArray *arr_points_middle;
    NSMutableArray *arr_points_outter;
    CGFloat dy;
    BOOL isEqualLineLength;
    
    CGFloat MAX_DIVISION;
    
}
@end

@implementation FGMyRankView
@synthesize view_score;
@synthesize lb_title;
@synthesize lb_subtitle;
@synthesize iv_thumbnail;
@synthesize percent;
@synthesize LINE_LENGTH;
@synthesize lb_rankDescription;
@synthesize lb_rankTitle;
@synthesize btn;
@synthesize lb_tips;
@synthesize pageIndex;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidToBackground)
                                                 name:UIApplicationWillResignActiveNotification object:nil];//监听是否触发home键挂起程序.
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appDidActive)
                                                 name:UIApplicationDidBecomeActiveNotification object:nil];//监听是否重新进入程序程序.
    
    [commond useDefaultRatioToScaleView:view_score];
    [commond useDefaultRatioToScaleView:lb_title];
    [commond useDefaultRatioToScaleView:lb_subtitle];
    [commond useDefaultRatioToScaleView:iv_thumbnail];
    [commond useDefaultRatioToScaleView:lb_rankDescription];
    [commond useDefaultRatioToScaleView:lb_rankTitle];
    [commond useDefaultRatioToScaleView:btn];
    [commond useDefaultRatioToScaleView:lb_tips];
    [self internalInitalScore];
    self.backgroundColor = [UIColor clearColor];
    view_score.backgroundColor = [UIColor clearColor];
    
    lb_title.font = font(FONT_LIGHT, 17);
    lb_subtitle.font = font(FONT_LIGHT, 16);
    lb_rankDescription.font = font(FONT_NORMAL, 18);
    lb_rankTitle.font = font(FONT_NORMAL, 20);
    lb_tips.font = font(FONT_LIGHT, 14);
    lb_tips.text = multiLanguage(@"Tap to see more");
   
    lb_rankDescription.textColor = [UIColor lightGrayColor];
    lb_rankTitle.textColor = [UIColor darkGrayColor];
    lb_title.textColor = [UIColor lightGrayColor];
    
    
    arr_points_inner = [[NSMutableArray alloc] init];
    arr_points_middle = [[NSMutableArray alloc] init];
    arr_points_outter = [[NSMutableArray alloc] init];
    
    lb_title.text = multiLanguage(@"HYDRATION SCORE");
    lb_rankDescription.hidden = YES;
    lb_rankTitle.hidden = YES;
    
    
    if(H<=480)
    {
        CGRect _frame = lb_tips.frame;
        _frame.origin.y += 15;
        lb_tips.frame = _frame;
    }
    
    [lb_title setLineSpace:4 alignment:NSTextAlignmentCenter];
    
}

-(void)appDidToBackground
{
   [lb_tips.layer removeAllAnimations];
}

-(void)appDidActive
{
    [self tipsFadeOut];
}

-(IBAction)buttonAction_switch:(id)_sender
{
    lb_rankDescription.hidden = lb_rankDescription.hidden ? NO : YES;
    lb_rankTitle.hidden = lb_rankTitle.hidden ? NO : YES;
    lb_title.hidden = lb_title.hidden ? NO : YES;
    lb_subtitle.hidden = lb_subtitle.hidden ? NO : YES;
    view_score.hidden = view_score.hidden ? NO : YES;
    tickerLabel.hidden = tickerLabel.hidden ? NO : YES;
    lb_percent.hidden = lb_percent.hidden ? NO : YES;
    lb_tips.hidden = lb_tips.hidden?NO:YES;
}

-(void)tipsFadeOut
{
    if(!lb_tips)
        return;
    lb_tips.alpha = 1;
    [UIView animateWithDuration:1 animations:^{
        lb_tips.alpha = .2;
    }completion:^(BOOL finished){
        if(finished)
            [self tipsFadeIn];
    }];
}

-(void)tipsFadeIn
{
    if(!lb_tips)
        return;
    [UIView animateWithDuration:1 animations:^{
        lb_tips.alpha = 1;
    }completion:^(BOOL finished){
        if(finished)
            [self tipsFadeOut];
    }];
}

-(void)internalInitalDivisionPoints
{
    if([arr_points_outter count]>0)
        return;
    
    radius = self.frame.size.width / 2;
    CGPoint centerPoint = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGFloat totalAngle = ANGLE_END - ANGLE_START;
    CGFloat cellAngle = totalAngle / MAX_DIVISION;
    for(int i=0;i<MAX_DIVISION;i++)
    {
        CGFloat angle = cellAngle * i + ANGLE_START;
        CGPoint point_inner = [self calcCircleCoordinateWithCenter:centerPoint andWithAngle:angle andWithRadius:radius - LINE_LENGTH];
        CGPoint point_middle = [self calcCircleCoordinateWithCenter:centerPoint andWithAngle:angle andWithRadius:radius - LINE_LENGTH / 3 ];
        CGPoint point_outter = [self calcCircleCoordinateWithCenter:centerPoint andWithAngle:angle andWithRadius:radius];
        [arr_points_inner addObject:[NSValue valueWithCGPoint:point_inner]];
        [arr_points_middle addObject:[NSValue valueWithCGPoint:point_middle]];
        [arr_points_outter addObject:[NSValue valueWithCGPoint:point_outter]];
    }
}

-(CGPoint) calcCircleCoordinateWithCenter:(CGPoint) center  andWithAngle : (CGFloat) angle andWithRadius: (CGFloat)_radius{
    CGFloat x2 = _radius*cosf(angle*M_PI/180);
    CGFloat y2 = _radius*sinf(angle*M_PI/180);
    return CGPointMake(center.x+x2, center.y-y2);
}

-(void)internalInitalScore
{
    MAX_DIVISION = 100;
    int fontsize = 55;
    
    if(H<=480)
    {
        fontsize = 55;
    }
    else if(H<=568)
    {
       fontsize = 60;
    }
    else if(H<=667)
    {
       fontsize = 65;
    }
    else if(H<=736)
    {
        fontsize = 70;
    }
    int characterWidth = fontsize/1.8;
    dy = 14;
    UIFont *font = [UIFont fontWithName:FONT_ULTRALIGHT size:fontsize];
    CGRect _frame = view_score.frame;
    _frame.size.height = font.lineHeight;
    tickerLabel = [[ADTickerLabel alloc] initWithFrame: _frame];
    tickerLabel.font = font;            //TODO: ADTickLabel有个bug 某些 fontsize 会导致 变成两个半行
    tickerLabel.characterWidth = characterWidth ;
    tickerLabel.textColor = [UIColor darkGrayColor];
    tickerLabel.changeTextAnimationDuration = 0.5;
    [self addSubview: tickerLabel];
    [self sendSubviewToBack:tickerLabel];
    tickerLabel.backgroundColor = [UIColor clearColor];
    
    lb_percent = [[UILabel alloc] init];
    lb_percent.font = font;
    lb_percent.textColor = tickerLabel.textColor;
    lb_percent.backgroundColor = [UIColor clearColor];
    lb_percent.text = @"%";
    [lb_percent sizeToFit];
    [self addSubview: lb_percent];
    [self sendSubviewToBack:lb_percent];
   
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    if(pageIndex == 1)
        return;
    
    CGRect _frame;
    drawableRegion = CGRectMake(0, 0, self.frame.size.width, self.frame.size.height);
    [self internalInitalDivisionPoints];
    [lb_title sizeToFit];
    
    
    CGFloat height = view_score.frame.size.height + lb_title.frame.size.height;
    
    lb_title.center = CGPointMake(self.frame.size.width/2, self.frame.size.height / 2 - height/2 - 20 * ratioH);
    
    
    
    _frame = view_score.frame;
    _frame.origin.y = self.frame.size.height / 2 - dy * ratioH;
    view_score.frame = _frame;
    view_score.center = CGPointMake(self.frame.size.width/2,view_score.center.y);
    
    lb_subtitle.center = CGPointMake(self.frame.size.width/2, view_score.frame.origin.y - 4 -  lb_subtitle.frame.size.height/2);
    
    CGFloat width = tickerLabel.frame.size.width + lb_percent.frame.size.width;
    _frame = tickerLabel.frame;
    _frame.origin.x = view_score.center.x - width / 2;
    tickerLabel.frame = _frame;
    tickerLabel.center = CGPointMake(tickerLabel.center.x, view_score.center.y);
    
    _frame = lb_percent.frame;
    _frame.origin.x = tickerLabel.frame.origin.x + tickerLabel.frame.size.width;
    lb_percent.frame = _frame;
    lb_percent.center = CGPointMake(lb_percent.center.x , tickerLabel.center.y);
    
    
    CGFloat fixY = 0;
    if(H<=480)
    {
       fixY = -30;
    }
    
    _frame = iv_thumbnail.frame;
    _frame.origin.y = self.frame.size.height - iv_thumbnail.frame.size.height + fixY;
    iv_thumbnail.frame = _frame;
    iv_thumbnail.center = CGPointMake(self.frame.size.width / 2, iv_thumbnail.center.y);
    
    [self setNeedsDisplay];
}

-(void)playCircleAnimationWithPercent:(CGFloat)_percent
{
    [self playCircleAnimationWithPercent:_percent isEqualLineLength:YES];
}

-(void)playCircleAnimationWithPercent:(CGFloat)_percent isEqualLineLength:(BOOL)_isEqualLineLength
{
    [self stopCircleAnimtaion];
    if(timer)
        return;
    
    isEqualLineLength = _isEqualLineLength;
    
    curPercent = 0.0f;
    int score = (int)(_percent*100);
    if(score >= 75)
    {
        score = 25;
        lb_subtitle.textColor = rank_green;
        lb_subtitle.text = multiLanguage(@"TOP");
        percent = .75;
    }
    else if(score <=25)
    {
        score = 25;
        lb_subtitle.textColor = rank_red;
        lb_subtitle.text = multiLanguage(@"BOTTOM");
        percent = .25;
    }
    else
    {
        score = 50;
        lb_subtitle.textColor = rank_green;
        lb_subtitle.text = multiLanguage(@"MIDDLE");
        percent = .5;
    }
    
    tickerLabel.text = [NSString stringWithFormat:@"%d",score];
    
//  tickerLabel.center = CGPointMake(view_score.center.x, view_score.center.y);
    
    timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(increaseCircle) userInfo:nil repeats:YES];
}

-(void)stopCircleAnimtaion
{
    tickerLabel.text = nil;
    if(!timer)
        return;
    
    [timer invalidate];
    timer = nil;
    curPercent = 0;
    
    [self setNeedsDisplay];
}

-(void)increaseCircle
{
    if(curPercent >= percent)
    {
        curPercent = percent;
        [timer invalidate];
        timer = nil;
        [self setNeedsDisplay];
        return;
    }
    
    curPercent += .01;
    [self setNeedsDisplay];
}

-(void)drawDivision:(CGContextRef)_context
{
    for(int i=0;i<[arr_points_inner count];i++)
    {
        CGPoint point_inner = [[arr_points_inner objectAtIndex:i] CGPointValue];
        CGPoint point_middle = [[arr_points_middle objectAtIndex:i] CGPointValue];
        CGPoint point_outter = [[arr_points_outter objectAtIndex:i] CGPointValue];
        if(isEqualLineLength)
        {
            [self drawLineWithContext:_context lineWidth:1 color:[UIColor RGBWithUIColor:rgb(180, 180, 180)] startP:point_inner endP:point_outter isDash:NO isHaveDefaultHeight:NO isNeedConvertPoint:NO];
        }
        else{
            [self drawLineWithContext:_context lineWidth:1 color:[UIColor RGBWithUIColor:rgb(180, 180, 180)] startP:point_inner endP:point_middle isDash:NO isHaveDefaultHeight:NO isNeedConvertPoint:NO];
        }
        
    }
}

-(void)drawCurrentPercent:(CGContextRef)_context
{
    int curIndex = curPercent * (float)MAX_DIVISION;
    
    UIColor *color;
    if(curPercent<=0.25)
    {
        color = rank_red;
    }
    else
    {
        if(MAX_DIVISION == 70)
            color = rank_lightgreen;
        else
            color = rank_green;
    }
    
    tickerLabel.textColor = color;
    lb_percent.textColor = color;
    
    for(int i=0;i<curIndex;i++)
    {
        CGPoint point_inner = [[arr_points_inner objectAtIndex:i] CGPointValue];
        CGPoint point_middle = [[arr_points_middle objectAtIndex:i] CGPointValue];
        CGPoint point_outter = [[arr_points_outter objectAtIndex:i] CGPointValue];
        if(i == curIndex - 1)
        {
            if(!isEqualLineLength)
            {
                CGPoint point_outter = [[arr_points_outter objectAtIndex:i] CGPointValue];
                [self drawLineWithContext:_context lineWidth:2 color:[UIColor RGBWithUIColor:color] startP:point_inner endP:point_outter isDash:NO isHaveDefaultHeight:NO isNeedConvertPoint:NO];
            }
        }
        else
        {
            if(isEqualLineLength)
            {
                
                [self drawLineWithContext:_context lineWidth:1 color:[UIColor RGBWithUIColor:color] startP:point_inner endP:point_outter isDash:NO isHaveDefaultHeight:NO isNeedConvertPoint:NO];
            }
            else
            {
               [self drawLineWithContext:_context lineWidth:1 color:[UIColor RGBWithUIColor:color] startP:point_inner endP:point_middle isDash:NO isHaveDefaultHeight:NO isNeedConvertPoint:NO];
            }
        }
    }
}



-(void)drawRect:(CGRect)rect
{
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();// 获取绘图上下文
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context,drawableRegion);
    [self drawDivision:context];
    [self drawCurrentPercent:context];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    tickerLabel = nil;
    lb_percent = nil;
    arr_points_outter = nil;
    arr_points_middle = nil;
    arr_points_inner = nil;
    [self.layer removeAllAnimations];
    [lb_tips.layer removeAllAnimations];
}
@end
