#import "AlertView.h"

@implementation AlertView

-(id)initWithTitle:(NSString*)title message:(NSString*)msg
{
    self = [super initWithTitle:title message:msg delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    if( self )
    {
        self.delegate = self;
        buttonCallbackArray = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)dealloc
{
    cancel =nil;
    willPresent=nil;
    didPresent =nil;
    willDismiss=nil;
    didDismiss=nil;
    buttonCallbackArray=nil;
}

-(void)addButtonWithTitle:(NSString*)title block:(void(^)(AlertView*, NSInteger))block
{
    [self addButtonWithTitle:title];
    [buttonCallbackArray addObject:block];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
   void(^dxidDismiss)(AlertView*, NSInteger) = ((void(^)(AlertView*, NSInteger))[buttonCallbackArray objectAtIndex:buttonIndex]);
    dxidDismiss((AlertView*)alertView, buttonIndex);
    //((void(^)(AlertView*, NSInteger))[buttonCallbackArray objectAtIndex:buttonIndex])((AlertView*)alertView, buttonIndex);
}

-(void)alertViewCancel:(UIAlertView *)alertView
{
    if( cancel )
    {
        cancel((AlertView*)alertView);
    }
    else
    {
        [self dismissWithClickedButtonIndex:self.cancelButtonIndex animated:NO];
    }
}

-(void)willPresentAlertView:(UIAlertView *)alertView
{
    if( willPresent )
        willPresent((AlertView*)alertView);
}

-(void)didPresentAlertView:(UIAlertView *)alertView
{
    if( didPresent )
        didPresent((AlertView*)alertView);
}

-(void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if( willDismiss )
        willDismiss((AlertView*)alertView, buttonIndex);
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if( didDismiss )
        didDismiss((AlertView*)alertView, buttonIndex);
}

-(void)setAlertViewCancelBlock:(void(^)(AlertView*))block
{
    cancel = block;
}

-(void)setWillPresentAlertViewBlock:(void(^)(AlertView*))block
{
    willPresent = block;
}

-(void)setDidPresentAlertViewBlock:(void(^)(AlertView*))block
{
    didPresent = block;
}

-(void)setAlertViewWillDismissWithButtonIndexBlock:(void(^)(AlertView*, NSInteger))block
{
    willDismiss = block;
}

-(void)setAlertViewDidDismissWithButtonIndexBlock:(void(^)(AlertView*, NSInteger))block
{
    didDismiss = block;
}

@end