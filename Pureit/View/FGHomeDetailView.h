//
//  FGHomeDetailView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGMyGraphView.h"
#import "FGMyRankView.h"
#import "FGViewWithSepratorLineView.h"
#import "FGLocationManagerWrapper.h"
typedef enum{
    WeatherType_default = 0,
    WeatherType_night = 1,
    WeatherType_rain = 2,
    WeatherType_cold = 3,
    WeatherType_hot = 4
}WeatherType;

@interface FGHomeDetailView : UIView<UIScrollViewDelegate,FGLocationManagerWrapperDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet UILabel *lb_me;
@property(nonatomic,assign)IBOutlet UILabel *lb_china;
@property(nonatomic,assign)IBOutlet UIView *view_line_me;
@property(nonatomic,assign)IBOutlet UIView *view_line_china;
@property(nonatomic,assign)IBOutlet FGMyGraphView *view_myGraph;
@property(nonatomic,assign)IBOutlet UIView *view_roundDot;
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UIView *view_roundBoxBG;
@property(nonatomic,assign)IBOutlet UIScrollView *sv;
@property(nonatomic,assign)IBOutlet UIPageControl *upc;
@property(nonatomic,strong)UIView *view_videoContent;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_title;
@property(nonatomic,assign)IBOutlet UIButton *btn_daily;
@property(nonatomic,assign)IBOutlet UIButton *btn_weekly;
@property(nonatomic,assign)IBOutlet UIButton *btn_monthly;
@property(nonatomic,assign)IBOutlet UIButton *btn_daily_big;
@property(nonatomic,assign)IBOutlet UIButton *btn_weekly_big;
@property(nonatomic,assign)IBOutlet UIButton *btn_monthly_big;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arrowDown;
@property (weak, nonatomic) IBOutlet UILabel *lb_Y_axis;
@property (weak, nonatomic) IBOutlet UILabel *lb_X_axis;


-(IBAction)buttonAction_daily:(id)_sender;
-(IBAction)buttonAction_weekly:(id)_sender;
-(IBAction)buttonAction_monthly:(id)_sender;
@end
