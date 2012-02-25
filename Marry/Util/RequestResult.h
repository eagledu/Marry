//
//  RequestResult.h
//  Marry
//
//  Created by EagleDu on 12/2/24.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestResult : NSObject
{
    BOOL success;
    NSError *error;
    NSString *errorMsg;
    id extraData;
    ASIHTTPRequest *requestXHR;
}

@property(nonatomic) BOOL success;
@property(nonatomic,strong) NSError *error;
@property(nonatomic,strong) NSString *errorMsg;
@property(nonatomic,strong) id extraData;
@property(nonatomic,strong) ASIHTTPRequest *requestXHR;
-(id)init:(BOOL) isSuccess error:(NSError *)err errorMsg:(NSString*) errMsg extraData:(id) extra httpRequest:(ASIHTTPRequest*) request;
@end
