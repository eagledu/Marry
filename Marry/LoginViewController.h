//
//  LoginViewControl.h
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBJson.h"
#import "ASIHTTPRequest.h"

@interface LoginViewController : UIViewController{
    SBJsonParser *jsonParser;
    ASIHTTPRequest *asiRequest;
}

@property(nonatomic,strong) SBJsonParser *jsonParser;
@property(nonatomic,strong) ASIHTTPRequest *asiRequest;

- (IBAction)loginButtonPressed:(id)sender;
-(void)grabURLInBackground:(NSString*)urlStr;
-(NSString*)grabURLSynchronous:(NSString*)urlStr;

@end
