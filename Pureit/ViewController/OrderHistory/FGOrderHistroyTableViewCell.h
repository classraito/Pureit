//
//  FGOrderHistroyTableViewCell.h
//  Pureit
//
//  Created by Ryan Gong on 16/3/23.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGOrderHistroyTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UIView *view_separator;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk_name;
@property(nonatomic,assign)IBOutlet UILabel *lb_gkk_ordertime;
@end
