//
//  RequestHelper.h
//  Marry
//
//  Created by EagleDu on 12/2/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestResult.h"

#if NS_BLOCKS_AVAILABLE
typedef void (^FuncBlock)(void);
typedef void (^FuncHandlerBlock)(id sender,id args);
typedef void (^FuncResultBlock)(id result);
typedef void (^FuncJsonResultBlock)(RequestResult *result);
#endif

@interface RequestHelper : NSObject

+(void)grabInBackground:(NSString*)url funCompleted: (FuncResultBlock) onCompleted;
+(void)grabSynchronous:(NSString*)url funCompleted: (FuncResultBlock) onCompleted;

+(void)getJsonInBackground:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted;
+(void)getJsonSynchronous:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted;

+(RequestResult*)parseResult:(NSString*)result error:(NSError*)error;
@end
