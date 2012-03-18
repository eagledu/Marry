//
//  GetPagingResult.m
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarryPagingResult.h"

@implementation MarryPagingResult

@synthesize Result;
@synthesize Total;

-(id) initWithResult:(NSDictionary *)result
{
    self=[super init];
    if(self)
    {
        self.Result=[result valueForKey:@"Result"];
        NSNumber *k=[result valueForKey:@"Total"];
        self.Total= [k integerValue];
    }
    return self;
}
@end
