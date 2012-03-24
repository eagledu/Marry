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

+(ASIHTTPRequest *) getListWithUrl:(NSString *) url byPost:(BOOL) byPost async:(BOOL) async params:(NSDictionary *)params pageIndex:(NSInteger) pageIndex pageSize:(NSInteger) pageSize sortBy:(NSString *) sortBy asc:(BOOL) asc funCompleted: (FuncJsonResultBlock) onCompleted
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
    if(byPost){
        if(async){
            return [RequestHelper postJsonInBackground:pars funCompleted:onCompleted]; 
        }
        else{
            return [RequestHelper postJsonSynchronous:pars funCompleted:onCompleted]; 
        }
    }
    else{
        if(async){
            return [RequestHelper getJsonInBackground:pars funCompleted:onCompleted]; 
        }
        else{
            return [RequestHelper getJsonSynchronous:pars funCompleted:onCompleted]; 
        }
    }
}

+(ASIHTTPRequest *) getListWithUrl:(NSString *) url byPost:(BOOL) byPost async:(BOOL) async params:(MarryPagingSchParams *)params funCompleted: (FuncJsonResultBlock) onCompleted
{
    return [RequestManager getListWithUrl:url byPost:byPost async:async params:params.SearchParams pageIndex:params.PagingInfo.PageIndex pageSize:params.PagingInfo.PageSize sortBy:params.PagingInfo.SortBy asc:params.PagingInfo.Asc funCompleted:onCompleted];
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

+(ASIHTTPRequest *) getGuestList:(MarryPagingSchParams*) params async:(BOOL) async funCompleted: (FuncJsonResultBlock) onCompleted
{    
    return [RequestManager getListWithUrl:@"http://gzuat.vicp.net/Wedding/App/Guest.ashx?operation=get"   byPost:YES async:async params:params funCompleted:onCompleted]; 
}
@end
