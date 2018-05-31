//
//  FGAddinationalUserUpdateMobileView.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/24.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGRegisterPhoneNumVerifyCodeView.h"
#import "FGCustomTextFieldView.h"
@interface FGAddinationalUserUpdateMobileView : FGRegisterPhoneNumVerifyCodeView
{
    
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_currentMobile;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_newMobile;
@end
