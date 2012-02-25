//
//  EmailHelper.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "EmailHelper.h"

@implementation EmailHelper

+(BOOL) isValidEmail:(NSString*)email
{
    NSString *emailRegEx = @"^\\w+((\\-\\w+)|(\\.\\w+))*@[A-Za-z0-9]+((\\.|\\-)[A-Za-z0-9]+)*.[A-Za-z0-9]+$";  
    
    NSPredicate *regExPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegEx];  
    
    return [regExPredicate evaluateWithObject:email];  
}
@end
