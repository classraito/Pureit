//
//  FGDeviceManagement.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/5.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGDeviceManagementViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_gkk1_indicator1;
@property(nonatomic,assign)IBOutlet UIImageView *iv_gkk2_indicator2;
@property(nonatomic,assign)IBOutlet UIImageView *iv_gkk1;
@property(nonatomic,assign)IBOutlet UIImageView *iv_gkk2;
@property(nonatomic,assign)IBOutlet UIImageView *iv_gkk1_alert;
@property(nonatomic,assign)IBOutlet UIImageView *iv_gkk2_alert;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk1_value;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk2_value;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk1_key;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk2_key;
@property(nonatomic,assign)IBOutlet UIButton *btn_bookGkk;
@property(nonatomic,assign)IBOutlet UIButton *btn_bookGkk0;
@property(nonatomic,assign)IBOutlet UIImageView *iv_barBg_level;
@property(nonatomic,assign)IBOutlet UIImageView *iv_barBg_level1;
@property(nonatomic,assign)IBOutlet UIImageView *iv_barIndicator;
@property(nonatomic,assign)IBOutlet UILabel *lb_levelTitle;

@property (weak, nonatomic) IBOutlet UIImageView *iv_barIndicator2;
@property(nonatomic,assign)IBOutlet UILabel *lb_level_score2;

@property(nonatomic,assign)IBOutlet UIImageView *iv_barBg_level3;
@property(nonatomic,assign)IBOutlet UIImageView *iv_orderHistory;
@property(nonatomic,assign)IBOutlet UIImageView *iv_complaints;
@property(nonatomic,assign)IBOutlet UIImageView *iv_helloPureit;
@property(nonatomic,assign)IBOutlet UILabel *lb_orderHistory;
@property(nonatomic,assign)IBOutlet UILabel *lb_complaints;
@property(nonatomic,assign)IBOutlet UILabel *lb_helloPureits;
@property(nonatomic,assign)IBOutlet UIButton *btn_orderHistory;
@property(nonatomic,assign)IBOutlet UIButton *btn_complaints;
@property(nonatomic,assign)IBOutlet UIButton *btn_helloPureits;

@property(nonatomic,assign)IBOutlet UIView *view_box_gkk1;
@property(nonatomic,assign)IBOutlet UIView *view_box_gkk2;
@property(nonatomic,assign)IBOutlet UIView *view_box_level;

@property(nonatomic,assign)IBOutlet UIView *view_separatorLine1;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine2;

@property(nonatomic,assign)IBOutlet UILabel *lb_level_score;

@property(nonatomic,assign)IBOutlet UILabel *lb_gkk1_tips;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk2_tips;
@property(nonatomic,assign)IBOutlet UILabel *lb_tds_tips;
@property(nonatomic,assign)IBOutlet UIButton *btn_gkk1_showTips;
@property(nonatomic,assign)IBOutlet UIButton *btn_gkk2_showTips;

@property(nonatomic,assign)IBOutlet UIButton *btn_tds;
@property(nonatomic,assign)IBOutlet UIView *view_gkk1_container;
@property(nonatomic,assign)IBOutlet UIView *view_gkk2_container;
@property(nonatomic,assign)IBOutlet UIView *view_tds_container;

@property (weak, nonatomic) IBOutlet UIImageView *iv_input_tds;
@property (weak, nonatomic) IBOutlet UIImageView *iv_output_tds;
@property (weak, nonatomic) IBOutlet UILabel *lb_inupt_tds;
@property (weak, nonatomic) IBOutlet UILabel *lb_output_tds;


-(IBAction)buttonAction_orderHistory:(id)_sender;
-(IBAction)buttonAction_complaints:(id)_sender;
-(IBAction)buttonAction_helloPureits:(id)sender;
-(IBAction)buttonAction_gkk1ShowTips:(id)_sender;
-(IBAction)buttonAction_gkk2ShowTips:(id)_sender;
-(IBAction)buttonAction_showTDSTips:(id)_sender;
@end
