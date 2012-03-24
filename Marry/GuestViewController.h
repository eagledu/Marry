//
//  SecondViewController.h
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EGORefreshTableHeaderView.h"
#import "MarryPagingResult.h"
#import "MarryPagingSchParams.h"
#import "RequestManager.h"

#define kNameValueTag 1

@interface GuestViewController : UITableViewController  <EGORefreshTableHeaderDelegate, UITableViewDelegate, UITableViewDataSource>
{
    EGORefreshTableHeaderView *_refreshHeaderView;
	BOOL isFlage; 
	//  Reloading var should really be your tableviews datasource
	//  Putting it here for demo purposes 
	BOOL _reloading;
    MarryPagingResult *_pagingResult;
    ASIHTTPRequest *request;
    NSArray *_guestList;
    NSArray *_guestCategoryList;
    MarryPagingSchParams *_schParams;
}
@property (strong, nonatomic) IBOutlet UITableView *guestTableView;

- (void)reloadTableViewDataSource:(FuncBlock) onCompleted;
- (void)doneLoadingTableViewData;

@end
