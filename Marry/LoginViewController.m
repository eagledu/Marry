//
//  LoginViewControl.m
//  Marry
//
//  Created by EagleDu on 12/2/19.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "LoginViewController.h"
#import "RequestHelper.h"
#import <QuartzCore/QuartzCore.h>

@implementation LoginViewController

@synthesize txtEmail;
@synthesize txtPwd;
@synthesize jsonParser;
@synthesize asiRequest;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad]; 
    jsonParser=[[SBJsonParser alloc] init];
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


//Seft defined
- (IBAction)loginButtonPressed:(id)sender {
    if(txtEmail.text.length==0||txtPwd.text.length==0)
    {    
        return;
    }
    NSString *st=[NSString stringWithFormat:@"http://gzuat.vicp.net/Wedding/App/User.ashx?operation=login&email=%@&pwd=%@",txtEmail.text,txtPwd.text];
    txtEmail.enabled=false;
    txtPwd.enabled=false;
    [RequestHelper getJsonInBackground:st funCompleted:^(RequestResult *result) {
        if(result.success){            
                [self performSegueWithIdentifier:@"LoginToMenu" sender:self];
        }
        else
        {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"登陆失败" 
                                                                message:result.errorMsg 
                                                               delegate:nil 
                                                      cancelButtonTitle:@"确认" 
                                                      otherButtonTitles:nil];
            [alertView show];
        }
    }];    
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (IBAction)didTextEditEnd:(UITextField*)sender {
    [sender resignFirstResponder];
    if(txtPwd.text.length>0&&txtEmail.text.length>0){
        [self loginButtonPressed:self];
    }
    else if(sender==txtEmail&&(txtPwd.text ==nil||txtPwd.text.length==0)){
        [txtPwd becomeFirstResponder];
    } 
    else if(sender==txtPwd&&(txtEmail.text==nil||txtEmail.text.length==0)){
        [txtEmail becomeFirstResponder];
    }
}

- (IBAction)backgroundTap:(id)sender {
    [txtEmail resignFirstResponder];
    [txtPwd resignFirstResponder];
}

@end
