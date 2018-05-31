//
//  FGSubmitComplaintsViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomTextFieldView.h"
#import "FGCustomButton.h"
#import "FGDataPickeriView.h"
@interface FGSubmitComplaintsViewController : FGBaseViewController<FGCustomTextFieldViewDelegate,FGDataPickerViewDelegate,UITextViewDelegate>
{
    FGDataPickeriView *view_datapicker_problemType;
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_problemType;
@property(nonatomic,assign)IBOutlet UITextView *tv_problemDescription;
@property(nonatomic,assign)IBOutlet UIButton *btn_selectProblemType;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_submit;
@property(nonatomic,assign)IBOutlet UIView *view_whiteBg;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arrowDown;
-(IBAction)buttonAction_selectProblemType:(id)_sender;
@end
