//
//  FGBaseViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGTopPanelView.h"
#import "TAlertView.h"
extern CGFloat currentKeyboardHeight;
@interface FGBaseViewController : UIViewController<UIGestureRecognizerDelegate>
{
    
     BOOL isViewDidLayoutSubviewsShouldBeCall;//默认是YES,当设为NO时 视图的位置发生变化时父类不会在-(void)viewDidLayoutSubviews中调用manullyFixSize 而是在-(void)viewWillAppear:(BOOL)animated中调用
}
@property(nonatomic,assign)FGTopPanelView *view_topPanel;
@property(nonatomic,strong)UIImageView *iv_bg;
@property(nonatomic,assign)IBOutlet UIView *view_contentView;
@property(nonatomic,strong)UIView *view_statusBarBg;
-(void)manullyFixSize;

/*获得任何网络数据时会通知此方法 以便基类将数据分发给子类的updateData方法*/
-(void)receivedDataFromNetwork:(NSNotification *)_notification;
/*请求网络失败后的通知*/
-(void)requestFailedFromNetwork:(NSNotification *)_notification;
-(void)buttonAction_settings:(id)_sender;
-(void)go2HomeScreen;
-(void)go2HomeScreenWithAnimate:(BOOL)_animated;
-(void)getsture_cancelKeyboard:(id)_sender;
-(void)buttonAction_back:(id)_sender;
@end
