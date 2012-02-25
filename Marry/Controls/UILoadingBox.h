//
//  UILoadingBox.h
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

/*usage
UILoadingBox *loading=[[UILoadingBox alloc] initWithLoading:@"Loading..." showCloseImage:YES completed:^{[self loginButtonPressed:self];}];
[loading showLoading];
*/
#import <Foundation/Foundation.h>
#import "RequestHelper.h"

@interface UILoadingBox : UIAlertView
{
    UIActivityIndicatorView *activityView;  
    UIImageView *closeView;
    FuncBlock completedFunc;
}

-(id) initWithLoading:(NSString *)message showCloseImage:(BOOL) showClose onClosed:(FuncBlock) onCompleted;
-(void) showLoading;

@end

/* other method to show loading box
 UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 480)];
 [view setTag:103];
 [view setBackgroundColor:[UIColor blackColor]];
 [view setAlpha:0.8];
 [self.view addSubview:view];
 
 UIActivityIndicatorView *activityIndicator = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, 32.0f, 32.0f)];
 [activityIndicator setCenter:view.center];
 [activityIndicator setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
 [view addSubview:activityIndicator];
 [self.view addSubview:view];
 [activityIndicator startAnimating];
*/