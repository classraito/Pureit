//
//  FGQAViewController.h
//  Pureit
//
//  Created by Ryan Gong on 16/3/21.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGQAViewController : FGBaseViewController<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITableView *tb;
@property(nonatomic,assign)IBOutlet UISearchBar *sb;
@end
