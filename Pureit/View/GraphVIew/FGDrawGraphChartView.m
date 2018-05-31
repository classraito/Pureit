//
//  FGDrawGraphChartView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/8.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDrawGraphChartView.h"
#import "Global.h"
#import "FGGraphModel.h"
#import "UIColor+helper.h"
#import "FGDataBannerView.h"
#import "FGGraphModel.h"
#import "FGGraphTipsAlertView.h"
CGFloat padding = 10.0f;
@interface FGDrawGraphChartView()
{
    FGGraphModel *graphModel;
    FGDataBannerView *bannerView;
    NSInteger currentIndex;
}
@end

@implementation FGDrawGraphChartView
@synthesize isDrawChina;
@synthesize isDrawMe;
-(id)initWithFrame:(CGRect)frame model:(FGGraphModel *)_model{
    if(self = [super initWithFrame:frame])
    {
        currentIndex = -1;
        self.backgroundColor = [UIColor clearColor];
        CGFloat padding = 5;
        drawableRegion = CGRectMake(padding, 0, self.bounds.size.width - padding * 2, self.bounds.size.height-padding) ;
        graphModel = _model;
        self.blendMode = kCGBlendModeNormal;
        [self internalInitalBannerView];
        self.clipsToBounds = NO;
    }
    return self;
}

-(void)internalInitalBannerView
{
    if(bannerView)
        return;
    bannerView = (FGDataBannerView *)[[[NSBundle mainBundle] loadNibNamed:@"FGDataBannerView" owner:nil options:nil] objectAtIndex:0];
    [commond useDefaultRatioToScaleView:bannerView];
    bannerView.delegate = self;
    bannerView.dragEnable = YES;
    [self addSubview:bannerView];
    
    /**初始化bannerView的位置和数据*/
    CGRect _frame = bannerView.frame;
    _frame.origin.x = self.frame.size.width - bannerView.frame.size.width+padding;//右边界
    _frame.origin.y = self.frame.size.height - bannerView.frame.size.height - 20*ratioH;
    bannerView.frame = _frame;
    
}

-(void)updateGraphModel:(FGGraphModel *)_model
{
    graphModel = _model;
    [self HSCButtonDidTouchMoved:0];
}

/*遍历_datas(存放画线的所有点的数组)数组中 所有点的位置 与_targetPoint比较 返回最接近_targetPoint的那个点在datas数组中的下标
 */
-(NSInteger)getDataIndexByDatas:(NSMutableArray *)_arr_datas targetPoint:(CGPoint)_realTargetPoint
{
    NSInteger retVal = 0;
    NSInteger index = 0;
    CGFloat distance = MAXFLOAT;
    for(NSValue *point in _arr_datas)
    {
        
        CGPoint _nearestPoint = [point CGPointValue];
        CGPoint _realPoint = [self realPoint:_nearestPoint];//把0-1坐标系 转为实际像素的坐标系
        
        if(fabs(_realTargetPoint.x - _realPoint.x) < distance)
        {
            distance = fabs(_realTargetPoint.x - _realPoint.x);
            retVal = index;//记录离_targetPoint最小距离的点的下标
        }
        index++;
    }
    return retVal;
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();// 获取绘图上下文
    CGContextClearRect(context, drawableRegion);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    
    [self drawDaysLinesIfNeeded:context];
}

/*画折线图*/
-(void)drawDaysLinesIfNeeded:(CGContextRef)context
{
    if(isDrawMe)
        [self fillPathWithContext:context color:[UIColor RGBWithUIColor:darkblue_transparent] points:graphModel.arr_points_me];
    if(isDrawChina)
        [self fillPathWithContext:context color:[UIColor RGBWithUIColor:lightblue_transparent] points:graphModel.arr_points_china];
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

+(BOOL)isTipsTAlertAlreadyShowedInWindow
{
    UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
    for(UIView *_subview in window.subviews)
    {
        if([_subview isKindOfClass:[FGGraphTipsAlertView class]])
        {
            
            return YES;
        }
    }
    return NO;
}

#pragma mark - HSCButtonDelegate
-(void)HSCButtonDidTouchBegan:(CGFloat)_offsetX;
{
    if(!bannerView)
        return;
    
    NSNumber *obj = (NSNumber *)[commond getUserDefaults:KEY_TIPS_STATUS];
    BOOL isHighlighted = [obj boolValue];
    NSLog(@"obj = %@",obj);
    if(!isHighlighted && ![FGDrawGraphChartView isTipsTAlertAlreadyShowedInWindow] )
    {
        FGGraphTipsAlertView *alert = (FGGraphTipsAlertView *)[[[NSBundle mainBundle] loadNibNamed:@"FGGraphTipsAlertView" owner:nil options:nil] objectAtIndex:0];
        [alert setupWithTitle:multiLanguage(@"Please slide left/right to see your previous consumption graph") message:multiLanguage(@"Donot show this message again") andCallBack:^(FGGraphTipsAlertView *alertView, NSInteger buttonIndex) {
            
        }];
        [alert show];
    }
}

-(void)HSCButtonDidTouchMoved:(CGFloat)_offsetX;
{
    if(!bannerView)
        return;
    
    CGRect _frame = bannerView.frame;
    _frame.origin.x += _offsetX;
    
    if(_frame.origin.x < -padding)//左边界
        _frame.origin.x = -padding;
    if(_frame.origin.x + bannerView.frame.size.width > self.frame.size.width+padding)//右边界
        _frame.origin.x = self.frame.size.width - bannerView.frame.size.width+padding;
    bannerView.frame = _frame;
    
    /*根据bannerView定位内部的iv_stick*/
    CGFloat bannerMoveRange = self.frame.size.width - bannerView.frame.size.width + padding * 2;
    CGFloat stickMoveRange = bannerView.frame.size.width - padding*2 ;
    CGFloat stickX = padding  +  (bannerView.frame.origin.x / bannerMoveRange * stickMoveRange);
    bannerView.iv_stick.center = CGPointMake(stickX+4, bannerView.iv_stick.center.y);
//    bannerView.lb_date.center = CGPointMake(bannerView.iv_stick.center.x, bannerView.lb_date.center.y);
  
    /*获得数据*/
    CGPoint indicator = [self convertPoint:bannerView.iv_stick.center fromView:bannerView];
    NSMutableArray *arr_tmp = [graphModel.arr_points_me mutableCopy];
//    [arr_tmp removeLastObject];//去掉最后一个点
//    [arr_tmp removeObjectAtIndex:0];//去掉第一个点 ，因为这两个点是为了形成封闭路径 而后加上去的 在X轴上的(0,0)和(1.0)
    NSInteger index = [self getDataIndexByDatas:arr_tmp targetPoint:indicator];
    arr_tmp = nil;
    
    if(index != currentIndex)
    {
        NSMutableDictionary *_dic = [graphModel.arr_datas objectAtIndex:index+graphModel.leftIndex];
        bannerView.lb_date.text = [_dic objectForKey:KEY_DATE];
        
        if(![commond isChinese])
        {
            
            bannerView.lb_date.text = [graphModel useUSADateFormatIfNeeded:bannerView.lb_date.text dateType:graphModel.defaultShowDays];
        }
        
        //TODO:<peng> 2016_4_13 大于1000L的用KL表示
        bannerView.lb_value_left.text = [self getStringByValue:[[_dic objectForKey:KEY_ME] floatValue]];
        bannerView.lb_value_right.text = [self getStringByValue:[[_dic objectForKey:KEY_CHINA] floatValue]];
        
//      bannerView.lb_value_left.text = [NSString stringWithFormat:@"%.1f L",[[_dic objectForKey:KEY_ME] floatValue]];
//      bannerView.lb_value_right.text = [NSString stringWithFormat:@"%.1f L",[[_dic objectForKey:KEY_CHINA] floatValue]];
    }
}

-(NSString *)getStringByValue:(float)value
{
    if (value >= 1000.0) {
     return  [NSString stringWithFormat:@"%.2fKL", value/1000];
    }
    else
    {
       return  [NSString stringWithFormat:@"%.1fL", value];
    }
}



-(void)HSCButtonDidTouchCanceled:(CGFloat)_offsetX;
{
    if(!bannerView)
        return;
    
    [UIView beginAnimations:nil context:nil];
    /*获得最接近的点*/
    CGPoint indicator = [self convertPoint:bannerView.iv_stick.center fromView:bannerView];
    
   
    NSInteger index = [self getDataIndexByDatas:graphModel.arr_points_me targetPoint:indicator];
    
    CGPoint point = [[graphModel.arr_points_me objectAtIndex:index] CGPointValue];
    point = [self realPoint:point];
    
    /*定位bannerView*/
    CGFloat bannerMoveRange = self.frame.size.width - bannerView.frame.size.width + padding * 2;
    CGFloat bannerX = point.x / self.bounds.size.width * bannerMoveRange - padding-1;
    CGRect _frame = bannerView.frame;
    _frame.origin.x = bannerX;
    bannerView.frame = _frame;
    
    /*根据bannerView定位内部的iv_stick*/
    CGFloat stickMoveRange = bannerView.frame.size.width - padding*2 ;
    CGFloat stickX = padding  +  (bannerView.frame.origin.x / bannerMoveRange * stickMoveRange);
    bannerView.iv_stick.center = CGPointMake(stickX+5, bannerView.iv_stick.center.y);
    
    /*if(_offsetX <0 && bannerView.frame.origin.x <= 0)
    {
        CGRect _frame = bannerView.lb_date.frame;
        _frame.origin.x = 0;
        bannerView.lb_date.frame = _frame;
    }
    if(_offsetX >=0 && bannerView.frame.origin.x  >= self.frame.size.width - bannerView.frame.size.width - padding)
    {
        CGRect _frame = bannerView.lb_date.frame;
        _frame.origin.x = bannerView.frame.size.width - bannerView.lb_date.frame.size.width;
        bannerView.lb_date.frame = _frame;
    }*/

    [UIView commitAnimations];
}
@end
