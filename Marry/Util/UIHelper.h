//
//  UIHelper.h
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>

@interface UIHelper : NSObject
+(void) showAlert:(NSString*) title message:(NSString*)msg delegate:(id)func;
+ (void)setTextFieldErrorCss:(UITextField*)txtField isError:(BOOL)error;
+ (BOOL)validateTextFieldErrorCss:(UITextField*)txtField;
+(BOOL) alternateTextField:(UIViewController *)controller;
+(void) resignResponser:(UIViewController *)controller;
+(BOOL) validateTextFields:(UIViewController *)controller;
@end
