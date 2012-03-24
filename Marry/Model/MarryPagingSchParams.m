//
//  MarryPagingSchParams.m
//  Marry
//
//  Created by EagleDu on 12/3/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarryPagingSchParams.h"

@implementation MarryPagingSchParams

@synthesize SearchParams;
@synthesize  PagingInfo;

-(id) init:(NSDictionary *)searchParams pagingInfo:(MarryPagingInfo *)pagingInfo
{
    self=[super init];
    if(self)
    {
        self.SearchParams=searchParams;
        self.PagingInfo=pagingInfo;
    }
    return self;
}

@end
