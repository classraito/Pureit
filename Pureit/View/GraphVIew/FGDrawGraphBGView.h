//
//  FGDrawGraphView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/7.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDrawGraphBaseView.h"
#define LABEL_DEFAULT_VALUE @"---"
@class FGGraphModel;
@class  FGDrawGraphChartView;
@interface FGDrawGraphBGView : FGDrawGraphBaseView
{
    NSMutableArray *arr_innerLabels;//存放左侧标签的数组
    NSMutableArray *arr_xLabels;//x轴坐标的标签
}
@property(nonatomic,strong)FGGraphModel *graphModel;
@property(nonatomic,strong)FGDrawGraphChartView *view_chart;
-(id)initWithFrame:(CGRect)frame defaultDays:(int)defaultDays;
-(void)startAnimtaion;
-(void)resetAnimtaion;
-(void)bindDataToUI;
@end
