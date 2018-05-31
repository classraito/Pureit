//
//  FGBookGkkViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGBookGkkViewController.h"
#import "Global.h"
@interface FGBookGkkViewController ()
{
    int gkk;
}
@end

@implementation FGBookGkkViewController
@synthesize iv_thumbnail;
@synthesize lb_gkkName;
@synthesize lb_price;
@synthesize lb_key_address;
@synthesize iv_editIcon;
@synthesize ctf_username;
@synthesize ctf_address;
@synthesize cb_submit;
@synthesize view_whiteBG;
@synthesize view_key_address_line;
@synthesize view_separatorLine;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil gkk:(int)_gkk
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        gkk = _gkk;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NetworkManager sharedManager] postRequest_getBookUserInfo:nil];
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view.backgroundColor = rgb(228, 229, 230);
    [[NetworkManager sharedManager] postRequest_getUserInfo:nil];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Book a GKK");
    isNeedViewMoveUpWhenKeyboardShow = YES;
    ctf_username.backgroundColor = [UIColor clearColor];
    ctf_address.backgroundColor = [UIColor clearColor];
    
    ctf_username.delegate = self;
    ctf_address.delegate = self;
    
    [commond useDefaultRatioToScaleView:iv_thumbnail];
    [commond useDefaultRatioToScaleView:lb_gkkName];
    [commond useDefaultRatioToScaleView:lb_price];
    [commond useDefaultRatioToScaleView:lb_key_address];
    [commond useDefaultRatioToScaleView:iv_editIcon];
    [commond useDefaultRatioToScaleView:ctf_username];
    [commond useDefaultRatioToScaleView:ctf_address];
    [commond useDefaultRatioToScaleView:cb_submit];
    [commond useDefaultRatioToScaleView:view_whiteBG];
    [commond useDefaultRatioToScaleView:view_key_address_line];
    [commond useDefaultRatioToScaleView:view_separatorLine];
    view_key_address_line.backgroundColor = [UIColor lightGrayColor];
    
    lb_price.font = font(FONT_BOLD, 20);
    lb_gkkName.font = font(FONT_NORMAL, 14);
    lb_key_address.font = font(FONT_NORMAL, 14);
    
    [cb_submit setFrame:cb_submit.frame title:multiLanguage(@"提交") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data =  [dataManager getDataByUrl:HOST(URL_GetGKK)];
    switch (gkk) {
        case 1:
            lb_gkkName.text = [[_dic_data objectForKey:@"Status1"] objectForKey:@"Name"];
            lb_price.text = [NSString stringWithFormat:@"￥%@",[[_dic_data objectForKey:@"Status1"] objectForKey:@"Price"]];
            break;
            
        case 2:
            lb_gkkName.text = [[_dic_data objectForKey:@"Status2"] objectForKey:@"Name"];
            lb_price.text = [NSString stringWithFormat:@"￥%@",[[_dic_data objectForKey:@"Status1"] objectForKey:@"Price"]];
            break;
    }
    
    ctf_username.maxInputLength = 50;
    ctf_address.maxInputLength = 200;
    
    ctf_username.tf.placeholder = multiLanguage(@"姓名 *");
    ctf_address.tf.placeholder = multiLanguage(@"街道，门牌号 *");
    
    ctf_address.tf.textColor = [UIColor lightGrayColor];
    
    [lb_key_address sizeToFit];
    CGRect _frame = view_key_address_line.frame;
    _frame.size.width = lb_key_address.frame.size.width;
    view_key_address_line.frame = _frame;
    
    [cb_submit.button addTarget:self action:@selector(buttonAction_submit:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data =  [dataManager getDataByUrl:HOST(URL_GetBookUserInfo)];
    ctf_username.tf.text = [_dic_data objectForKey:@"Name"];
    ctf_address.tf.text = [NSString stringWithFormat:@"%@ %@",[_dic_data objectForKey:@"City"],[_dic_data objectForKey:@"Address"]] ;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)manullyFixSize
{
    [super manullyFixSize];
}

-(void)buttonAction_submit:(id)_sender
{
    NSString *_str_username = ctf_username.tf.text;
    NSString *_str_address = ctf_address.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_username])
        str_errorMessage = multiLanguage(@"请填写您的姓名");
    else if([StringValidate isEmpty:_str_address] )
        str_errorMessage = multiLanguage(@"请填写您的邮寄地址");
    
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [[NetworkManager sharedManager] postRequest_bookGkk:_str_username address:_str_address gkk:gkk userinfo:nil];
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetBookUserInfo) isEqualToString:_str_url])
    {
        [self bindDataToUI];
    }
    if([HOST(URL_BookGKK) isEqualToString:_str_url])
    {
        [nav_main popViewControllerAnimated:NO];
        [nav_main popViewControllerAnimated:YES];
        [commond alert:multiLanguage(@"警告") message:multiLanguage(@"Book Gkk Sucess") callback:nil];
    }
}

@end
