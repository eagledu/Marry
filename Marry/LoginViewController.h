//
//  LoginViewControl.h
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController{
    BOOL isRunning;
    ASIHTTPRequest *request;
    BOOL isRemem;
}
@property (strong, nonatomic) IBOutlet UIImageView *imgUnCheck;
@property (strong, nonatomic) IBOutlet UIImageView *imgCheck;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPwd;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *imgLoading;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnLogin;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *btnReg;


- (IBAction)loginButtonPressed:(id)sender;
- (IBAction)didTextEditEnd:(UITextField*)sender;
- (IBAction)didTextChanged:(id)sender;
-(void)Login:(id)sender;
-(void)CancelLogin:(id)sender;
@end
