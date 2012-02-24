//
//  RequestHelper.m
//  Marry
//
//  Created by EagleDu on 12/2/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestHelper.h"

@implementation RequestHelper

+(void)grabInBackground:(NSString*)url funCompleted: (FuncResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    __block ASIHTTPRequest __weak *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request setTimeOutSeconds:2*60];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        // Use when fetching binary data
        //NSData *responseData = [request responseData];
       RequestResult *result=[[RequestResult alloc] init:YES error:nil errorMsg:nil extraData:responseString];
        onCompleted(result);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        RequestResult *result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:nil];
        onCompleted(result);
    }];
    [request startAsynchronous];    
}

+ (void)grabSynchronous:(NSString*)url funCompleted: (FuncResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *responseStr;
    RequestResult *result;
    if (!error) {
        responseStr = [request responseString];
        result=[[RequestResult alloc] init:YES error:error errorMsg:nil extraData:responseStr]; 
    }
    else{
        result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:responseStr];
    }
    onCompleted(result);
}

+(void)getJsonInBackground:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    __block ASIHTTPRequest __weak *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request setTimeOutSeconds:2*60];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        RequestResult *result=[RequestHelper parseResult:responseString error:nil];
        onCompleted(result);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        RequestResult *result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:nil];
        onCompleted(result);
    }];
    [request startAsynchronous]; 
}

+ (void)getJsonSynchronous:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *responseString;
    responseString = [request responseString];
    RequestResult *result=[RequestHelper parseResult:responseString error:error];
    onCompleted(result);                                  
}
+(RequestResult*)parseResult:(NSString*)responseString error:(NSError *)error
{
    RequestResult *result=nil;
    if (!error) {
        SBJsonParser *parser=[[SBJsonParser alloc] init];        
        if(responseString==nil||[responseString length]==0){
            result=[[RequestResult alloc] init:NO error:nil errorMsg:@"No result return." extraData:responseString];  
        }
        else
        {
            NSDictionary *resultObj = (NSDictionary*)[parser objectWithString:responseString];
            if(resultObj!=nil){
                NSString *error= [resultObj objectForKey:@"Error"];
                if(error==nil ||error.length==0)
                {
                    result=[[RequestResult alloc] init:YES error:nil errorMsg:nil extraData:responseString];        
                }
                else{
                    result=[[RequestResult alloc] init:NO error:nil errorMsg:error extraData:responseString];        
                }
            }
            else
            {
                result=[[RequestResult alloc] init:NO error:nil errorMsg:@"Json parse error." extraData:responseString];        
            } 
        }
        result=[[RequestResult alloc] init:YES error:error errorMsg:nil extraData:responseString]; 
    }
    else{
        result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:responseString];
    }
    return result;
}
@end
