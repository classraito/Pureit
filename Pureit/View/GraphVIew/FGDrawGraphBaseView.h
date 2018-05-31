//
//  FGStockBaseView.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/17.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "colorModel.h"
#define __same_type(a,b)__builtin_types_compatible_p(typeof(a),typeof(b))
#define BUILD_BUG_ON_ZERO(e) (sizeof(struct { int:-!!(e);}))
#define __must_be_array(a) BUILD_BUG_ON_ZERO(__same_type((a), &(a)[0]))
#define ARRAY_SIZE(arr) (sizeof(arr) / sizeof((arr)[0]) +__must_be_array(arr))

#define colorModel_black  [UIColor RGBWithUIColor:[UIColor blackColor]]
#define colorModel_darkGray  [UIColor RGBWithUIColor:[UIColor darkGrayColor]]
#define colorModel_blue  [UIColor RGBWithUIColor:[UIColor blueColor]]
#define colorModel_red  [UIColor RGBWithUIColor:[UIColor redColor]]
#define colorModel_lightblue  [UIColor RGBWithUIColor:lightblue]
#define colorModel_darkblue  [UIColor RGBWithUIColor:darkblue]
#define LINEWIDTH .1f
@interface FGDrawGraphBaseView : UIView
{
    CGRect drawableRegion;
}
@property CGBlendMode blendMode;
@property CGRect drawableRegion;//实际可绘图区域
/*
 用两个点来画线段
 _colorModel 颜色
 _startP 起点
 _endP 终点
 这里传入的点是0-1取值 原点在左上的坐标
 */
-(void)drawLineWithContext:(CGContextRef)context lineWidth:(CGFloat)_lineWidth color:(colorModel *)_colorModel startP:(CGPoint )_startP endP:(CGPoint)_endP isDash:(BOOL)_isDash isHaveDefaultHeight:(BOOL)_isHaveDefaultHeight isNeedConvertPoint:(BOOL)_isNeedConvertPoint;
-(void)drawLineWithContext:(CGContextRef)context color:(colorModel *)_colorModel startP:(CGPoint )_startP endP:(CGPoint)_endP isDash:(BOOL)_isDash;
-(void)drawLineWithContext:(CGContextRef)context lineWidth:(CGFloat)_lineWidth color:(colorModel *)_colorModel startP:(CGPoint )_startP endP:(CGPoint)_endP isDash:(BOOL)_isDash;
/*
 用多个点来画线段
 _colorModel 颜色
 _arr_points 所有点的数组  数组传入的点是0-1取值 原点在左上的坐标
 这里传入的点是0-1取值 原点在左上的坐标
 */
-(void)drawMultiLinesWithContext:(CGContextRef)context color:(colorModel *)_colorModel points:(NSMutableArray *)_arr_points;
-(CGPoint)realPoint:(CGPoint)_zeroOneCoordinatePoint;
-(void)fillPathWithContext:(CGContextRef)context color:(colorModel *)_colorModel points:(NSMutableArray *)_arr_points;
@end
