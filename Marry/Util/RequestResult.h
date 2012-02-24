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
}

@property(nonatomic) BOOL success;
@property(nonatomic,strong) NSError *error;
@property(nonatomic,strong) NSString *errorMsg;
@property(nonatomic,strong) id extraData;
-(id)init:(BOOL) success error:(NSError *)err errorMsg:(NSString*) errMsg extraData:(id) extra;
@end
