//
//  Settings.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "Settings.h"

@implementation Settings

@synthesize configInstance;
@synthesize globalInstance;

-(id)init
{
    if(self=[super init]){
        configInstance=[[Config alloc] init];
        globalInstance=[[Global alloc] init];
    }
    return self;
}
+(Global*) global
{
    return  [Settings instance].globalInstance;
}
+(Config*) config
{
    return [Settings instance].configInstance;
}

+ (Settings *)instance  {
    static Settings *instance;    
    @synchronized(self) {
        if(!instance) {
            instance = [[Settings alloc] init];            
        }
    }    
    return instance;
}
@end
