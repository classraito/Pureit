//
//  FGMyDevicesTableViewCell.h
//  Pureit
//
//  Created by Ryan Gong on 16/3/2.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGMyDevicesTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UIView *view_deviceBG;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_deviceId;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_deviceId;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_reset;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_delete;
@property(nonatomic,assign)IBOutlet UIImageView *iv_resetIcon;
@property(nonatomic,assign)IBOutlet UIImageView *iv_deleteIcon;
@property(nonatomic,assign)IBOutlet UIImageView *iv_setDefault;
@property(nonatomic,assign)IBOutlet UILabel *lb_setDefault;
@property(nonatomic,assign)IBOutlet UIButton *btn_setDefault;
@property(nonatomic,assign)IBOutlet UIButton *btn_reset;
@property(nonatomic,assign)IBOutlet UIButton *btn_delete;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UILabel *lb_deviceName;
@end
