//
//  FGDataPickeriew.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGDataPickeriView.h"
#import "Global.h"
@interface FGDataPickeriView()
{
    NSArray *arr_datas;
    NSString *str_selected;
}
@end

@implementation FGDataPickeriView
@synthesize pv;
@synthesize delegate;
@synthesize btn;
-(void)awakeFromNib
{
    [super awakeFromNib];
    pv.delegate = self;
    btn.titleLabel.font = font(FONT_BOLD, 20);
    btn.titleLabel.textColor = deepblue;
}

-(void)setupDatas:(NSArray*)_arr_datas
{
    arr_datas = [_arr_datas copy];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_datas = nil;
    str_selected = nil;
}

-(IBAction)buttonAction_done:(id)_sender
{
    if(delegate && [delegate respondsToSelector:@selector(didCloseDataPicker: picker:)])
    {
        if(!str_selected)
            str_selected = [arr_datas objectAtIndex:0];
        [delegate didCloseDataPicker:str_selected picker:self];
    }
}

#pragma mark -
#pragma mark PickerView delegate methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arr_datas objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    str_selected = [arr_datas objectAtIndex:row];
    if(delegate && [delegate respondsToSelector:@selector(didSelectData: picker:)])
    {
        [delegate didSelectData:str_selected picker:self];
    }
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arr_datas count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
@end
