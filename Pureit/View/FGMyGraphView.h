//
//  FGMyGraphView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/6.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
#define DEFAULTDATAS_DAY 7
#define DEFAULTDATAS_WEEK 8
#define DEFAULTDATAS_MONTH 5
@class FGDrawGraphBGView;
@interface FGMyGraphView : FGCustomizableBaseView<UIScrollViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIScrollView *sv;
@property(nonatomic,strong)FGDrawGraphBGView *view_drawGraph_days;
@property(nonatomic,strong)FGDrawGraphBGView *view_drawGraph_weeks;
@property(nonatomic,strong)FGDrawGraphBGView *view_drawGraph_month;
-(void)playAnimation;
-(void)bindDataToUI;
-(void)resetAnimation;
@end
