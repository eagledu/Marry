//
//  Settings.h
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Definition.h"
#import "Config.h"
@interface Settings : NSObject
{
    Definition *definitionInstance;
    Config *configInstance;
}

@property(nonatomic,strong) Definition *definitionInstance;
@property(nonatomic,strong) Config *configInstance;

+(Config*) config;
+(Definition*) definition;
+(Settings *) instance ;
@end
