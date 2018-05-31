//
//  FGModelFormulaMA.m
//  MyStock
//
//  Created by Ryan Gong on 15/9/21.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGGraphModel.h"
#import "Global.h"


@implementation FGGraphModel
@synthesize highestValueInDrawableRegion;
@synthesize lowestValueInDrawableRegion;
@synthesize arr_points_me;
@synthesize arr_points_china;
@synthesize dic_originalData;
@synthesize arr_datas;
@synthesize cellWidth;//单位宽度 //eg:drawableWidth是300 显示30条记录 那么cellWidth = 10
@synthesize drawableRegion;
@synthesize showDaysInDrawableRegion;
@synthesize cellWidthInZeroOne;
@synthesize leftIndex;
@synthesize defaultShowDays;
-(id)initWithDrawableRegion:(CGRect)_region
{
    if(self = [super init])
    {
        
        drawableRegion = _region;
        arr_points_me = [[NSMutableArray alloc] initWithCapacity:1];
        arr_points_china = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_points_me = nil;
    arr_points_china = nil;
    self.dic_originalData = nil;
    self.arr_datas = nil;
}



/*清除数据*/
-(void)clearData
{
    lowestValueInDrawableRegion = 0;
    highestValueInDrawableRegion = 0;
    [arr_points_me removeAllObjects];
    [arr_points_china removeAllObjects];
//    CGPoint startPoint = CGPointMake(0, 0);
//    [arr_points_me addObject:[NSValue valueWithCGPoint:startPoint]];
//    [arr_points_china addObject:[NSValue valueWithCGPoint:startPoint]];
}

/*模型数据创建后 被外部调用的入口 分析数据以便使用*/
-(void)analyizeData:(NSMutableArray *)_arr_data
{
    [self clearData];
    arr_datas = nil;
    arr_datas = [_arr_data mutableCopy];
    if([arr_datas count] == 1)
    {
        [arr_datas addObject:[arr_datas objectAtIndex:0]];
    }
    [self internalInitalModel];
    
}

/*初始化设置*/
-(void)internalInitalModel
{
//    [self createTestData];
    if([arr_datas count]==0)
        return;
    [self internalInitalIndexAndCellWidth:self.arr_datas];//在父类(可交互模型FGModelInteractive)中初始化leftIndex showDaysInDrawableRegion和 cellWidth
    [self calculateMaxAndMinInDrawableRegion];
    [self internalInitalPointsByKey:KEY_ME emptyArray:arr_points_me];
    [self internalInitalPointsByKey:KEY_CHINA emptyArray:arr_points_china];
    
}

-(void)createTestData
{
    self.arr_datas = [[NSMutableArray alloc] init];
    for(int i=1;i<=30;i++)
    {
        NSMutableDictionary *dic_data = [NSMutableDictionary dictionary];
        [dic_data setObject:[NSString stringWithFormat:@"2015年3月%d日",i]  forKey:KEY_DATE];
        [dic_data setObject:[NSNumber numberWithFloat:(float)(arc4random()%300+500) /10.0f] forKey:KEY_ME];
        [dic_data setObject:[NSNumber numberWithFloat:(float)(arc4random()%200+400)  /10.0f] forKey:KEY_CHINA];
        [self.arr_datas addObject:dic_data];
    }
    
    /*如果只有一条数据，补一个一摸一样的数据，这样可以形成一条平行于X轴的直线*/
    if([self.arr_datas count] == 1)
    {
        [self.arr_datas addObject:[self.arr_datas objectAtIndex:0]];
    }
}

/*调用这个方法初始化一些用于计算的变量*/
-(void)internalInitalIndexAndCellWidth:(NSMutableArray *)_arr_data
{
    
    if([_arr_data count]> defaultShowDays)
    {
        showDaysInDrawableRegion = defaultShowDays;
        leftIndex = [self.arr_datas count] - defaultShowDays;//如果超过默认显示天数 取最近的数据
    }
    else
    {
        showDaysInDrawableRegion = [_arr_data count];
        leftIndex = 0;
    }
    
    
    cellWidth = drawableRegion.size.width / (showDaysInDrawableRegion - 1);//默认可视区域宽度 / 默认数据数 = 每条数据的宽度
    cellWidthInZeroOne = 1.0f / (CGFloat)showDaysInDrawableRegion;
}

/*计算数据在可视区域内的最大值和最小值*/
-(void)calculateMaxAndMinInDrawableRegion
{
    for(NSInteger i=leftIndex;i<[arr_datas count];i++)
    {
        NSMutableDictionary *_dic = [self.arr_datas objectAtIndex:i];
        CGFloat _meValue = [[_dic objectForKey:KEY_ME] floatValue];
        CGFloat _chinaValue = [[_dic objectForKey:KEY_CHINA] floatValue];
    
        
        if(highestValueInDrawableRegion < _meValue)
            highestValueInDrawableRegion = _meValue;
        if(highestValueInDrawableRegion < _chinaValue)
            highestValueInDrawableRegion = _chinaValue;
        
    }
    NSLog(@"1.highestValueInDrawableRegion = %f",highestValueInDrawableRegion);
    int cell = 5;//最小刻度
    /*对实际的最大值构造 把它构造成 highestValueInDrawableRegion / 5 后是5的倍数 这样可以使坐标单位间隔好看些*/
//    for(int i=1 ; i<INT_MAX;i++)
//    {
//        int expectedHighestValue = cell * i ;//猜测最大值
//        if( expectedHighestValue >= highestValueInDrawableRegion)//猜测的最大值满足条件 1.比实际最大值大
//        {
//            if(expectedHighestValue % (cell*5) == 0)//猜测的最大值满足条件 2.能被最小刻度整除
//            {
//                highestValueInDrawableRegion = expectedHighestValue;//重构最大值
//                return;
//            }
//        }
//    }
    
    //TODO::<peng> 2016_4_13 标签值改成跟android一样
    if(highestValueInDrawableRegion>=cell)
        highestValueInDrawableRegion = [self arrangeGrade:highestValueInDrawableRegion Min:0];
    else if(highestValueInDrawableRegion == 0)
        highestValueInDrawableRegion = cell;
    else
        highestValueInDrawableRegion = highestValueInDrawableRegion + highestValueInDrawableRegion * .2f;//如果小于最小刻度,则最大值是实际最大值的1.2倍
    NSLog(@"2.highestValueInDrawableRegion = %f",highestValueInDrawableRegion);
    
}


-(int)decimalFloatPosition:(float)f
{
    f = fabsf(f);
    NSString * s_f = [NSString stringWithFormat:@"%f",f];
    
    if (f>1) {
        
        NSRange rang = [s_f rangeOfString:@"."];
        if (rang.location == NSNotFound) {
            
            return (int)s_f.length -1;
        }
        else
        {
            return (int)rang.location -1;
        }
    }
    else
    {
        NSString * ss = [s_f stringByReplacingOccurrencesOfString:@"0." withString:@""];
        int count = 1;
        for(int i = 0;i < ss.length;i++){
            if([ss characterAtIndex:i] == '0'){
                count++;
            }else{
                return -count;
            }
        }
    }
    return 0;
}


-(int)firstVaildNum:(float)f
{
    f = fabsf(f);
    NSString *ff = [NSString stringWithFormat:@"%f",f];
    ff = [ff stringByReplacingOccurrencesOfString:@"0." withString:@""];
    ff = [ff stringByReplacingOccurrencesOfString:@"." withString:@""];
    ff = [ff stringByAppendingString:@"0"];
    
    for(int i =0; i< ff.length;i++)
    {
        unichar cc = [ff characterAtIndex:i];
        if ( cc != '0') {
            
            NSString *result = [NSString stringWithFormat:@"%c%c",cc,[ff characterAtIndex:i+1]];
            return [result intValue];
        }
    }
    return 0;
}


-(int)arrangeGrade:(float)max Min:(float)min
{
    float result = 0;
    int size = 5;
    float value = max - min;
    value = value/size;
    int position = [self decimalFloatPosition:value];
    int fvn = [self firstVaildNum:value];
    int KStep = 10;
    for(int i = 1;i<= KStep;i++)
    {
        float stepValue = i*(100.0/KStep);
        if (fvn < stepValue) {
            
            int ss = pow(10, position);
            result = (float)(stepValue/10*ss);
            
            break;
        }
    }
    
    return (int)(result * size);
}

/*创建折线的点的集合*/
-(void)internalInitalPointsByKey:(NSString *)_str_Key emptyArray:(NSMutableArray *)_arr_points
{
    CGPoint lastPoint;
    for(NSInteger i=leftIndex;i<[self.arr_datas count];i++)
    {
        NSMutableDictionary *_dic = [self.arr_datas objectAtIndex:i];
        NSLog(@"_dic = %@",_dic);
        CGFloat _value = [[_dic objectForKey:_str_Key] floatValue];//数据
        NSLog(@"_value = %f",_value);
        CGFloat _displacement = _value - lowestValueInDrawableRegion;//到最低点的偏移量
        CGFloat _difference = highestValueInDrawableRegion - lowestValueInDrawableRegion;//最高点和最低点的差价
        NSLog(@"highestValueInDrawableRegion = %f",highestValueInDrawableRegion);
        NSLog(@"lowestValueInDrawableRegion = %f",lowestValueInDrawableRegion);
        CGFloat _percentY = 0;
        if(_difference == 0)//如果分母是0的除法 会返回NAN  这里做了处理
            _percentY = 0;
        else
            _percentY = _displacement / _difference;//均价在最高点和最低点之间的百分比 = 偏移量 / 差价 这个值就是0-1坐标系中的值
        /*以上是y轴*/
        
        CGFloat _percentX = (cellWidth / drawableRegion.size.width) * (i - leftIndex);//x轴
        CGPoint pointToDraw = CGPointMake(_percentX, _percentY);
        [_arr_points addObject:[NSValue valueWithCGPoint:pointToDraw]];
        
        if(i == [arr_datas count]-1)
            lastPoint = pointToDraw;
    }
    NSLog(@"_arr_points = %@",_arr_points);
//    lastPoint = CGPointMake(lastPoint.x, 0);
//    [_arr_points addObject:[NSValue valueWithCGPoint:lastPoint]];
}


-(NSString *)useUSADateFormatIfNeeded:(NSString *)_str_chineseDateFormat dateType:(int)_dateTypye
{
    NSString *str_usaDateFormat = nil;
    if(_dateTypye == DEFAULTDATAS_DAY)
    {
        NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSDate *date = [dateFormatter dateFromString:_str_chineseDateFormat];
        if([commond isChinese])
        {
            [dateFormatter setDateFormat:@"MM-dd"];
        }
        else
        {
            [dateFormatter setDateFormat:@"dd/MM"];
        }
        str_usaDateFormat = [dateFormatter stringFromDate:date];
    }
    
    if(_dateTypye == DEFAULTDATAS_WEEK)
    {
        if(![commond isChinese])
        {
            NSArray *arr = [_str_chineseDateFormat componentsSeparatedByString:@" - "];
            NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"M/dd"];
            NSDate *date = [dateFormatter dateFromString:[arr objectAtIndex:0]];
            
            NSDateFormatter* dateFormatter1=[[NSDateFormatter alloc] init];
            [dateFormatter1 setDateFormat:@"M/dd"];
            NSDate *date1 = [dateFormatter1 dateFromString:[arr objectAtIndex:1]];
            
            [dateFormatter setDateFormat:@"dd/MM"];
            [dateFormatter1 setDateFormat:@"dd/MM"];
            str_usaDateFormat = [NSString stringWithFormat:@"%@ - %@",[dateFormatter stringFromDate:date],[dateFormatter1 stringFromDate:date1]];
        }
    }
    
    
    if(_dateTypye == DEFAULTDATAS_MONTH)
    {
        if(![commond isChinese])
        {
            NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
            [dateFormatter setDateFormat:@"yyyy-MM"];
            NSDate *date = [dateFormatter dateFromString:_str_chineseDateFormat];
            [dateFormatter setDateFormat:@"MM/yyyy"];
            str_usaDateFormat = [dateFormatter stringFromDate:date];
        }
        
    }
    return str_usaDateFormat;
}
@end
