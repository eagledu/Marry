//
//  LoginViewControl.h
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    SBJsonParser *jsonParser;
    ASIHTTPRequest *asiRequest;
}
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPwd;


@property(nonatomic,strong) SBJsonParser *jsonParser;
@property(nonatomic,strong) ASIHTTPRequest *asiRequest;

- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)didTextEditEnd:(UITextField*)sender;
- (IBAction)backgroundTap:(id)sender;
@end
