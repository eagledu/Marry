//  Copyright (C) 2011 by Greg Koreman
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.

#import <UIKit/UIKit.h>

/////
// Example Usage:
//  AlertView* view = [[AlertView alloc] initWithTitle:@"My Title" message:@"Hello World!"];
//  [view addButtonWithTitle:@"Ok" block:[[^(AlertView* a, NSInteger i){/*DO SOMETHING*/} copy] autorelease] ];
//  [view addButtonWithTitle:@"Cancel" block:[[^(AlertView* a, NSInteger i){/*DO SOMETHING*/} copy] autorelease]];
//  [view show];
//  [view release];

@class AlertView;

@interface AlertView : UIAlertView<UIAlertViewDelegate>
{
    NSMutableArray* buttonCallbackArray;
    
    void(^cancel)(AlertView* alertView);
    void(^willPresent)(AlertView*);
    void(^didPresent)(AlertView*);
    void(^willDismiss)(AlertView*, NSInteger);
    void(^didDismiss)(AlertView*, NSInteger);
}

-(id)initWithTitle:(NSString*)title message:(NSString*)msg;
-(void)dealloc;

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
-(void)alertViewCancel:(UIAlertView *)alertView;
-(void)willPresentAlertView:(UIAlertView *)alertView;
-(void)didPresentAlertView:(UIAlertView *)alertView;
-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex;
-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex;

-(void)addButtonWithTitle:(NSString*)title block:(void(^)(AlertView*, NSInteger))block;

-(void)setAlertViewCancelBlock:(void(^)(AlertView*))block;
-(void)setWillPresentAlertViewBlock:(void(^)(AlertView*))block;
-(void)setDidPresentAlertViewBlock:(void(^)(AlertView*))block;
-(void)setAlertViewWillDismissWithButtonIndexBlock:(void(^)(AlertView*, NSInteger))block;
-(void)setAlertViewDidDismissWithButtonIndexBlock:(void(^)(AlertView*, NSInteger))block;

@end