//
//  GetModelBase.h
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface MarryModelBase : NSObject

-(NSDictionary *) toParams;
-(id) initWithJsonResult:(id)result;
-(NSDictionary *) reflection;
-(NSString *) getPascalStyle:(NSString *) par;
@end
