//
//  FGSettingMenuHomeViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/9.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGSettingMenuHomeViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_home;
@property(nonatomic,assign)IBOutlet UIImageView *iv_home;
@property(nonatomic,assign)IBOutlet UIButton *btn_home;
@property(nonatomic,assign)IBOutlet UILabel *lb_deviceManagement;
@property(nonatomic,assign)IBOutlet UIImageView *iv_deviceManagement;
@property(nonatomic,assign)IBOutlet UIButton *btn_deviceManagement;
@property(nonatomic,assign)IBOutlet UILabel *lb_clubPureit;
@property(nonatomic,assign)IBOutlet UIImageView *iv_clubPureit;
@property(nonatomic,assign)IBOutlet UIButton *btn_clubPureit;
@property(nonatomic,assign)IBOutlet UILabel *lb_myProfile;
@property(nonatomic,assign)IBOutlet UIImageView *iv_myProfile;
@property(nonatomic,assign)IBOutlet UIButton *btn_myProfile;
@property(nonatomic,assign)IBOutlet UILabel *lb_FAQs;
@property(nonatomic,assign)IBOutlet UIImageView *iv_FAQs;
@property(nonatomic,assign)IBOutlet UIButton *btn_FAQs;
@property(nonatomic,assign)IBOutlet UILabel *lb_AboutPureit;
@property(nonatomic,assign)IBOutlet UIImageView *iv_AboutPureit;
@property(nonatomic,assign)IBOutlet UIButton *btn_AboutPureit;
@property(nonatomic,assign)IBOutlet UILabel *lb_Settings;
@property(nonatomic,assign)IBOutlet UIImageView *iv_Settings;
@property(nonatomic,assign)IBOutlet UIButton *btn_Settings;

@property(nonatomic,assign)IBOutlet UIView *view_line1;
@property(nonatomic,assign)IBOutlet UIView *view_line2;
@property(nonatomic,assign)IBOutlet UIView *view_line3;
@property(nonatomic,assign)IBOutlet UIView *view_line4;
@property(nonatomic,assign)IBOutlet UIView *view_line5;
@property(nonatomic,assign)IBOutlet UIView *view_line6;
@property(nonatomic,assign)IBOutlet UIView *view_line7;



-(IBAction)buttonAction_home:(id)_sender;
-(IBAction)buttonAction_deviceManagement:(id)_sender;
-(IBAction)buttonAction_clubPureit:(id)_sender;
-(IBAction)buttonAction_myProfile:(id)_sender;
-(IBAction)buttonAction_FAQs:(id)_sender;
-(IBAction)buttonAction_aboutPureit:(id)_sender;
-(IBAction)buttonAction_settings:(id)_sender;
@end
