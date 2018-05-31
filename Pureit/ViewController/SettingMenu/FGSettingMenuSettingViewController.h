//
//  FGSettingMenuSettingViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/9.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGSettingMenuSettingViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_myDevices;
@property(nonatomic,assign)IBOutlet UIButton *btn_myDevices;
@property(nonatomic,assign)IBOutlet UILabel *lb_notifications;
@property(nonatomic,assign)IBOutlet UILabel *lb_termsConditions;
@property(nonatomic,assign)IBOutlet UIButton *btn_termsConditions;
@property(nonatomic,assign)IBOutlet UIImageView *iv_back;
@property(nonatomic,assign)IBOutlet UIButton *btn_back;
@property(nonatomic,assign)IBOutlet UIView *view_line2;
@property(nonatomic,assign)IBOutlet UIView *view_line3;
@property(nonatomic,assign)IBOutlet UIView *view_line4;
@property(nonatomic,assign)IBOutlet UIView *view_switchButtonPlaceholder;
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UIButton *btn_locationServices;
@property(nonatomic,assign)IBOutlet UILabel *lb_locationServices;
@property(nonatomic,assign)IBOutlet UIView *view_switchLocationsPlaceholder;
@property(nonatomic,assign)IBOutlet UIView *view_line5;
-(IBAction)buttonAction_settingsBack:(id)_sender;
-(IBAction)buttonAction_myDevices:(id)_sender;
-(IBAction)buttonAction_termsCondition:(id)_sender;
-(IBAction)buttonAction_switchLocations:(id)_sender;
@end
