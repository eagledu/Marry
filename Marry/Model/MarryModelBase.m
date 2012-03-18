//
//  GetModelBase.m
//  Marry
//
//  Created by EagleDu on 12/3/17.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MarryModelBase.h"

@implementation MarryModelBase

-(NSDictionary *) reflection
{
    Class clazz = [self class];
    u_int count;
    
    Ivar* ivars = class_copyIvarList(clazz, &count);
    NSMutableArray* ivarArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* ivarName = ivar_getName(ivars[i]);
        [ivarArray addObject:[NSString  stringWithCString:ivarName encoding:NSUTF8StringEncoding]];
    }
    ivars=nil;
    
    objc_property_t* properties = class_copyPropertyList(clazz, &count);
    NSMutableArray* propertyArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        const char* propertyName = property_getName(properties[i]);
        [propertyArray addObject:[NSString  stringWithCString:propertyName encoding:NSUTF8StringEncoding]];
    }
    properties=nil;
    
    Method* methods = class_copyMethodList(clazz, &count);
    NSMutableArray* methodArray = [NSMutableArray arrayWithCapacity:count];
    for (int i = 0; i < count ; i++)
    {
        SEL selector = method_getName(methods[i]);
        const char* methodName = sel_getName(selector);
        [methodArray addObject:[NSString  stringWithCString:methodName encoding:NSUTF8StringEncoding]];
    }
    methods=nil;
    
    NSDictionary* classDump = [NSDictionary dictionaryWithObjectsAndKeys:
                               ivarArray, @"ivars",
                               propertyArray, @"properties",
                               methodArray, @"methods",
                               nil];
    
    return  classDump;
}

-(NSDictionary *) toParams
{
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    NSDictionary *relections=[self reflection];
    NSArray * properties= [relections objectForKey:@"properties"];
    if(properties!=nil)
    {
        for(NSString *p in properties)
        {
            NSString *getMethodName=[NSString stringWithFormat:@"get%@",[self getPascalStyle:p]];
            if([self respondsToSelector:@selector(getMethodName)])
            {
                [params setObject:[self performSelector:@selector(getMethodName)] forKey:p] ;    
            }
        }
    }
    return params;
}

-(NSString *) getPascalStyle:(NSString *)par
{
    if (par!=nil) {
        return [NSString stringWithFormat:@"%@%@",[par substringToIndex:0],[par substringFromIndex:1]];
    }
    else{
        return nil;
    }
}

-(id) initWithJsonResult:(id)result
{
    self=[super init];
    if(self)
    {
        NSDictionary *relections=[self reflection];
        NSArray * properties= [relections objectForKey:@"properties"];
        if(properties!=nil)
        {
            for(NSString *p in properties)
            {
                NSString *setMethodName=[NSString stringWithFormat:@"set%@",[self getPascalStyle:p]];
                NSDictionary *dic=result;
                id val=[dic valueForKey:p];
                if([self respondsToSelector:@selector(setMethodName)])
                {                
                    [self performSelector:@selector(setMethodName) withObject:val] ;    
                }
            }
        }
    }
    return  self;
}
@end
