//
//  RequestResult.m
//  Marry
//
//  Created by EagleDu on 12/2/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestResult.h"

@implementation RequestResult
@synthesize success;
@synthesize error;
@synthesize errorMsg;
@synthesize extraData;

-(id)init:(BOOL) success error:(NSError *)err errorMsg:(NSString*) errMsg extraData:(id) extra
{
    if(self=[super init]){
        error=err;
        errorMsg=errMsg;
        error=err;
        extraData=extra;
    }
    return self;
}
@end
