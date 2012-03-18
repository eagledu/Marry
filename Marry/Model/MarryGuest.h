//
//  GETGuest.h
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MarryModelBase.h"

@interface MarryGuest : MarryModelBase

@property (strong, nonatomic) NSString *BigDate;
@property (strong, nonatomic) NSString *GuestCode;
@property (strong, nonatomic) NSString *TitleCode;
@property (strong, nonatomic) NSString *CategoryCode;
@property (strong, nonatomic) NSString *GuestQueryWords;
@property (strong, nonatomic) NSString *GuestName_en_us;
@property (strong, nonatomic) NSString *GuestName_zh_tw;
@property (strong, nonatomic) NSNumber *GuestNameFormat;
@property (strong, nonatomic) NSString *GuestMobile;
@property (strong, nonatomic) NSString *GuestEmail;
@property (strong, nonatomic) NSNumber *GuestQuantity;
@property BOOL IsDeleted;
@property (strong, nonatomic) NSNumber *GuestAttended;
@property (strong, nonatomic)NSDate *CreateOn;
@property (strong, nonatomic) NSString *CreateBy;
@property (strong, nonatomic) NSDate *UpdateOn;
@property (strong, nonatomic) NSString *UpdateBy;

-(id)initWithBigDate:(NSString *) bigDate guestCode:(NSString *) guestCode titleCode:(NSString *) titleCode categoryCode:(NSString *)categoryCode guestQueryWords:(NSString *)guestQueryWords
     guestName_en_us:(NSString *)guestName_en_us
     guestName_zh_tw:(NSString *)guestName_zh_tw
     guestNameFormat:(NSNumber *)guestNameFormat
         guestMobile:(NSString *)guestMobile
          guestEmail:(NSString *)guestEmail
       guestQuantity:(NSNumber *)guestQuantity
           isDeleted:(BOOL)isDeleted
       guestAttended:(NSNumber *)guestAttended
            createOn:(NSDate *)createOn
            createBy:(NSString *)createBy
            updateOn:(NSDate *)updateOn
            updateBy:(NSString *)updateBy;
@end