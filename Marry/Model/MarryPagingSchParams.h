//
//  MarryPagingSchParams.h
//  Marry
//
//  Created by EagleDu on 12/3/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarryPagingInfo.h"
@interface MarryPagingSchParams : NSObject

@property (nonatomic,retain) NSDictionary *SearchParams;
@property (nonatomic,retain) MarryPagingInfo *PagingInfo;

-(id) init:(NSDictionary *)searchParams pagingInfo:(MarryPagingInfo *)pagingInfo;
@end
