//
//  RigisterationViewController.m
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "RigisterationViewController.h"
#import "EmailHelper.h"
#import "RequestManager.h"

@implementation RigisterationViewController
@synthesize txtEmail;
@synthesize txtPwd;
@synthesize txtGroomName;
@synthesize txtBrideName;
@synthesize txtBigDateName;
@synthesize btnReg;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */

/*
 // Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
 - (void)viewDidLoad
 {
 [super viewDidLoad];
 }
 */

- (void)viewDidUnload
{
    [self setTxtEmail:nil];
    [self setTxtPwd:nil];
    [self setTxtGroomName:nil];
    [self setTxtBrideName:nil];
    [self setTxtBigDateName:nil];
    [self setBtnReg:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma Regitster
- (IBAction)registerLoginAccount:(id)sender {
    if(![UIHelper validateTextFields:self])
    {
        return;
    }
    if(![EmailHelper isValidEmail:txtEmail.text])
    {
        [UIHelper showAlert:@"提示" message:@"无效的邮箱格式。" delegate:nil];
        [UIHelper setTextFieldErrorCss:txtEmail isError:YES];
        return;
    }
    else
    {
        [UIHelper setTextFieldErrorCss:txtEmail isError:NO];
    }
    UILoadingBox __block *msgBox=[[UILoadingBox alloc] initWithLoading:@"正在注册" showCloseImage:YES onClosed:^{
        if(request!=nil){
            [request cancel];
        }
    }];
    [msgBox showLoading];
    request = [RequestManager registerAccount:txtEmail.text password:txtPwd.text groomName:txtGroomName.text brideName:txtBrideName.text BigDateName:txtBigDateName.text funCompleted:^(RequestResult *result) {
        [msgBox hideLoading];
        if(result.success){
            [Settings instance].globalInstance.registeredEmail=txtEmail.text;
            AlertView *alert= [[AlertView alloc] initWithTitle:@"恭喜" message:@"成功注册了账号，立刻安排属于你们的大日子吧。"];
            [alert addButtonWithTitle:@"确定" block:[^(AlertView *view,NSInteger index){
                [self performSegueWithIdentifier:@"BackToLogin" sender:self];
                [self.navigationItem.backBarButtonItem action]; 
            } copy]];
            [alert show];
        }
        else
        {
            [UIHelper showAlert:@"提示" message:result.errorMsg delegate:nil];
        }
    }];    
}

#pragma Text input event
- (IBAction)didTextChanged:(id)sender {
    if(txtEmail.text.length!=0&&txtPwd.text.length!=0)
    {
        btnReg.tintColor=[UIColor colorWithRed:0.6 green:0.8 blue:0.5 alpha:0.5];
    }
    else
    {
        btnReg.tintColor=nil;
    }
}

- (IBAction)didTextEditEnd:(UITextField*)sender {
    
    [sender resignFirstResponder];
    [UIHelper validateTextFieldErrorCss:sender];
    [UIHelper alternateTextField:self];    
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{    
    //UITouch *touch = [[event allTouches] anyObject];
    for(UIView *view in self.view.subviews)
    {
        if([view isMemberOfClass:[UITextField class]])
        {
            [view resignFirstResponder];
        }
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
@end
