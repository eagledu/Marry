//
//  UILoadingBox.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UILoadingBox.h"
#import "RequestHelper.h"

@implementation UILoadingBox
-(id) initWithLoading:(NSString *)message showCloseImage:(BOOL) showClose onClosed:(FuncBlock) onCompleted
{
    self = [super initWithTitle:nil
                        message: message
                       delegate: self
              cancelButtonTitle: nil
              otherButtonTitles: nil];    
    
    if (self) {
        
        activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];        
        activityView.frame = CGRectMake(120.f, 48.0f, 36.0f, 36.0f);
        [self addSubview:activityView];  
        if(showClose)
        {
            completedFunc=onCompleted;        
            UIImage *closeImage=[UIImage imageNamed:@"close.png"];
            closeView = [[UIImageView alloc] initWithImage:closeImage];
            closeView.frame = CGRectMake(250.0f, 5.0f, 24.0f, 24.0f);
            [closeView setUserInteractionEnabled:YES];
            [self addSubview:closeView];
        }
    }
    return self;
}
-(void) showLoading{
    [activityView startAnimating];
    [self show];
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [super touchesBegan:touches withEvent:event];
    UITouch *touch = [[event allTouches] anyObject];
    if([touch view]==closeView){
        [self dismissWithClickedButtonIndex:0 animated:YES];
        if(completedFunc!=NULL)
            completedFunc(); 
    }
}

@end
