//
//  FGDrawGraphView.m
//  Pureit
//
//  Created by Ryan Gong on 16/1/7.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDrawGraphBGView.h"
#import "Global.h"
#import "FGGraphModel.h"

#import "FGGraphModel.h"
#import "FGDrawGraphChartView.h"
#define MAX_TIMERCOUNT 200.0f

@interface FGDrawGraphBGView()
{
    CGPoint gridStartH[5];//横线起点
    CGPoint gridEndH[5];//横线终点
    
    CGPoint gridStartV[4];//竖线起点
    CGPoint gridEndV[4];//竖线终点
    
    CGFloat leftPadding;
    CGFloat rightPadding;
    NSTimer *timer;
    NSMutableArray *arr_pointCopy_me;
    NSMutableArray *arr_pointCopy_china;
    int timerCount;
}
@end

@implementation FGDrawGraphBGView
@synthesize graphModel;
@synthesize view_chart;
-(id)initWithFrame:(CGRect)frame defaultDays:(int)defaultDays{
    if(self = [super initWithFrame:frame])
    {
        rightPadding = 10;
        leftPadding = 30;
        self.backgroundColor = [UIColor clearColor];
        arr_innerLabels = [[NSMutableArray alloc] initWithCapacity:1];
        arr_xLabels = [[NSMutableArray alloc] initWithCapacity:1];
        drawableRegion = self.bounds;
        [self buildGridPoints];
        self.clipsToBounds = NO;
        
        graphModel = [[FGGraphModel alloc] initWithDrawableRegion:CGRectMake(0, 0, drawableRegion.size.width - rightPadding - leftPadding, drawableRegion.size.height)];
        graphModel.defaultShowDays = defaultDays;
        
        [self internalInitInnerLabel];
        [self internalInitalCharView];
        
    }
    return self;
}

-(void)bindDataToUI
{
    NSMutableArray *_arr_data = nil;
    
    DataManager *datamanager = [DataManager sharedManager];
    
    NSMutableDictionary *dic_info = [datamanager getDataByUrl:HOST(URL_GetData)];
    switch ((int)graphModel.defaultShowDays) {
        case DEFAULTDATAS_DAY:
            _arr_data = [dic_info objectForKey:@"Daily"];
            [graphModel analyizeData:_arr_data];
            break;
            
        case DEFAULTDATAS_WEEK:
            _arr_data = [dic_info objectForKey:@"Monthly"];
            [graphModel analyizeData:_arr_data];
            break;
            
        case DEFAULTDATAS_MONTH:
            _arr_data = [dic_info objectForKey:@"Yearly"];
            [graphModel analyizeData:_arr_data];
            break;
    }
    
    
    if([graphModel.arr_datas count]>0)
    {
        
        [self doShowLabels];
        [self layoutInnerLabel];
        
        
        [arr_xLabels removeAllObjects];
        [self internalInitOutterLabel:(int)graphModel.showDaysInDrawableRegion];
        [self doShowXLabels];
        [self layoutOutterLabel:(int)graphModel.showDaysInDrawableRegion];
        
        [view_chart updateGraphModel:graphModel];
    }
}

-(void)startAnimtaion
{
    if(timer)
        return;
    if(!graphModel)
        return;
    if([graphModel.arr_datas count]==0)
        return;
    view_chart.alpha = 0;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    manager.vc_homepgae.view_homeDetail.view_videoContent.alpha = 0;
    
    CGRect _frame = manager.vc_homepgae.view_homeDetail.view_videoContent.frame;
    _frame.origin.y = manager.vc_homepgae.view_homeDetail.view_myGraph.frame.size.height;
    manager.vc_homepgae.view_homeDetail.view_videoContent.frame = _frame;
    
    timerCount = 0;
    timer = [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(updateAnimation) userInfo:nil repeats:YES];
    arr_pointCopy_me = [graphModel.arr_points_me mutableCopy];
    arr_pointCopy_china = [graphModel.arr_points_china mutableCopy];
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.5f];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
     _frame = manager.vc_homepgae.view_homeDetail.view_videoContent.frame;
    _frame.origin.y = manager.vc_homepgae.view_homeDetail.view_myGraph.frame.size.height - _frame.size.height / 2;
    manager.vc_homepgae.view_homeDetail.view_videoContent.frame = _frame;
    [UIView commitAnimations];
}

-(void)updateAnimation
{
    [graphModel.arr_points_china removeAllObjects];
    [graphModel.arr_points_me removeAllObjects];
    for(int i=0;i<[arr_pointCopy_me count];i++)
    {
        CGPoint point_me = [[arr_pointCopy_me objectAtIndex:i] CGPointValue];
        CGPoint point_china = [[arr_pointCopy_china objectAtIndex:i] CGPointValue];
        
        CGPoint point_me_current = point_me;
        point_me_current.y = timerCount / MAX_TIMERCOUNT * point_me.y;
        [graphModel.arr_points_me addObject:[NSValue valueWithCGPoint:point_me_current]];
        
        CGPoint point_china_current = point_china;
        point_china_current.y = timerCount / MAX_TIMERCOUNT * point_china.y;
        [graphModel.arr_points_china addObject:[NSValue valueWithCGPoint:point_china_current]];
        
    }
    view_chart.alpha = timerCount / MAX_TIMERCOUNT;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    manager.vc_homepgae.view_homeDetail.view_videoContent.alpha = view_chart.alpha ;
    
    

    timerCount = timerCount < MAX_TIMERCOUNT?timerCount+1:MAX_TIMERCOUNT;
    
    if(timerCount == MAX_TIMERCOUNT)
    {
        [self stopAnimtaion];
    }
    
    [view_chart setNeedsDisplay];
}

-(void)stopAnimtaion
{
    if(!timer)
        return;
    [timer invalidate];
    timer = nil;
    timerCount = 0;
    view_chart.alpha = 1;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    manager.vc_homepgae.view_homeDetail.view_videoContent.alpha = 1;
    
    CGRect _frame = manager.vc_homepgae.view_homeDetail.view_videoContent.frame;
    _frame.origin.y = manager.vc_homepgae.view_homeDetail.view_myGraph.frame.size.height - _frame.size.height/2;
    manager.vc_homepgae.view_homeDetail.view_videoContent.frame = _frame;
    
    [graphModel.arr_points_china removeAllObjects];
    [graphModel.arr_points_me removeAllObjects];
    [graphModel.arr_points_china addObjectsFromArray:arr_pointCopy_china];
    [graphModel.arr_points_me addObjectsFromArray:arr_pointCopy_me];
    arr_pointCopy_china = nil;
    arr_pointCopy_me = nil;
}

-(void)resetAnimtaion
{
    [self stopAnimtaion];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    manager.vc_homepgae.view_homeDetail.view_videoContent.alpha = 0;
    
    CGRect _frame = manager.vc_homepgae.view_homeDetail.view_videoContent.frame;
    _frame.origin.y = manager.vc_homepgae.view_homeDetail.view_myGraph.frame.size.height;
    manager.vc_homepgae.view_homeDetail.view_videoContent.frame = _frame;
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1];
    view_chart.alpha = 0;
    [UIView commitAnimations];
    
}

- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    CGContextRef context = UIGraphicsGetCurrentContext();// 获取绘图上下文
    CGContextClearRect(context, drawableRegion);
    CGContextSetFillColorWithColor(context, [UIColor clearColor].CGColor);
    CGContextFillRect(context,drawableRegion);
    [self drawGridLine:context];
    if(view_chart)
        [view_chart setNeedsDisplay];
}

-(void)internalInitalCharView
{
    if(view_chart)
    {
        return;
    }
    
    view_chart = [[FGDrawGraphChartView alloc] initWithFrame:CGRectMake(leftPadding, 0, self.bounds.size.width - leftPadding - rightPadding, self.bounds.size.height + 5) model:graphModel];
    view_chart.alpha = 0;
    view_chart.clipsToBounds = NO;
    [self addSubview:view_chart];
    
}

/*初始化框内的5个标签*/
-(void)internalInitInnerLabel
{
    for(int i=0;i<5;i++)
    {
        UILabel *lb = [[UILabel alloc] init];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = font(FONT_NORMAL, 14);
        lb.text = LABEL_DEFAULT_VALUE;
        lb.hidden = YES;
        [self addSubview:lb];
        [arr_innerLabels  addObject:lb];
    }
}

/*对框内的5个标签布局*/
-(void)layoutInnerLabel
{
    CGRect _frame;
    float cellHeight = drawableRegion.size.height / 5.0f;
    CGFloat firstCenterX = 0;
    int maxIndex = (int)[arr_innerLabels count]-1;
    for(int i=maxIndex;i>=0;i--)
    {
        UILabel *lb = (UILabel *)[arr_innerLabels objectAtIndex:i];
        lb.textAlignment = NSTextAlignmentCenter;
        _frame = lb.frame;
        _frame.origin.x = 0;
        _frame.size.width = 30;
        _frame.size.height = cellHeight;
        lb.frame = _frame;
        if(i == maxIndex)
            lb.center = CGPointMake(lb.center.x, cellHeight * (maxIndex- i) + lb.frame.size.height / 2);
        else
            lb.center = CGPointMake(firstCenterX, cellHeight * (maxIndex- i) + lb.frame.size.height / 2);
        firstCenterX = lb.center.x;
    }
   
}

/*设置y轴的标签的属性*/
-(void)setInnerLabel:(int)_index text:(NSString *)_str_text  color:(UIColor *)_color isHidden:(BOOL)_hidden
{
    if([arr_innerLabels count] <= _index)
        return;
    UILabel *lb = (UILabel *)[arr_innerLabels objectAtIndex:_index];
    lb.text = _str_text;
    lb.hidden = _hidden;
    [lb sizeToFit];
    lb.textColor = _color;
}


/*初始化x轴框外的5个标签*/
-(void)internalInitOutterLabel:(int)_labelCount
{
    
    for(int i=0;i<_labelCount;i++)
    {
        UILabel *lb = [[UILabel alloc] init];
        lb.backgroundColor = [UIColor clearColor];
        lb.font = font(FONT_NORMAL, 10);
        lb.text = LABEL_DEFAULT_VALUE;
        lb.hidden = YES;
        [view_chart addSubview:lb];
        [arr_xLabels  addObject:lb];
    }
}

/*对x轴框外的标签布局*/
-(void)layoutOutterLabel:(int)_labelCount
{
    CGRect _frame;
    for(int i=0;i<_labelCount;i++)
    {
        CGPoint p = [[graphModel.arr_points_china objectAtIndex:i ] CGPointValue];
        
        UILabel *lb = (UILabel *)[arr_xLabels objectAtIndex:i];
        lb.textAlignment = NSTextAlignmentCenter;
        _frame = lb.frame;
        _frame.size.width = 100;
        _frame.size.height = 20;
        
        lb.frame = _frame;
        lb.center = CGPointMake(p.x * view_chart.frame.size.width - 5 * ratioW, view_chart.frame.origin.y + view_chart.frame.size.height + 8 * ratioH);
    }
}

/*设置x轴的标签的属性*/
-(void)setOutterLabel:(int)_index text:(NSString *)_str_text  color:(UIColor *)_color isHidden:(BOOL)_hidden
{
    if([arr_xLabels count] <= _index)
        return;
    UILabel *lb = (UILabel *)[arr_xLabels objectAtIndex:_index];
    lb.text = _str_text;
    lb.hidden = _hidden;
    [lb sizeToFit];
    lb.backgroundColor = [UIColor clearColor];
    lb.textColor = _color;
    
//    lb.layer.anchorPoint = CGPointMake(.5, .5);
//    lb.transform = CGAffineTransformMakeRotation(RADIANS(-30));
}

-(void)doShowLabels
{
    CGFloat highestValue = graphModel.highestValueInDrawableRegion;
    CGFloat cellValue = highestValue / 5.0f;
    
    
    NSLog(@"highestValue = %f",highestValue);
    NSLog(@"cellValue = %f",cellValue);
    
    for(int i=0 ;i < [arr_innerLabels count];i++)
    {
        NSString *_str_text = nil;
        if(cellValue * i<1000)
        {
            if(cellValue < 1)
                _str_text = [NSString stringWithFormat:@"%.2f",cellValue * i];
            else
             _str_text = [NSString stringWithFormat:@"%d",(int)cellValue * i  ] ;
        }
        
        else
            _str_text = [NSString stringWithFormat:@"%.1fk",(int)cellValue* i / 1000.0f   ] ;
        [self setInnerLabel:i text:_str_text color:[UIColor darkGrayColor] isHidden:NO];
    }
    
}




-(void)doShowXLabels
{
    @try {
        for(NSInteger i =0 ;i<[arr_xLabels count] ;i++)
        {
            NSString *str_cellValue = [[graphModel.arr_datas objectAtIndex:i + graphModel.leftIndex] objectForKey:KEY_DATE];
           
            if(![commond isChinese] || graphModel.defaultShowDays == DEFAULTDATAS_DAY)
                str_cellValue = [graphModel useUSADateFormatIfNeeded:str_cellValue dateType:graphModel.defaultShowDays];
            if(graphModel.defaultShowDays==DEFAULTDATAS_WEEK)
            {
                NSArray *arr = [str_cellValue componentsSeparatedByString:@" - "];
                str_cellValue = [arr objectAtIndex:0];
            }
           
            [self setOutterLabel:(int)i text:str_cellValue color:[UIColor darkGrayColor] isHidden:NO];
        }
    }
    @catch (NSException *exception) {
        
    }
}
#pragma mark - 数据构建,布局和初始化
/*创建网格点*/
-(void)buildGridPoints
{
    CGFloat _cellHeight = 1.0f / 5.0f;//按高度五等分
    /*构建5条横线*/
    for(int i=0;i<5;i++)
    {
        CGPoint pStartH = CGPointMake( 0, _cellHeight * i);
        CGPoint pEndH = CGPointMake( 1, _cellHeight * i);
        gridStartH[i] = pStartH;
        gridEndH[i] = pEndH;
    }
    
    CGFloat _cellWidth = 1.0f / 4.0f;//按宽度四等分
    /*构建4条竖线*/
    for(int i=0;i<4;i++)
    {
        CGPoint pStartW = CGPointMake(  _cellWidth * i,0);
        CGPoint pEndW = CGPointMake(  _cellWidth * i,1);
        gridStartV[i] = pStartW;
        gridEndV[i] = pEndW;
    }

}

#pragma mark - 绘图方法
/*画背景上的网格*/
-(void)drawGridLine:(CGContextRef)context
{
    /*画五条横线*/
    for(int i=0;i<ARRAY_SIZE(gridEndH);i++)
    {
        if(i==0)
            [self drawLineWithContext:context lineWidth:LINEWIDTH * 6 color:[UIColor RGBWithUIColor:rgb(180, 180, 180)] startP:gridStartH[i] endP:gridEndH[i] isDash:NO
                  isHaveDefaultHeight:NO isNeedConvertPoint:YES];
        else
            [self drawLineWithContext:context lineWidth:LINEWIDTH * 6 color:[UIColor RGBWithUIColor:rgb(180, 180, 180)] startP:gridStartH[i] endP:gridEndH[i] isDash:YES
              isHaveDefaultHeight:NO isNeedConvertPoint:YES];
    }
    
    /*画四条竖线*/
    for(int i=0;i<ARRAY_SIZE(gridEndV);i++)
    {
            [self drawLineWithContext:context lineWidth:LINEWIDTH * 6 color:[UIColor RGBWithUIColor:rgb(220, 220, 220)] startP:gridStartV[i] endP:gridEndV[i] isDash:NO
                  isHaveDefaultHeight:NO isNeedConvertPoint:YES];
    }

}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [arr_innerLabels removeAllObjects];
    [arr_xLabels removeAllObjects];
    arr_xLabels = nil;
    arr_innerLabels = nil;
    graphModel = nil;
    arr_pointCopy_china = nil;
    arr_pointCopy_me = nil;
}
@end
