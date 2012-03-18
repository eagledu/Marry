//
//  SecondViewController.m
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "GuestViewController.h"
@interface GuestViewController (Private)
-(void)getGuest:(FuncBlock) onCompleted;
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
    _currentPageIndex=1;
    _pageSize=5;
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
    _myTableView=nil;
    _pagingResult=nil;
    request=nil;
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
    [self getGuest:onCompleted];
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

#pragma mark Private Function

-(void)getGuest:(FuncBlock) onCompleted{
    BOOL isAppend=FALSE;
    if(_needToRefresh){
        _currentPageIndex=1;
    }
    if(_pagingResult.Total!=0){
        NSInteger pageNum=_pagingResult.Total/_pageSize+(_pagingResult.Total%_pageSize==0?0:1);
        if(pageNum>_currentPageIndex){
            _currentPageIndex++;
            if(_needToRefresh)
                isAppend=NO;
            else
                isAppend=YES;
        }
        else{
            if(!_needToRefresh)
            {
                
            } 
        }
    }
    request = [RequestManager getGuestList:nil async:YES pageIndex:_currentPageIndex pageSize:_pageSize sortBy:nil asc:YES funCompleted:^(RequestResult *result) {
        if(result.success){
            
            MarryPagingResult *tempPagingResult=[[MarryPagingResult alloc] initWithResult:result.extraData];
            if(_pagingResult!=nil&&_pagingResult.Total!=0&&_pagingResult.Total!=tempPagingResult.Total){
                _needToRefresh=YES;
            }
            if(isAppend){               
                NSMutableArray *guestList=[[NSMutableArray alloc] initWithArray:_pagingResult.Result];
                [guestList addObjectsFromArray:tempPagingResult.Result];
                _pagingResult.Result=guestList;
                _pagingResult.Total=tempPagingResult.Total;
            }
            else
            {
                _pagingResult=tempPagingResult;
            }
            
            if(_pagingResult==nil)
            {
                [UIHelper showAlert:@"更新数据失败" message:@"数据解析有误！" delegate:nil];
                onCompleted();
            }
            else{
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
