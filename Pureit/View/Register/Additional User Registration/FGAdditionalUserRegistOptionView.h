//
//  FGAdditionalUserRegistOptionView.h
//  Pureit
//
//  Created by Ryan Gong on 16/5/12.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
#import "FGViewWithSepratorLineView.h"
@interface FGAdditionalUserRegistOptionView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UIView *view_bg;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_wecheat;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_mobile;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_OR;
@end
