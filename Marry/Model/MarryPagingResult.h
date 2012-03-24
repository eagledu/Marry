//
//  GetPagingResult.h
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarryPagingInfo.h"

@interface MarryPagingResult : NSObject

@property (strong, nonatomic) NSArray *Result;
@property NSInteger Total;
@property (strong,nonatomic) MarryPagingInfo *PagingInfo;
@property NSInteger PageNum;

-(id) initWithResult:(NSDictionary *)result pagingInfo:(MarryPagingInfo *)pagingInfo;
@end
