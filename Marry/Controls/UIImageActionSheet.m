//
//  UIImageActionSheet.m
//  Marry
//
//  Created by EagleDu on 12/2/25.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "UIImageActionSheet.h"

@implementation UIImageActionSheet
-(id) initWithImage:(UIImage *)image 
              title:(NSString *)title
           delegate:(id <UIActionSheetDelegate>)delegate 
  cancelButtonTitle:(NSString *)cancelButtonTitle 
destructiveButtonTitle:(NSString *)destructiveButtonTitle 
  otherButtonTitles:(NSString *)otherButtonTitles{
    
    self = [super initWithTitle:title delegate:delegate 
              cancelButtonTitle:cancelButtonTitle 
         destructiveButtonTitle:destructiveButtonTitle 
              otherButtonTitles:otherButtonTitles,nil];
    
    if (self) {
        titleImage=image;
        UIImageView *imageView = [[UIImageView alloc] initWithImage:titleImage];
        imageView.frame = CGRectZero;         
        // 
        for (UIView *subView in self.subviews){
            if (![subView isKindOfClass:[UILabel class]]) {
                [self insertSubview:imageView aboveSubview:subView];
                break;
            }
        }
    }
    return self;
}


- (CGFloat) maxLabelYCoordinate {
    // Determine maximum y-coordinate of labels
    CGFloat maxY = 0;
    for( UIView *view in self.subviews ){
        if([view isKindOfClass:[UILabel class]]) {
            CGRect viewFrame = [view frame];
            CGFloat lowerY = viewFrame.origin.y + viewFrame.size.height;
            if(lowerY > maxY)
                maxY = lowerY;
        }
    }
    return maxY;
}

-(void) layoutSubviews{
    [super layoutSubviews];
    CGRect frame = [self frame];
    CGFloat labelMaxY = [self maxLabelYCoordinate];    
    for(UIView *view in self.subviews){
        if (![view isKindOfClass:[UILabel class]]) {    
            if([view isKindOfClass:[UIImageView class]]){
                CGRect viewFrame = CGRectMake((320 - titleImage.size.width)/2, labelMaxY + 10,
                                              titleImage.size.width, titleImage.size.height);
                [view setFrame:viewFrame];
            } 
            else if(![view isKindOfClass:[UIImageView class]]) {
                CGRect viewFrame = [view frame];
                viewFrame.origin.y += titleImage.size.height-labelMaxY+15;
                [view setFrame:viewFrame];
            }
        }
    }
    
    frame.origin.y -= titleImage.size.height + 2.0;
    frame.size.height += titleImage.size.height + 2.0;
    [self setFrame:frame];
    
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code.
 }
 */

@end
