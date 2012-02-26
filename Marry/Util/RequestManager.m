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
@end
