//
//  Settings.h
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Global.h"
#import "Config.h"
@interface Settings : NSObject
{
    Global *globalInstance;
    Config *configInstance;
}

@property(nonatomic,strong) Global *globalInstance;
@property(nonatomic,strong) Config *configInstance;

+(Config*) config;
+(Global*) global;
+(Settings *) instance ;
@end
