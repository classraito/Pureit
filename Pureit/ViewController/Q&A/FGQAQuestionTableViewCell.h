//
//  FGQAQuestionTableViewCell.h
//  Pureit
//
//  Created by Ryan Gong on 16/3/21.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGQAQuestionTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_question;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arr_down;
@property(nonatomic,assign)IBOutlet UIView *view_separator;
-(void)openAnimation;
-(void)closeAnimation;
@end
