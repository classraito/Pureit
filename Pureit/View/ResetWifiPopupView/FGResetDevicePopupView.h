//
//  FGResetDevicePopupView.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
@interface FGResetDevicePopupView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UIView *view_whiteBg;
@property(nonatomic,assign)IBOutlet UIView *view_mask;
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_subtitle;
@property(nonatomic,assign)IBOutlet UILabel *lb_step1;
@property(nonatomic,assign)IBOutlet UILabel *lb_step2;
@property(nonatomic,assign)IBOutlet UILabel *lb_tips;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_ok;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UIImageView *iv_ss;
@property(nonatomic,retain)NSString *str_deviceID;
-(void)showPopup;
@end
