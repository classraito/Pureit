//
//  FGDialogView.h
//  MCDonald
//
//  Created by luyang on 12-5-29.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FGDialogView;
extern BOOL lock;
@protocol FGDialogViewDelegate <NSObject>
-(void)dialogDidClose:(FGDialogView *)_dialog;
@end

@interface FGDialogView : UIView
{
    
    UIDeviceOrientation _orientation;
    CGRect contentRect;
    UIButton *btn_close;
    id<FGDialogViewDelegate> delegate_dialog;
}
@property(nonatomic,assign)id<FGDialogViewDelegate> delegate_dialog;
-(void)addContentView:(UIView *)_view;
-(void)addContentView:(UIView *)_view isBackgroundFitContent:(BOOL)_isBackgroundFitContent;
-(void)fitHeightByContentView:(UIView *)_view;
- (void)showFromView:(UIView *)_view;
- (void)showInFrame:(CGRect )_frame;
- (void)showInFrame:(CGRect )_frame fromView:(UIView *)_view;
- (void)show;
-(void)closeAction:(UIButton *)_btn;
@end
