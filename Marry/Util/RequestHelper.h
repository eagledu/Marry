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

+(ASIHTTPRequest*)grabInBackground:(NSString*)url funCompleted: (FuncResultBlock) onCompleted;
+(void)grabSynchronous:(NSString*)url funCompleted: (FuncResultBlock) onCompleted;

+(ASIHTTPRequest*)getJsonInBackground:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted;
+(void)getJsonSynchronous:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted;

+(RequestResult*)parseResult:(NSString*)result error:(NSError*)error httpRequest:(ASIHTTPRequest*)request;
@end
