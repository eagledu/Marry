//
//  GETGuest.m
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarryGuest.h"

@implementation MarryGuest

@synthesize  BigDate;
@synthesize  GuestCode;
@synthesize  TitleCode;
@synthesize  CategoryCode;
@synthesize  GuestQueryWords;
@synthesize  GuestName_en_us;
@synthesize  GuestName_zh_tw;
@synthesize  GuestNameFormat;
@synthesize  GuestMobile;
@synthesize  GuestEmail;
@synthesize  GuestQuantity;
@synthesize  IsDeleted;
@synthesize  GuestAttended;
@synthesize  CreateOn;
@synthesize  CreateBy;
@synthesize  UpdateOn;
@synthesize  UpdateBy;

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
            updateBy:(NSString *)updateBy
{
    self = [super init];
    if( self )
    {
        self.BigDate=bigDate;
        self.GuestCode=guestCode;
        self.TitleCode=titleCode;
        self.CategoryCode=categoryCode;
        self.GuestQueryWords=guestQueryWords;
        self.GuestName_en_us=guestName_en_us;
        self.GuestName_zh_tw=guestName_zh_tw;
        self.GuestNameFormat=guestNameFormat;
        self.GuestMobile=guestMobile;
        self.GuestEmail=guestEmail;
        self.GuestQuantity=guestQuantity;
        self.IsDeleted=isDeleted;
        self.GuestAttended=guestAttended;
        self.CreateOn=createOn;
        self.CreateBy=createBy;
        self.UpdateOn=updateOn;
        self.UpdateBy=updateBy;
    }
    return self;
}

@end
