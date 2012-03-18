//
//  GetPagingResult.h
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MarryPagingResult : NSObject

@property (strong, nonatomic) NSArray *Result;
@property NSInteger Total;

-(id) initWithResult:(NSDictionary *)result;
@end
