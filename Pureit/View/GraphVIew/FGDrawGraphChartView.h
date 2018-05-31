//
//  FGDrawGraphChartView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/8.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGDrawGraphBaseView.h"
#import "HSCButton.h"
@class FGGraphModel;

@interface FGDrawGraphChartView : FGDrawGraphBaseView<HSCButtonDelegate>
{
    
}
@property BOOL isDrawMe;
@property BOOL isDrawChina;
-(id)initWithFrame:(CGRect)frame model:(FGGraphModel *)_model;
-(void)updateGraphModel:(FGGraphModel *)_model;
@end
