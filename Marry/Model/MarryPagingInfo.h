//
//  MarryPagingInfo.h
//  Marry
//
//  Created by EagleDu on 12/3/18.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarryPagingInfo : NSObject

@property NSInteger PageSize;
@property NSInteger PageIndex;
@property (strong, nonatomic) NSString *SortBy;
@property BOOL Asc;

-(id) init:(NSInteger)pageSize pageIndex:(NSInteger)pageIndex
              sortBy:(NSString*)sortBy asc:(BOOL) asc;
@end
