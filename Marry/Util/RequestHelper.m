//
//  RequestHelper.m
//  Marry
//
//  Created by EagleDu on 12/2/23.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RequestHelper.h"

@implementation RequestHelper

#pragma mark - Get Request
+(ASIHTTPRequest*)grabInBackground:(NSString*)url funCompleted: (FuncResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    __block ASIHTTPRequest __weak *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request setTimeOutSeconds:2*60];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        // Use when fetching binary data
        //NSData *responseData = [request responseData];
       RequestResult *result=[[RequestResult alloc] init:YES error:nil errorMsg:nil extraData:responseString httpRequest:request];
        onCompleted(result);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        RequestResult *result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:nil httpRequest:request];
        onCompleted(result);
    }];
    [request startAsynchronous];  
    return request;
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
        result=[[RequestResult alloc] init:YES error:error errorMsg:nil extraData:responseStr httpRequest:request]; 
    }
    else{
        result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:responseStr httpRequest:request];
    }
    onCompleted(result);
}

+(ASIHTTPRequest*)getJsonInBackground:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    __block ASIHTTPRequest __weak *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request setTimeOutSeconds:2*60];
    [request setCompletionBlock:^{
        NSString *responseString = [request responseString];
        RequestResult *result=[RequestHelper parseResult:responseString error:nil httpRequest:request];
        onCompleted(result);
    }];
    [request setFailedBlock:^{
        NSError *error = [request error];
        RequestResult *result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:nil httpRequest:request];
        onCompleted(result);
    }];
    [request startAsynchronous]; 
    return request;
}

+ (void)getJsonSynchronous:(NSString*)url funCompleted: (FuncJsonResultBlock) onCompleted
{
    NSURL *urlObj = [NSURL URLWithString:url];
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:urlObj];
    [request startSynchronous];
    NSError *error = [request error];
    NSString *responseString;
    responseString = [request responseString];
    RequestResult *result=[RequestHelper parseResult:responseString error:error httpRequest:request];    
    onCompleted(result);
}
+(RequestResult*)parseResult:(NSString*)responseString error:(NSError *)error httpRequest:(ASIHTTPRequest*)request
{
    RequestResult *result=nil;
    if (!error) {
        SBJsonParser *parser=[[SBJsonParser alloc] init];        
        if(responseString==nil||[responseString length]==0){
            result=[[RequestResult alloc] init:NO error:nil errorMsg:@"No result return." extraData:responseString httpRequest:request];  
        }
        else
        {
            NSMutableDictionary *resultObj = (NSMutableDictionary*)[parser objectWithString:responseString];
            if(resultObj!=nil){
                NSString *errorStr= [resultObj objectForKey:@"Error"];
                if(errorStr==nil ||errorStr.length==0)
                {
                    result=[[RequestResult alloc] init:YES error:error errorMsg:nil extraData:responseString httpRequest:request];        
                }
                else{
                    result=[[RequestResult alloc] init:NO error:error errorMsg:errorStr extraData:resultObj httpRequest:request];        
                }
            }
            else
            {
                result=[[RequestResult alloc] init:NO error:error errorMsg:@"Json parse error." extraData:resultObj httpRequest:request];        
            } 
        }
    }
    else{
        result=[[RequestResult alloc] init:NO error:error errorMsg:[error localizedDescription] extraData:responseString httpRequest:request];
    }
    return result;
}
@end
