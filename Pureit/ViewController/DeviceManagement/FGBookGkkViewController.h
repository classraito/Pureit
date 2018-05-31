//
//  FGBookGkkViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomTextFieldView.h"
#import "FGCustomButton.h"
@interface FGBookGkkViewController : FGBaseViewController<FGCustomTextFieldViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkkName;
@property(nonatomic,assign)IBOutlet UILabel *lb_price;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_address;
@property(nonatomic,assign)IBOutlet UIImageView *iv_editIcon;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_username;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_address;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_submit;
@property(nonatomic,assign)IBOutlet UIView *view_whiteBG;
@property(nonatomic,assign)IBOutlet UIView *view_key_address_line;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine;
-(void)buttonAction_submit:(id)_sender;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gkk:(int)_gkk;
@end
