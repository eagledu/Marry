//
//  Config.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Config.h"

@implementation Config

-(id)init
{
    self=[super init];
    if(self)
    {
        self.requestTimeout=60;
    }
    return  self;
}

#pragma Property

@synthesize requestTimeout;

@end
