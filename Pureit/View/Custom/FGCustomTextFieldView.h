//
//  FGCustomTextFieldView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
@protocol FGCustomTextFieldViewDelegate<NSObject>
@optional
-(void)didBeginEditing:(UITextField *)_tf;
-(void)didBeginEditing:(UITextField *)_tf customTF:(id)_customTF;
- (void)customTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string isLimited:(BOOL)_isLimited;
-(void)didClickDoneOnTextField:(UITextField *)_tf;
-(void)didClickRightButton:(UIButton *)_btn customTF:(id)_customTF;
@end

@interface FGCustomTextFieldView : FGCustomizableBaseView<UITextFieldDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITextField *tf;
@property(nonatomic,assign)id<FGCustomTextFieldViewDelegate>delegate;
@property  NSInteger maxInputLength;
@property  NSInteger minInputLength;
-(void)setRightThumbnail:(UIImage *)img;
-(void)setRightThumbnail:(UIImage *)img padding:(CGFloat)_padding;
@end
