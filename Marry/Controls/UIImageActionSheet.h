//
//  UIImageActionSheet.h
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//
//Usage
#import <Foundation/Foundation.h>

@interface UIImageActionSheet : UIActionSheet {
    UIImage *titleImage;
    UIActivityIndicatorView *indicator;
}
-(id) initWithImage:(UIImage *)image 
              title:(NSString *)title 
           delegate:(id <UIActionSheetDelegate>)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
destructiveButtonTitle:(NSString *)destructiveButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles;

@end 

