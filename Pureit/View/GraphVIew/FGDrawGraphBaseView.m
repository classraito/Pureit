//
//  FGStockBaseView.m
//  MyStock
//
//  Created by Ryan Gong on 15/9/17.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import "FGDrawGraphBaseView.h"
#import "Global.h"

#define H_PATTERN_SIZE 4
#define V_PATTERN_SIZE 4

#define H_PSIZE H_PATTERN_SIZE
#define V_PSIZE V_PATTERN_SIZE

colorModel *currentColorMode;

void MyDrawColoredPattern (void *info, CGContextRef myContext)
{
    CGFloat subunit = 2; // the pattern cell itself is 16 by 18
    
    CGRect  myRect1 = {{0,0}, {subunit, subunit}},//左上
    myRect2 = {{subunit, subunit}, {subunit, subunit}},//右下
    myRect3 = {{0,subunit}, {subunit, subunit}},//左下
    myRect4 = {{subunit,0}, {subunit, subunit}};//右上
    
    CGContextSetRGBFillColor (myContext, 1, 1, 1, currentColorMode.alpha);
    CGContextFillRect (myContext, myRect1);
    CGContextFillRect (myContext, myRect2);//白色方块
    
    CGContextSetRGBFillColor (myContext, currentColorMode.R, currentColorMode.G , currentColorMode.B, currentColorMode.alpha);
    CGContextFillRect (myContext, myRect3);
    CGContextFillRect (myContext, myRect4);//有色方块
}


void MyColoredPatternPainting (CGContextRef myContext)
{
    CGPatternRef    pattern;
    CGColorSpaceRef patternSpace;
    CGFloat         alpha = 1;
    
    static const    CGPatternCallbacks callbacks = {0,
        &MyDrawColoredPattern,
        NULL};
    
    CGContextSaveGState (myContext);
    patternSpace = CGColorSpaceCreatePattern (NULL);
    CGContextSetFillColorSpace (myContext, patternSpace);
    CGColorSpaceRelease (patternSpace);
    
    pattern = CGPatternCreate (NULL,
                               CGRectMake (0, 0, H_PSIZE, V_PSIZE),
                               CGAffineTransformMake (1, 0, 0, 1, 0, 0),
                               H_PATTERN_SIZE,
                               V_PATTERN_SIZE,
                               kCGPatternTilingConstantSpacing,
                               true,
                               &callbacks);
    
    CGContextSetFillPattern (myContext, pattern, &alpha);
    CGPatternRelease (pattern);
    CGContextFillPath(myContext);
    CGContextRestoreGState (myContext);
}

@implementation FGDrawGraphBaseView
@synthesize drawableRegion;
@synthesize blendMode;

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

/*
 画图界面坐标系统采用0 - 1的取值 这样可以避免数据单位带来的麻烦
 这个方法将左下为原点 取值从0到1 的坐标系统 转换到 左上为原点 按实际像素 取值 的坐标系统 中去
 _zeroOneCoordinatePoint eg: (0.5,0.5 ) 它代表drawableRegion的中心点 (0.5,0.4)是在中心点下面的点 最下面是0 最上面是1
 */
-(CGPoint)realPoint:(CGPoint)_zeroOneCoordinatePoint
{
    CGFloat _pointX = self.drawableRegion.size.width *  _zeroOneCoordinatePoint.x + self.drawableRegion.origin.x;
    CGFloat _pointY = self.drawableRegion.size.height * (1.0f - _zeroOneCoordinatePoint.y) + self.drawableRegion.origin.y;
    CGPoint pixelCoordinatePoint = CGPointMake(_pointX, _pointY);
    return pixelCoordinatePoint;
}

#pragma  mark - 绘图方法



/*
 用两个点来画线段
 _colorModel 颜色
 _startP 起点
 _endP 终点
 _isDash 是否虚线
 这里传入的点是0-1取值 原点在左上的坐标
 _isHaveDefaultHeight 如果是YES, 那么线断过短时使用一个默认长度
 */
-(void)drawLineWithContext:(CGContextRef)context lineWidth:(CGFloat)_lineWidth color:(colorModel *)_colorModel startP:(CGPoint )_startP endP:(CGPoint)_endP isDash:(BOOL)_isDash isHaveDefaultHeight:(BOOL)_isHaveDefaultHeight isNeedConvertPoint:(BOOL)_isNeedConvertPoint{
    
    CGContextSetLineWidth(context, _lineWidth);
    CGContextSetShouldAntialias(context, YES);
    CGContextSetRGBStrokeColor(context, _colorModel.R, _colorModel.G, _colorModel.B,_colorModel.alpha);
    
    CGPoint _realStartP = _startP;
    CGPoint _realEndP = _endP;
    
    if(_isNeedConvertPoint)
    {
         _realStartP = [self realPoint:_startP];
         _realEndP = [self realPoint:_endP];
    }
    CGPoint _points[] ={ _realStartP,_realEndP};
    
    if(_isHaveDefaultHeight)
    {
        if(fabs(_realStartP.y - _realEndP.y)  <= .8f)//设置一个默认长度
        {
            _points[0] = CGPointMake(_realStartP.x, _realStartP.y - 0.5f);
            _points[1] = CGPointMake(_realStartP.x, _realStartP.y + 0.5f);
        }
        
    }
    if(_isDash)
    {
        CGFloat lengths[] = {4,2};//先画4个点再画2个点
        CGContextSetLineDash(context, 0, lengths, 2);
    }
    else
    {
        CGContextSetLineDash(context, 0, nil, 0);
    }
    CGContextStrokeLineSegments(context, _points, 2);  // 绘制线段（默认不绘制端点）
}

/*包一层 有个默认长度*/
-(void)drawLineWithContext:(CGContextRef)context lineWidth:(CGFloat)_lineWidth color:(colorModel *)_colorModel startP:(CGPoint )_startP endP:(CGPoint)_endP isDash:(BOOL)_isDash{
    
    [self drawLineWithContext:context lineWidth:_lineWidth color:_colorModel startP:_startP endP:_endP isDash:_isDash isHaveDefaultHeight:YES isNeedConvertPoint:YES];
    
    
}

/*再包一层 默认是线宽是LINEWIDTH*/
-(void)drawLineWithContext:(CGContextRef)context  color:(colorModel *)_colorModel startP:(CGPoint )_startP endP:(CGPoint)_endP isDash:(BOOL)_isDash{
    
    [self drawLineWithContext:context lineWidth:LINEWIDTH color:_colorModel startP:_startP endP:_endP isDash:_isDash];
}

/*
 用多个点来画线段
 _colorModel 颜色
 _arr_points 所有点的数组  数组传入的点是0-1取值 原点在左上的坐标
 这里传入的点是0-1取值 原点在左上的坐标
 */
-(void)drawMultiLinesWithContext:(CGContextRef)context color:(colorModel *)_colorModel points:(NSMutableArray *)_arr_points
{
    
    CGContextSetLineWidth(context, LINEWIDTH * 8 );
    CGContextSetShouldAntialias(context, YES);
    CGContextSetLineDash(context, 0, nil, 0);
    CGContextSetRGBStrokeColor(context, _colorModel.R, _colorModel.G, _colorModel.B,_colorModel.alpha);
    for (int i=0;i<[_arr_points count];i++) {
        NSValue *point = [_arr_points objectAtIndex:i];
        CGPoint currentPoint = [point CGPointValue];
        currentPoint = [self realPoint:currentPoint];//转换一下坐标系
        if (i==0) {
            CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
            continue;
        }
        CGContextAddLineToPoint(context, currentPoint.x, currentPoint.y);
        CGContextStrokePath(context); //开始画线
        if (i<_arr_points.count) {
            CGContextMoveToPoint(context, currentPoint.x, currentPoint.y);
        }
    }
}

-(void)fillDotPathWithContext:(CGContextRef)context color:(colorModel *)_colorModel points:(NSMutableArray *)_arr_points
{
    CGContextSetLineDash(context, 0, nil, 0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetBlendMode(context, blendMode);
    CGPoint lastPoint = CGPointZero;
    CGPoint currentPoint = CGPointZero;
    for (int i=0;i<[_arr_points count];i++) {
        lastPoint = currentPoint;
        
        NSValue *point = [_arr_points objectAtIndex:i];
        currentPoint = [point CGPointValue];
        currentPoint = [self realPoint:currentPoint];//转换一下坐标系
       
        
        CGContextSetRGBFillColor (context, 1, 1, 1, 1);
        CGContextAddArc(context, currentPoint.x, currentPoint.y, 3, 0, 2 * M_PI, 0); //添加一个圆
        CGContextFillPath(context);
            
        CGContextSetRGBStrokeColor(context, currentColorMode.R, currentColorMode.G, currentColorMode.B, currentColorMode.alpha);
        CGContextAddArc(context, currentPoint.x, currentPoint.y,3, 0, 2 * M_PI, 0); //添加一个圆
        CGContextStrokePath(context);

        
    }
}

-(void)fillPathWithContext:(CGContextRef)context color:(colorModel *)_colorModel points:(NSMutableArray *)_arr_points
{
    CGContextSetLineWidth(context, LINEWIDTH*20);
    CGContextSetLineDash(context, 0, nil, 0);
    CGContextSetLineJoin(context, kCGLineJoinRound);
    CGContextSetBlendMode(context, blendMode);
    CGMutablePathRef path = nil;
    CGPoint lastPoint = CGPointZero;
    CGPoint currentPoint = CGPointZero;
    for (int i=0;i<[_arr_points count];i++) {
        lastPoint = currentPoint;
        
        NSValue *point = [_arr_points objectAtIndex:i];
        currentPoint = [point CGPointValue];
        currentPoint = [self realPoint:currentPoint];//转换一下坐标系
        if (i==0) {
            
            path = CGPathCreateMutable();
            CGPathMoveToPoint(path, NULL, currentPoint.x, currentPoint.y);
            continue;
        }
        CGPathAddLineToPoint(path, NULL, currentPoint.x, currentPoint.y);
       /* CGFloat amplitude = 10.0f;
       
        CGFloat dx = (currentPoint.x - lastPoint.x)/3.0f;
        CGFloat dy = (currentPoint.y - lastPoint.y)/3.0f;
        CGPoint cp1 = CGPointMake(lastPoint.x + dx, lastPoint.y + dy + amplitude);
        CGPoint cp2 = CGPointMake(lastPoint.x + dx * 2, lastPoint.y + dy*2 -  amplitude);
        CGPathAddCurveToPoint(path, NULL, cp1.x, cp1.y, cp2.x, cp2.y, currentPoint.x, currentPoint.y);
        
        CGFloat dx1 = (currentPoint.x - lastPoint.x)/2.0f;
        CGFloat dy1 = (currentPoint.y - lastPoint.y)/2.0f;
        static int updown = 1;
        updown = updown ==1 ? -1 : 1;
        CGPoint cp = CGPointMake(lastPoint.x + dx1, lastPoint.y + dy1 + amplitude * updown);
        CGPathAddCurveToPoint(path, NULL, cp.x, cp.y, cp.x, cp.y, currentPoint.x, currentPoint.y);*/
        
        if (i == _arr_points.count - 1) {
            currentColorMode = _colorModel;
//            CGPathCloseSubpath(path);
            CGContextAddPath(context, path);
            
        //====================以下两种填充方式可以注释来切换
//            MyColoredPatternPainting(context);//1. 模版填充
            CGContextSetRGBStrokeColor (context, currentColorMode.R, currentColorMode.G, currentColorMode.B, currentColorMode.alpha);
//            CGContextFillPath(context);//2. 纯色填充
            CGContextStrokePath(context);
        //====================
            
            CGPathRelease(path);
        }
    }
    
    [self fillDotPathWithContext:context color:_colorModel points:_arr_points];
}



@end
