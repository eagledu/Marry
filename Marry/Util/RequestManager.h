//
//  RequestManager.h
//  Marry
//
//  Created by EagleDu on 12/2/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RequestHelper.h"

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

+(ASIHTTPRequest *) getListWithUrl:(NSString *) url async:(BOOL) async params:(NSDictionary *)params pageIndex:(NSInteger) pageIndex pageSize:(NSInteger) pageSize sortBy:(NSString *) sortBy asc:(BOOL) asc funCompleted: (FuncJsonResultBlock) onCompleted;

+(ASIHTTPRequest *) getGuestList:(NSString *)guestName async:(BOOL) async pageIndex:(NSInteger) pageIndex pageSize:(NSInteger) pageSize sortBy:(NSString *) sortBy asc:(BOOL)asc funCompleted: (FuncJsonResultBlock) onCompleted;
@end
