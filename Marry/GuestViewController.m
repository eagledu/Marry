//
//  SecondViewController.m
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GuestViewController.h"
@interface GuestViewController (Private)
-(void)getGuest:(BOOL) refresh onCompleted:(FuncBlock) onCompleted;
@end

@implementation GuestViewController
@synthesize guestTableView = _guestTableView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    _schParams=[[MarryPagingSchParams alloc] init:nil pagingInfo:[[MarryPagingInfo alloc] init:5 pageIndex:1 sortBy:@"GuestName_en_us" asc:YES]];
    _pagingResult=[[MarryPagingResult alloc] init];
    _pagingResult.Total=0;
    _pagingResult.Result=nil;
    
    [super viewDidLoad];     
	// Do any additional setup after loading the view, typically from a nib.
    if (_refreshHeaderView == nil) { 
        EGORefreshTableHeaderView *view1 = [[EGORefreshTableHeaderView alloc] initWithFrame:CGRectMake(0.0f, 0.0f - self.tableView.bounds.size.height, self.view.frame.size.width, self.tableView.bounds.size.height) tableView:_guestTableView];
        view1.delegate = self; 
        [self.guestTableView addSubview:view1]; 
        _refreshHeaderView = view1; 
    }
    [_refreshHeaderView egoInitLoading:self.guestTableView];
}

- (void)viewDidUnload
{
    [self setGuestTableView:nil];
    [super viewDidUnload];
    _pagingResult=nil;
    request=nil;
    _schParams=nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark – 
#pragma mark onClick 
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{ 
    isFlage=!isFlage; 
    [super.navigationController setNavigationBarHidden:isFlage animated:TRUE];
    [super.navigationController setToolbarHidden:isFlage animated:TRUE];     
} 
#pragma mark – 
#pragma mark UITableView 
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView { 
    return 1;
} 
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section { 
    NSInteger count=_pagingResult.Result!=nil?_pagingResult.Result.count:0;    
    tableView.separatorStyle =count>0?UITableViewCellSeparatorStyleSingleLine:UITableViewCellSeparatorStyleNone;
    return count; 
} 
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath { 
    static NSString *GuestTableCellIdentifier=@"GuestTableCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:GuestTableCellIdentifier]; 
    if (cell==nil) { 
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle 
                                      reuseIdentifier:GuestTableCellIdentifier]; 
    } 
    //表格设计 
    NSUInteger row = [indexPath row];
    NSDictionary *rowData = [_pagingResult.Result objectAtIndex:row];
    UILabel *nameLabel = (UILabel *)[cell viewWithTag:kNameValueTag];
    nameLabel.text = [rowData objectForKey:@"GuestName_en_us"];
    return cell; 
} 
/*
 -(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath 
 { 
 return 40; 
 }
 */
#pragma mark – 
#pragma mark Data Source Loading / Reloading Methods

- (void)reloadTableViewDataSource:(FuncBlock) onCompleted{ 
    NSLog(@"==开始加载数据"); 
    _reloading = YES; 
    [self getGuest:_refreshHeaderView.isTopRefresh onCompleted:onCompleted];
}

- (void)doneLoadingTableViewData{ 
    NSLog(@"===加载完数据"); 
    _reloading = NO; 
    [_refreshHeaderView egoRefreshScrollViewDataSourceDidFinishedLoading:self.guestTableView]; 
} 
#pragma mark – 
#pragma mark UIScrollViewDelegate Methods 
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{    
    [_refreshHeaderView egoRefreshScrollViewDidScroll:scrollView]; 
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{ 
    [_refreshHeaderView egoRefreshScrollViewDidEndDragging:scrollView]; 
} 
#pragma mark – 
#pragma mark EGORefreshTableHeaderDelegate Methods 
- (void)egoRefreshTableHeaderDidTriggerRefresh:(EGORefreshTableHeaderView*)view{
    [self reloadTableViewDataSource:^{
        [self.guestTableView reloadData];
        [self performSelector:@selector(doneLoadingTableViewData) withObject:nil]; 
    }];     
}

- (BOOL)egoRefreshTableHeaderDataSourceIsLoading:(EGORefreshTableHeaderView*)view{
    return _reloading; 
} 

- (NSDate*)egoRefreshTableHeaderDataSourceLastUpdated:(EGORefreshTableHeaderView*)view{
    return [NSDate date];     
} 

- (CGFloat)egoContentViewHeight:(EGORefreshTableHeaderView*)view{
    CGFloat height=0;
    for(int i=0;i<self.tableView.numberOfSections;i++)
    {         
        NSInteger rows=[self.tableView numberOfRowsInSection:i];
        //rows=rows==0?5:rows;
        height+=self.tableView.rowHeight*rows;
    } 
    return  height;
}

#pragma mark Private Function

-(void)getGuest:(BOOL) refresh onCompleted: (FuncBlock) onCompleted{
    BOOL isAppend;
    if(refresh){
        _schParams.PagingInfo.PageIndex=1;
        isAppend=NO;
    }
    else{
        _schParams.PagingInfo.PageIndex++;
        isAppend=YES;
        if (_schParams.PagingInfo.PageIndex>_schParams.PagingInfo.PageSize) {
            onCompleted();
            return;
        }
    }
    NSLog(@"%d",_schParams.PagingInfo.PageIndex);
    request = [RequestManager getGuestList:_schParams async:YES funCompleted:^(RequestResult *result) {
        if(result.success){            
            MarryPagingResult *tempPagingResult=[[MarryPagingResult alloc] initWithResult:result.extraData pagingInfo:_schParams.PagingInfo];
            if(isAppend){               
                NSMutableArray *guestList=[[NSMutableArray alloc] initWithArray:_pagingResult.Result];
                [guestList addObjectsFromArray:tempPagingResult.Result];
                _pagingResult.Result=guestList;
                _pagingResult.Total=tempPagingResult.Total;
                _pagingResult.PagingInfo=tempPagingResult.PagingInfo;
            }
            else
            {
                _pagingResult=tempPagingResult;
            }
            NSLog(@"%d",_pagingResult.PagingInfo.PageIndex);
            if(_pagingResult==nil)
            {
                [UIHelper showAlert:NSLocalizedString(@"Fail to load guest list", @"") message:@"数据解析有误！" delegate:nil];
                onCompleted();
            }
            else{                
                if(_pagingResult.PageNum==_pagingResult.PagingInfo.PageIndex){
                    _refreshHeaderView.hasMoreData=NO;
                }
                else{
                    _refreshHeaderView.hasMoreData=YES;
                }
                onCompleted();
            }
        }
        else
        {
            [UIHelper showAlert:@"更新数据失败" message:result.errorMsg delegate:nil];
            onCompleted();
        }
    }];   
}
@end
