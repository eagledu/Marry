//
//  Definition.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Definition.h"

@implementation Definition

@synthesize loginXHR;

-(id)init
{
    if(self=[super init]){
        loginXHR = @"http://gzuat.vicp.net/Wedding/App/User.ashx?operation=login&email=%@&pwd=%@";
    }
    return self;
}

@end
