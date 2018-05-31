//
//  FGAgreementView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/8.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGAgreementView.h"
#import "Global.h"

@implementation FGAgreementView
@synthesize tv_agreement;
@synthesize is_needdelete_logo;

-(void)awakeFromNib
{
    [super awakeFromNib];
    tv_agreement.font = font(FONT_NORMAL, 13);
    tv_agreement.delegate = self;
    NSString * str = [NSString stringWithFormat:@"\n\n%@",tv_agreement.text];
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:str]; // assume string exists
    NSRange urlRange = [str rangeOfString:@"cookie政策"];
    [string addAttribute:NSLinkAttributeName
                   value:@"username://www.unilevercookiepolicy.com/en_GB/accept-policy.aspx"
                   range:urlRange];
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor blueColor]
                   range:urlRange];
    [string addAttribute:NSUnderlineStyleAttributeName
                   value:@(NSUnderlineStyleSingle)
                   range:urlRange];
    
    
    NSRange urlRange1 = [str rangeOfString:@"隐私政策"];
    [string addAttribute:NSLinkAttributeName
                   value:@"username://www.unileverprivacypolicy.com/en_gb/policy.aspx"
                   range:urlRange1];
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor blueColor]
                   range:urlRange1];
    [string addAttribute:NSUnderlineStyleAttributeName
                   value:@(NSUnderlineStyleSingle)
                   range:urlRange1];
    [string endEditing];
    
    NSRange urlRange2 = [str rangeOfString:@"的隐私政策"];
    NSRange newRange = NSMakeRange(urlRange2.location+1, urlRange2.length-1);
    [string addAttribute:NSLinkAttributeName
                   value:@"username://www.unileverprivacypolicy.com/en_gb/policy.aspx"
                   range:newRange];
    [string addAttribute:NSForegroundColorAttributeName
                   value:[UIColor blueColor]
                   range:newRange];
    [string addAttribute:NSUnderlineStyleAttributeName
                   value:@(NSUnderlineStyleSingle)
                   range:newRange];
    [string endEditing];
    
    NSMutableParagraphStyle * style = [[NSMutableParagraphStyle alloc] init];
    style.lineSpacing = 5;
    
    [string addAttributes:[NSDictionary dictionaryWithObjectsAndKeys:style,NSParagraphStyleAttributeName, nil] range:NSMakeRange(0, string.length)];
    
    tv_agreement.attributedText = string;
//    tv_agreement.dataDetectorTypes = UIDataDetectorTypeLink;
    [tv_agreement setSelectable: YES];
    [tv_agreement setEditable:NO];
    
}

-(void)setIs_needdelete_logo:(BOOL)is_needdelete_logo1
{

    NSMutableAttributedString * string1 =  [[NSMutableAttributedString alloc] initWithAttributedString:tv_agreement.attributedText];
    is_needdelete_logo = is_needdelete_logo1;
    
    if (!is_needdelete_logo) {
        
        UIImage * image1 = [UIImage imageNamed:@"terms_logo.png"];
        NSTextAttachment * attachment1 = [[NSTextAttachment alloc] init];
        attachment1.bounds = CGRectMake(-20, 0, 119, 122);
        attachment1.image = image1;
        
        NSAttributedString * attachStr1 = [NSAttributedString attributedStringWithAttachment:attachment1];
        
        //    [mutStr insertAttributedString:attachStr1 atIndex:0];
        //    tv_agreement.attributedText = mutStr;
        
        [string1 insertAttributedString:attachStr1 atIndex:0];
        tv_agreement.attributedText = string1;
        
    }
}


- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"url :%@",URL);
    if ([[URL scheme] isEqualToString:@"username"]) {
        NSString *username = [URL host];
        NSLog(@"username :%@",username);
        NSString * url = [NSString stringWithFormat:@"http://%@",username];
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
        
        return NO;
    }
    return YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect _frame = tv_agreement.frame;
    _frame.origin.x = 0;
    _frame.size.width = self.bounds.size.width;
    _frame.size.height = self.bounds.size.height;
    tv_agreement.frame = _frame;

}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
