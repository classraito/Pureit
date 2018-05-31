//
//  FGHomeScreenView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGMyRankView.h"
@interface FGHomeScreenView : UIView
{
    BOOL isStop_trip;
    BOOL isStop_trip1;//点击按钮，取消动画的标志
}
@property(nonatomic,assign)IBOutlet UILabel *lb_key_today;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine_today;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_today;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_average;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine_average;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_average;
@property(nonatomic,assign)IBOutlet UILabel *lb_tds;
@property(nonatomic,assign)IBOutlet UILabel *lb_tds_value_in;
@property(nonatomic,assign)IBOutlet UILabel *lb_tds_value_out;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arr_down;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arr_up;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arrowDown;
@property(nonatomic,assign)IBOutlet UIButton *btn_today;
@property(nonatomic,assign)IBOutlet UIButton *btn_average;
@property(nonatomic,assign)IBOutlet UILabel *lb_tips;
@property(nonatomic,assign)IBOutlet UILabel *lb_tips1;

-(void)bindDataToUI;
-(void)appDidToBackground;
-(void)appDidActive;
-(IBAction)buttonAction_today:(id)_sender;
-(IBAction)buttonAction_average:(id)_sender;
@end
