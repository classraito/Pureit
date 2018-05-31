//
//  FGIntroView.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/3.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGViewWithSepratorLineView.h"
@interface FGIntroView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_title;
@property(nonatomic,assign)IBOutlet UIImageView *iv;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
-(void)setupVSLTitle:(NSString *)_str_title;
@end
