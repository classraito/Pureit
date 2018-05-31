//
//  FGAddinationalUserRegistrationView.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
typedef enum{
    Option_RegisterAsAnAdditionalUser = 1,
    Option_SignInAsAnExistingUser = 2,
    Option_UpdateMyPhoneNo = 3
}Option;

@class FGCallHelpLineView;

@interface FGAddinationalUserRegistrationView : UIView
{

    FGCallHelpLineView *view_callhelpline;
}
@property(nonatomic,assign)IBOutlet UILabel *lb_title_top;
@property(nonatomic,assign)IBOutlet UILabel *lb_option_registerAdditionalUser;
@property(nonatomic,assign)IBOutlet UILabel *lb_option_signinAsAnExistingUser;
@property(nonatomic,assign)IBOutlet UILabel *lb_option_updateMyPhoneNo;
@property(nonatomic,assign)IBOutlet UIImageView *iv_option1;
@property(nonatomic,assign)IBOutlet UIImageView *iv_option2;
@property(nonatomic,assign)IBOutlet UIImageView *iv_option3;
@property(nonatomic,assign)IBOutlet UIView *view_lineSeparator;
@property(nonatomic,assign)IBOutlet UILabel *lb_title_bottom;
@property(nonatomic,assign)IBOutlet UIImageView *iv_icon_phone;
@property(nonatomic,assign)IBOutlet UILabel *lb_callHelpLine;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_continue;
@property(nonatomic,assign)IBOutlet UIView *view_mask;
@property(nonatomic,assign)IBOutlet UIButton *btn_callHelpLine;
@property(nonatomic,assign)IBOutlet UIButton *btn_option1;
@property(nonatomic,assign)IBOutlet UIButton *btn_option2;
@property(nonatomic,assign)IBOutlet UIButton *btn_option3;
@property(nonatomic,assign)IBOutlet UIView *view_whiteBg;
@property Option option;
-(IBAction)buttonAction_callHelpLine:(id)_sender;
-(IBAction)buttonAction_option1:(id)_sender;
-(IBAction)buttonAction_option2:(id)_sender;
-(IBAction)buttonAction_option3:(id)_sender;
@end
