//
//  FGDataBannerView.h
//  Pureit
//
//  Created by Ryan Gong on 16/1/11.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HSCButton.h"
@interface FGDataBannerView : HSCButton
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_banner;
@property(nonatomic,assign)IBOutlet UIImageView *iv_stick;
@property(nonatomic,assign)IBOutlet UILabel *lb_date;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_left;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_right;
@property(nonatomic,assign)IBOutlet UIView *view_banner;
@end
