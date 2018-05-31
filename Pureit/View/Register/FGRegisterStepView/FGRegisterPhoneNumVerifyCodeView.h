//
//  FGRegisterPhoneNumPasswdView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomTextFieldView.h"
#import "FGCustomButton.h"
#import "FGCustomUnderlineButton.h"
#import "FGViewWithSepratorLineView.h"
@interface FGRegisterPhoneNumVerifyCodeView : UIView<FGCustomTextFieldViewDelegate>
{
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_mobile;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_verifyCode;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_next;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_sendCode;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet UILabel *lb_codeTimeLeft;
@property(nonatomic,assign)IBOutlet UILabel *lb_title_wechatSignIn;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_separator;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_wechat_signIn;
@property(nonatomic,assign)IBOutlet UIView *view_wechatBg;
-(void)setGetCodeButtonHighlighted:(BOOL)_highlighted;
-(void)cancelTimer;
@end
