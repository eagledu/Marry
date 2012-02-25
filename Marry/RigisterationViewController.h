//
//  RigisterationViewController.h
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigisterationViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPwd;
@property (strong, nonatomic) IBOutlet UITextField *txtCroomName;
@property (strong, nonatomic) IBOutlet UITextField *txtBrideName;
@property (strong, nonatomic) IBOutlet UITextField *BigDateName;
@property (strong, nonatomic) IBOutlet UIButton *btnReg;
- (IBAction)registerLoginAccount:(id)sender;

@end
