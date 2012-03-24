//
//  GetPagingResult.m
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarryPagingResult.h"

@implementation MarryPagingResult

@synthesize Total;
@synthesize Result;
@synthesize PageNum;
@synthesize PagingInfo;

-(id) initWithResult:(NSDictionary *)result pagingInfo:(MarryPagingInfo *)pagingInfo
{
    self=[super init];
    if(self)
    {
        self.Result=[result valueForKey:@"Result"];
        NSNumber *k=[result valueForKey:@"Total"];
        self.Total= [k integerValue];
        self.PagingInfo=pagingInfo;
        self.PageNum=self.Total/pagingInfo.PageSize+(self.Total%pagingInfo.PageSize==0?0:1);
    }
    return self;
}
@end
