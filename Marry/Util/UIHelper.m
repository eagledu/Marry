//
//  UIHelper.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIHelper.h"

@implementation UIHelper

+(void) showAlert:(NSString*) title message:(NSString*)msg delegate:(id)func{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                        message:msg
                                                       delegate:func 
                                              cancelButtonTitle:@"确认" 
                                              otherButtonTitles:nil];
    [alertView show];
}
@end
