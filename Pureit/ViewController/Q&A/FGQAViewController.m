//
//  FGQAViewController.m
//  Pureit
//
//  Created by Ryan Gong on 16/3/21.
//  Copyright © 2016年 Ryan Gong. All rights reserved.
//

#import "FGQAViewController.h"
#import "Global.h"
#import "FGQAAnswerTableViewCell.h"
#import "FGQAQuestionTableViewCell.h"
#define TYPE_COUNT 4
@interface FGQAViewController ()
{
    NSMutableArray *arr_dataInTable;
    NSArray *arr_sectionTitle;
    UILabel *lb_tmp;
    NSMutableArray *arr_sectionStatus;
}
@end

@implementation FGQAViewController
@synthesize tb;
@synthesize sb;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        arr_dataInTable = [[NSMutableArray alloc] init];
        arr_sectionStatus = [[NSMutableArray alloc] init];
        for(int i=0;i<TYPE_COUNT;i++)
        {
            [arr_sectionStatus addObject:[NSNumber numberWithBool:NO]];
        }
        
        arr_sectionTitle = @[multiLanguage(@"APP FUNCTIONALITY"),multiLanguage(@"REGISTRATION"),multiLanguage(@"DEVICE"),multiLanguage(@"SERVICE RELATED")];
        [self initDataByKeyword:@""];
        isNeedViewMoveUpWhenKeyboardShow = NO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lb_tmp = [[UILabel alloc] init];
    lb_tmp.font = font(FONT_NORMAL, 18);
    lb_tmp.numberOfLines = 0;
    
    [self.view addSubview:lb_tmp];
    lb_tmp.hidden = YES;
    
    isViewDidLayoutSubviewsShouldBeCall = NO;
    self.view_topPanel.str_title = multiLanguage(@"FAQs");
    self.view_topPanel.lb_title.font = font(FONT_BOLD, 24);
    tb.delegate = self;
    tb.dataSource = self;
    tb.allowsSelection = YES;
    [commond useDefaultRatioToScaleView:tb];
    [commond useDefaultRatioToScaleView:sb];
    
    sb.delegate = self;
    
    [self doReloadTable];
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch;
{
    return NO;
}

-(void)setAllSectionStatusOpen
{
    for(int i=0;i<TYPE_COUNT;i++)
    {
        [arr_sectionStatus replaceObjectAtIndex:i withObject:[NSNumber numberWithBool:YES]];
    }
}

-(void)initDataByKeyword:(NSString *)_str_keyword
{
    [arr_dataInTable removeAllObjects];
    for(int i = 1; i <= TYPE_COUNT; i++)
    {
        NSMutableArray *arr_allColumnResult =[[DatabaseManager singleDatabaseManager] searchByKeyWord:_str_keyword type:i];
        if(arr_allColumnResult && [arr_allColumnResult count]>0)
        {
             [arr_dataInTable addObject:arr_allColumnResult];
        }
        
    }
    [self doReloadTable];
}

/*根据section下标获得第一条数据的type 然后根据type返回section的title*/
-(NSString *)getSectionNameBySection:(NSInteger)_section
{
    if([arr_dataInTable count]<=0)
        return nil;
    NSMutableArray *arr_singleSection = [arr_dataInTable objectAtIndex:_section];
    if([arr_singleSection count]<=0)
        return nil;
    int type = [[[arr_singleSection objectAtIndex:0] objectForKey:@"type"] intValue];
    return [arr_sectionTitle objectAtIndex:type - 1];
}

-(void)doReloadTable
{
    [tb reloadData];
    [tb setNeedsDisplay];
}

-(void)buttonAction_back:(id)_sender;
{
    [appDelegate.slideViewController showRightViewController:YES];
    [nav_main popViewControllerAnimated:YES];
}

-(void)resetShowAnswerBySection:(NSInteger)_section
{
    NSMutableArray *_arr_singleSection = [[arr_dataInTable objectAtIndex:_section] mutableCopy];
        for(NSMutableDictionary *_dic_singleQA in _arr_singleSection)
        {
            if(![[_dic_singleQA objectForKey:@"isquestion"] boolValue])
            {
                [[arr_dataInTable objectAtIndex:_section] removeObject:_dic_singleQA];
                continue;
            }
            
            [_dic_singleQA setObject:[NSNumber numberWithBool:NO] forKey:@"answershowed"];
        }
    _arr_singleSection = nil;
}

-(void)manullyFixSize
{
    [super manullyFixSize];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_dataInTable = nil;
}


-(void)sectionTapped:(UITapGestureRecognizer *)_sender
{
    NSInteger section = _sender.view.tag - 1;
    BOOL isSectionOpen = [[arr_sectionStatus objectAtIndex:section] boolValue];
    isSectionOpen = isSectionOpen ? NO : YES;
    [arr_sectionStatus replaceObjectAtIndex:section withObject:[NSNumber numberWithBool:isSectionOpen]];
    [self resetShowAnswerBySection:section];
    [self doReloadTable];
}


#pragma mark - UITableViewDelegate
/*table cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSMutableDictionary *_dic_singleData = [[arr_dataInTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    if([[_dic_singleData objectForKey:@"isquestion"] boolValue])
        lb_tmp.text = [_dic_singleData objectForKey:@"question"];
    else
        lb_tmp.text = [_dic_singleData objectForKey:@"answer"];
    
    CGFloat paddingLR = 15;
    lb_tmp.frame = CGRectMake(paddingLR, 0, W - paddingLR * 4, 43.5);
    [commond useDefaultRatioToScaleView:lb_tmp];
    [lb_tmp sizeToFit];
    [lb_tmp setLineSpace:8 alignment:NSTextAlignmentLeft];
    CGFloat paddingTB =15;
    CGFloat height = lb_tmp.frame.size.height + paddingTB * 2;
    
    return height * ratioH;
}


#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return [arr_dataInTable count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section;
{
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    BOOL isSectionOpen = [[arr_sectionStatus objectAtIndex:section] boolValue];
    if(!isSectionOpen)
        return 0;
    
    return [[arr_dataInTable objectAtIndex:section] count];
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
{
    return [self getSectionNameBySection:section];
}

- (UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    NSString *sectionTitle = [self tableView:tableView titleForHeaderInSection:section];
    if (sectionTitle == nil) {
        return  nil;
    }
    
    UILabel * label = [[UILabel alloc] init] ;
    label.frame = CGRectMake(10, 0, tableView.bounds.size.width, 42);
    label.font = font(FONT_BOLD, 18);
    label.text = sectionTitle;
    label.textColor = [UIColor whiteColor];
    label.userInteractionEnabled = NO;
    
    UIView * sectionView = [[UIView alloc] init];
    [sectionView setBackgroundColor:[UIColor whiteColor] ];
    
    
    UIView *sectionBG = [[UIView alloc] initWithFrame:CGRectMake(0, 2, tableView.bounds.size.width, 42)];
    [sectionBG setBackgroundColor:rgb(204, 204, 204) ];
    [sectionView addSubview:sectionBG];
    [sectionBG addSubview:label];
    
    UITapGestureRecognizer *_tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(sectionTapped:)];
    _tap.cancelsTouchesInView = NO;
    [sectionView addGestureRecognizer:_tap];
    
    sectionView.tag = section + 1;
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(![[[[arr_dataInTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"isquestion"] boolValue])//如果不是问题 而是答案
    {
        NSString *CellIdentifier = [NSString stringWithFormat:@"FGQAAnswerTableViewCell%ld%ld",indexPath.section,indexPath.row];
        FGQAAnswerTableViewCell *cell = (FGQAAnswerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FGQAAnswerTableViewCell" owner:self options:nil];
            cell = (FGQAAnswerTableViewCell *)[nib objectAtIndex:0];
        }
        cell.lb_answer.text = [[[arr_dataInTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"answer"];
        [cell sizeToFit];
        return cell;

    }
    else//如果是问题
    {
        NSString *CellIdentifier = [NSString stringWithFormat:@"FGQAQuestionTableViewCell%ld%ld",indexPath.section,indexPath.row];
        FGQAQuestionTableViewCell *cell = (FGQAQuestionTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"FGQAQuestionTableViewCell" owner:self options:nil];
            cell = (FGQAQuestionTableViewCell *)[nib objectAtIndex:0];
        }
        cell.lb_question.text = [[[arr_dataInTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] objectForKey:@"question"];
        cell.lb_question.numberOfLines = 0;
        [cell sizeToFit];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    if([sb isFirstResponder])
    {
        [sb resignFirstResponder];
    }
    
    UITableViewCell *curCell = [tableView cellForRowAtIndexPath:indexPath];
    if([curCell isKindOfClass:[FGQAAnswerTableViewCell class]])
        return;
    
    if([curCell isKindOfClass:[FGQAQuestionTableViewCell class]])
    {
        FGQAQuestionTableViewCell *cell = (FGQAQuestionTableViewCell *)curCell;
        NSMutableDictionary *_dic_singleOriginalData = [[arr_dataInTable objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
       
        if([[_dic_singleOriginalData objectForKey:@"answershowed"] boolValue])//已经打开过问题
        {
            [_dic_singleOriginalData setObject:[NSNumber numberWithBool:NO] forKey:@"answershowed"];
            NSIndexPath *selectedAnswerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1  inSection:indexPath.section];
            
            NSMutableArray *_arr_singleSection = [arr_dataInTable objectAtIndex:selectedAnswerIndexPath.section];
            [_arr_singleSection removeObjectAtIndex: selectedAnswerIndexPath.row];
            
            [cell closeAnimation];
            
            [tb beginUpdates];
            NSArray *arrInsertRows = [NSArray arrayWithObject:selectedAnswerIndexPath];
            [tb deleteRowsAtIndexPaths:arrInsertRows withRowAnimation:UITableViewRowAnimationNone];
            [tb endUpdates];
        }
        else//没有打开过问题
        {
            
            [_dic_singleOriginalData setObject:[NSNumber numberWithBool:YES] forKey:@"answershowed"];
            NSIndexPath *selectedAnswerIndexPath = [NSIndexPath indexPathForRow:indexPath.row + 1  inSection:indexPath.section];
            
            NSMutableArray *_arr_singleSection = [arr_dataInTable objectAtIndex:selectedAnswerIndexPath.section];
            NSMutableDictionary *_dic_inserted = [_dic_singleOriginalData mutableCopy];
            [_dic_inserted setObject:[NSNumber numberWithBool:NO] forKey:@"isquestion"];
            [_arr_singleSection insertObject:_dic_inserted atIndex:selectedAnswerIndexPath.row];
            _dic_inserted = nil;
            
            [cell openAnimation];
            
            [tb beginUpdates];
            NSArray *arrInsertRows = [NSArray arrayWithObject:selectedAnswerIndexPath];
            [tb insertRowsAtIndexPaths:arrInsertRows withRowAnimation:UITableViewRowAnimationNone];
            [tb endUpdates];

        }
    }
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView;
{
    [sb resignFirstResponder];
}

#pragma mark - UISearchBarDelegate
- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    NSUInteger newLength = [searchBar.text length] + [text length] - range.length;

    int maxInputLength = 100;
    
    if(newLength >= maxInputLength  )
    {
        return NO;
    }
    
    
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    if([searchBar.text length] ==0 )
    {
        searchBar.text = @"";
        [searchBar resignFirstResponder];
    }
    [self setAllSectionStatusOpen];
    [self initDataByKeyword:searchText];
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    [searchBar resignFirstResponder];
    
}
@end
