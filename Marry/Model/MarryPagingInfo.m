//
//  MarryPagingInfo.m
//  Marry
//
//  Created by EagleDu on 12/3/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarryPagingInfo.h"

@implementation MarryPagingInfo


@synthesize PageSize;
@synthesize PageIndex;
@synthesize SortBy;
@synthesize Asc;

-(id) init:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex
    sortBy:(NSString*)sortBy asc:(BOOL) asc
{
    self=[super init];
    if(self)
    {
        self.PageSize=pageSize;
        self.PageIndex=pageIndex;
        self.SortBy=sortBy;
        self.Asc=asc;
    }
    return self;
}
@end
