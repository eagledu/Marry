//
//  RequestManager.m
//  Marry
//
//  Created by EagleDu on 12/2/26.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*Login
 http://gzuat.vicp.net/Wedding/App/User.ashx?operation=login&email=wedding-app@qq.com&pwd=111111
 */
/*
 Rigister user sample
 http://gzuat.vicp.net/Wedding/App/User.ashx?operation=register&RG_LoginEmail=wedding@qq.com&RG_LoginPassword=111111&RG_CroomName=Andy&RG_BrideName=Cnady&RG_BigDateName=CAN%20Party
 */

#import "RequestManager.h"

@implementation RequestManager

-(id)init
{
    self=[super init];
    if(self)
    {
    }
    return  self;
}

-(void)dealloc
{
    
}

#pragma GetList

+(ASIHTTPRequest *) getListWithUrl:(NSString *) url async:(BOOL) async params:(NSDictionary *)params pageIndex:(NSInteger) pageIndex pageSize:(NSInteger) pageSize sortBy:(NSString *) sortBy asc:(BOOL) asc funCompleted: (FuncJsonResultBlock) onCompleted;
{    
    NSMutableString *pars=[[NSMutableString alloc] initWithString:url];
    [pars appendString:[NSString stringWithFormat:@"&IsAsc=%s",asc==YES?"1":"0"]];
    if (pageIndex>0) {
        [pars appendString:[NSString stringWithFormat:@"&PageIndex=%d",pageIndex]];
    }
    if(pageSize>0){
        [pars appendString:[NSString stringWithFormat:@"&PageSize=%d",pageSize]];
    }
    if(sortBy!=nil&&sortBy.length>0)
    {
        [pars appendString:[NSString stringWithFormat:@"&SortBy=%@",[RequestHelper encodeURIComponent:sortBy]]];
    } 
    if (params!=nil) {
        for (NSString *key in params.allKeys) {
            [pars appendString:[NSString stringWithFormat:@"&%@=%@",key,[RequestHelper
                                                                         encodeURIComponent:[params objectForKey:key]]]];            
        }
    }
    if(async){
        return [RequestHelper getJsonInBackground:pars funCompleted:onCompleted]; 
    }
    else{
        return [RequestHelper getJsonSynchronous:pars funCompleted:onCompleted]; 
    }
}

#pragma mark Login 

+(ASIHTTPRequest *) loginWithAccount:(NSString *)eamil password:(NSString *)password funCompleted: (FuncJsonResultBlock) onCompleted;
{    
    NSString *url=[NSString stringWithFormat:@"http://gzuat.vicp.net/Wedding/App/User.ashx?operation=login&email=%@&pwd=%@",[RequestHelper encodeURIComponent:eamil],[RequestHelper encodeURIComponent:password]];
    return [RequestHelper getJsonInBackground:url funCompleted:onCompleted]; 
}

+(ASIHTTPRequest *) registerAccount:(NSString *)email password:(NSString *)password
                          groomName:(NSString *)groomName
                          brideName:(NSString *) brideName
                        BigDateName:(NSString *) bigDateName
                       funCompleted: (FuncJsonResultBlock) onCompleted
{
    NSString *url=[NSString stringWithFormat:@"http://gzuat.vicp.net/Wedding/App/User.ashx?operation=register&RG_LoginEmail=%@&RG_LoginPassword=%@&RG_CroomName=%@&RG_BrideName=%@&RG_BigDateName=%@",[RequestHelper encodeURIComponent:email],[RequestHelper encodeURIComponent:password],[RequestHelper encodeURIComponent:groomName],[RequestHelper encodeURIComponent:brideName],[RequestHelper encodeURIComponent:bigDateName]];
    return [RequestHelper getJsonInBackground:url funCompleted:onCompleted]; 
}

#pragma mark Guest

+(ASIHTTPRequest *) getGuestList:(NSString *)guestName async:(BOOL) async pageIndex:(NSInteger) pageIndex pageSize:(NSInteger) pageSize sortBy:(NSString *) sortBy asc:(BOOL)asc funCompleted: (FuncJsonResultBlock) onCompleted;
{    
    NSDictionary *params=[NSDictionary dictionaryWithObjectsAndKeys:guestName, @"GuestSch_GuestName_en_us",nil];
    return [RequestManager getListWithUrl:@"http://gzuat.vicp.net/Wedding/App/Guest.ashx?operation=get"   async:async params:params pageIndex:pageIndex pageSize:pageSize sortBy:sortBy asc:asc funCompleted:onCompleted]; 
}
@end
