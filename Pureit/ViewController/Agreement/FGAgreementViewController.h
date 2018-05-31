//
//  FGAgreementViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/4.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomButton.h"
#import "FGAgreementView.h"
@interface FGAgreementViewController : FGBaseViewController
{
    
}

@property(nonatomic,assign) BOOL is_agreementView_noneedlogo;

@property(nonatomic,assign)IBOutlet UIImageView *iv_logo;
@property(nonatomic,assign)IBOutlet FGAgreementView *view_agreement;
@property(nonatomic,assign)IBOutlet UIButton *btn_agree;
@property(nonatomic,assign)IBOutlet UIView *view_bottomBg;
@property(nonatomic,assign)IBOutlet UILabel *lb_agree;
@property(nonatomic,assign)IBOutlet FGCustomButton  *cb_next;
@property(nonatomic,assign)IBOutlet UIImageView *iv_agreeBox;
@property(nonatomic,assign)IBOutlet UIImageView *iv_back;
@property(nonatomic,assign)IBOutlet UIButton *btn_back;
@property (weak, nonatomic) IBOutlet UILabel *lb_top_title;
-(IBAction)buttonAction_agree:(id)_sender;

-(void)prepareForSettingMenu;


-(instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil needdelete_logo:(BOOL)needdelete_logo;
@end
