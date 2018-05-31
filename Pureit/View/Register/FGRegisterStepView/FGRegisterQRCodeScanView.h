//
//  FGRegisterQRCodeScanView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/22.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGViewWithSepratorLineView.h"
#import "FGCustomTextFieldView.h"
#import "FGCustomButton.h"
@interface FGRegisterQRCodeScanView : UIView<FGCustomTextFieldViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_phone;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_scanQR;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_separator;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_deviceID;
@property(nonatomic,assign)IBOutlet UIView *view_bottomLine;
@end
