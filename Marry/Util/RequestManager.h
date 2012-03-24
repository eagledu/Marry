//
//  RequestManager.h
//  Marry
//
//  Created by EagleDu on 12/2/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHelper.h"
#import "MarryPagingSchParams.h"
@interface RequestManager : NSObject
{
}

-(id)init;

+(ASIHTTPRequest *) loginWithAccount:(NSString *)eamil password:(NSString *)password funCompleted: (FuncJsonResultBlock) onCompleted;

+(ASIHTTPRequest *) registerAccount:(NSString *)eamil password:(NSString *)password
                              groomName:(NSString *)groomName
                          brideName:(NSString *) brideName
                        BigDateName:(NSString *) bigDateName
                       funCompleted: (FuncJsonResultBlock) onCompleted;

+(ASIHTTPRequest *) getListWithUrl:(NSString *) url byPost:(BOOL) byPost async:(BOOL) async params:(NSDictionary *)params pageIndex:(NSInteger) pageIndex pageSize:(NSInteger) pageSize sortBy:(NSString *) sortBy asc:(BOOL) asc funCompleted: (FuncJsonResultBlock) onCompleted;

+(ASIHTTPRequest *) getListWithUrl:(NSString *) url byPost:(BOOL) byPost async:(BOOL) async params:(MarryPagingSchParams *)params funCompleted: (FuncJsonResultBlock) onCompleted;

+(ASIHTTPRequest *) getGuestList:(MarryPagingSchParams*) params async:(BOOL) async funCompleted: (FuncJsonResultBlock) onCompleted;
@end
