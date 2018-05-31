//
//  FGAgreementView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/8.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"

@interface FGAgreementView : FGCustomizableBaseView<UITextViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITextView *tv_agreement;

@property (nonatomic,assign) BOOL is_needdelete_logo;

@end
