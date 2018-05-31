//
//  FGSubmitComplaintsViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/2/25.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGSubmitComplaintsViewController.h"
#import "Global.h"
#import "DataManager.h"
@interface FGSubmitComplaintsViewController ()
{
    
}
@end

@implementation FGSubmitComplaintsViewController
@synthesize tv_problemDescription;
@synthesize ctf_problemType;
@synthesize view_whiteBg;
@synthesize cb_submit;
@synthesize btn_selectProblemType;
@synthesize iv_arrowDown;
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = rgb(228, 229, 230);
    self.view_topPanel.str_title = multiLanguage(@"Register a Complaint");
    // Do any additional setup after loading the view from its nib.
    [commond useDefaultRatioToScaleView:ctf_problemType];
    [commond useDefaultRatioToScaleView:tv_problemDescription];
    [commond useDefaultRatioToScaleView:view_whiteBg];
    [commond useDefaultRatioToScaleView:cb_submit];
    [commond useDefaultRatioToScaleView:iv_arrowDown];
    ctf_problemType.tf.textColor = [UIColor lightGrayColor];
    view_whiteBg.layer.borderWidth = .5f;
    view_whiteBg.layer.borderColor  = [UIColor lightGrayColor].CGColor;
    tv_problemDescription.delegate = self;
    ctf_problemType.userInteractionEnabled = NO;
    
    
   
    
    [cb_submit setFrame:cb_submit.frame title:multiLanguage(@"提交") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor clearColor] textColor:[UIColor whiteColor] bgColor:deepblue];
    
    ctf_problemType.tf.placeholder = multiLanguage(@"Select the type of problem");
    tv_problemDescription.text = multiLanguage(@"Enter more details about the problem");
  
    ctf_problemType.maxInputLength = 240;
    isNeedViewMoveUpWhenKeyboardShow = NO;

    [cb_submit.button addTarget:self action:@selector(buttonAction_submit:) forControlEvents:UIControlEventTouchUpInside];
    
    ctf_problemType.layer.borderColor = [UIColor lightGrayColor].CGColor;
    ctf_problemType.layer.borderWidth = .5f;
    
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(resetScreen)];
    _tap.cancelsTouchesInView = NO;
    [self.view_contentView addGestureRecognizer:_tap];
    
     [ctf_problemType.tf setValue:tv_problemDescription.textColor forKeyPath:@"_placeholderLabel.textColor"];
     [tv_problemDescription becomeFirstResponder];
    ctf_problemType.tf.font = font(FONT_NORMAL, 16);
    
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
}

-(void)resetScreen
{
    [appDelegate viewMoveDown];
   // [tv_problemDescription resignFirstResponder];
    [tv_problemDescription becomeFirstResponder];
    [self removePicker];
}

-(IBAction)buttonAction_selectProblemType:(id)_sender;
{
    if(view_datapicker_problemType)
        return;
    [view_datapicker_problemType becomeFirstResponder];
    [tv_problemDescription resignFirstResponder];
    
    view_datapicker_problemType = (FGDataPickeriView *)[[[NSBundle mainBundle] loadNibNamed:@"FGDataPickeriView" owner:nil options:nil] objectAtIndex:0];
    view_datapicker_problemType.delegate = self;
    [view_datapicker_problemType setupDatas:@[
        multiLanguage(@"problem10"),
        multiLanguage(@"problem11"),
        multiLanguage(@"problem12"),
        multiLanguage(@"problem13"),
        multiLanguage(@"problem14")
        ]];
   
    CGRect _frame = view_datapicker_problemType.frame;
    _frame.size.width = self.view.frame.size.width;
    _frame.origin.y = H;
    view_datapicker_problemType.frame = _frame;
    view_datapicker_problemType.center = CGPointMake(self.view.frame.size.width / 2, view_datapicker_problemType.center.y);
    [appDelegate.window addSubview:view_datapicker_problemType];
    
    [self didSelectData:multiLanguage(@"problem10") picker:view_datapicker_problemType];
    [UIView beginAnimations:nil context:nil];
    _frame = view_datapicker_problemType.frame;
    _frame.origin.y = H - view_datapicker_problemType.frame.size.height;
    view_datapicker_problemType.frame = _frame;
    [UIView commitAnimations];
    
    /*这断代码指定所有textfield成为焦点时向上移动的高度,向上移动的方法是baseViewController中的moveUp方法*/
 /*   CGRect convertedFrame = [self.view convertRect:view_datapicker_problemType.frame toView:nav_main.view];
    //从接受对象(self.superview)的坐标系转换一个点(self.frame)到指定视图(nav_main.view)的坐标系
    heightNeedMoveWhenKeybaordShow = convertedFrame.origin.y;
    if(heightNeedMoveWhenKeybaordShow > currentKeyboardHeight )
    {
        heightNeedMoveWhenKeybaordShow =  currentKeyboardHeight;
    }
    [appDelegate viewMoveUp:heightNeedMoveWhenKeybaordShow];*/
}

-(void)removePicker
{
    if(!view_datapicker_problemType)
        return;
    if(view_datapicker_problemType.frame.origin.y>=H)
        return;
//    [tv_problemDescription becomeFirstResponder];
    [UIView animateWithDuration:.3 animations:^{
        CGRect _frame = view_datapicker_problemType.frame;
        _frame.origin.y = H;
        view_datapicker_problemType.frame = _frame;
    }completion:^(BOOL _finished){
        if(_finished)
        {
            [view_datapicker_problemType removeFromSuperview];
            view_datapicker_problemType = nil;
        }
    }];
    [appDelegate viewMoveDown];
}

-(void)didCloseDataPicker:(NSString *)_str_selected picker:(id)_dataPicker
{
    if([_dataPicker isEqual:view_datapicker_problemType])
    {
        ctf_problemType.tf.text = _str_selected;
        [self removePicker];
        [tv_problemDescription becomeFirstResponder];
    }
}

-(void)didSelectData:(NSString *)_str_selected picker:(id)_dataPicker
{
    if([_dataPicker isEqual:view_datapicker_problemType])
    {
        ctf_problemType.tf.text = _str_selected;
    }
}

-(void)buttonAction_submit:(id)_sender
{
    NSString *_str_problemType = ctf_problemType.tf.text;
    NSString *_str_problemDescription  = tv_problemDescription.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_problemType])
        str_errorMessage = multiLanguage(@"请填写您的问题类型");
    else if([StringValidate isEmpty:_str_problemDescription])
        str_errorMessage = multiLanguage(@"请填写您问题的详细描述");
    if(str_errorMessage)
    {
        [commond alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [self removePicker];
        [tv_problemDescription resignFirstResponder];
        [[NetworkManager sharedManager] postRequest_addComplaint:_str_problemType problem:_str_problemDescription userinfo:nil];
    }
}

-(void)dealloc
{
    NSLog(@"::::>dealloc %s %d",__FUNCTION__,__LINE__);
    if(view_datapicker_problemType)
    {
        [view_datapicker_problemType removeFromSuperview];
        view_datapicker_problemType = nil;
    }
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView;
{
//    CGRect convertedFrame = [view_whiteBg convertRect:tv_problemDescription.frame toView:self.view];
    //从接受对象(self.superview)的坐标系转换一个点(self.frame)到指定视图(nav_main.view)的坐标系
//    heightNeedMoveWhenKeybaordShow = convertedFrame.origin.y;
//    [tv_problemDescription becomeFirstResponder];
   [self removePicker];
    return YES;
}

-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_AddComplaint ) isEqualToString:_str_url])
    {
        [nav_main popViewControllerAnimated:NO];
        [nav_main popViewControllerAnimated:YES];
        
        DataManager *dataManager = [DataManager sharedManager];
        NSMutableDictionary *dic_result = [dataManager getDataByUrl:HOST(URL_AddComplaint)];
        NSLog(@"dic_result = %@",dic_result);
        NSString *str_complaincode = @"";
        NSString *str_alertText = @"";
        if([[dic_result allKeys] containsObject:@"ComplaintID"])
        {
            str_complaincode = [dic_result objectForKey:@"ComplaintID"];
            
        }
        
        if([StringValidate isEmpty:str_complaincode])
        {
            str_alertText = [NSString stringWithFormat:multiLanguage(@"Submit Complaints Sucess(No CompaintID)")];
        }
        else
        {
            str_alertText = [NSString stringWithFormat:multiLanguage(@"Submit Complaints Sucess"),str_complaincode];
        }
        
        [commond alert:multiLanguage(@"警告") message:str_alertText  callback:nil];
    }
}
@end
