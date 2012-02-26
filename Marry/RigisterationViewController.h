//
//  RigisterationViewController.h
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RigisterationViewController : UIViewController
{
    ASIHTTPRequest *request;
}
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtPwd;
@property (strong, nonatomic) IBOutlet UITextField *txtGroomName;
@property (strong, nonatomic) IBOutlet UITextField *txtBrideName;
@property (strong, nonatomic) IBOutlet UITextField *txtBigDateName;
@property (strong, nonatomic) IBOutlet UIButton *btnReg;
- (IBAction)registerLoginAccount:(id)sender;
- (IBAction)didTextEditEnd:(UITextField*)sender;
- (IBAction)didTextChanged:(id)sender;
@end
