//
//  FGModelFormulaMA.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/21.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

#define KEY_DATE @"Date"
#define KEY_ME @"Family"
#define KEY_CHINA @"China"
@interface FGGraphModel : NSObject
{
    
}
@property CGFloat highestValueInDrawableRegion;//y轴在可视区域内的最高值
@property CGFloat lowestValueInDrawableRegion;//y轴在可视区域内的最低值
@property NSMutableDictionary *dic_originalData;//原始数据字典
@property NSMutableArray *arr_datas;//原始数据数组
@property int leftIndex;//原始数据开始下标
@property CGFloat cellWidth;//单位宽度 //eg:drawableWidth是300 显示30条记录 那么cellWidth = 10
@property CGRect drawableRegion;//绘图区域
@property NSInteger showDaysInDrawableRegion;//绘图区域内显示的数据天数
@property(nonatomic,strong)NSMutableArray *arr_points_me;
@property(nonatomic,strong)NSMutableArray *arr_points_china;
@property CGFloat cellWidthInZeroOne;//在0-1坐标系中的cellWidth
@property CGFloat defaultShowDays;
-(id)initWithDrawableRegion:(CGRect)_region;
-(void)analyizeData:(NSMutableArray *)_arr_data;
-(NSString *)useUSADateFormatIfNeeded:(NSString *)_str_chineseDateFormat dateType:(int)_dateTypye;
@end
