//
//  Definition.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Global.h"

@implementation Global

-(id)init
{
    if(self=[super init]){
 
    }
    return self;
}
@synthesize registeredEmail;
-(void) dealloc
{
    registeredEmail=nil;
}
@end
