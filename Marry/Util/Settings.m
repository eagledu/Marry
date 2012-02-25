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
@synthesize definitionInstance;

-(id)init
{
    if(self=[super init]){
        configInstance=[[Config alloc] init];
        definitionInstance=[[Definition alloc] init];
    }
    return self;
}
+(Definition*) definition
{
    return  [Settings instance].definitionInstance;
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
