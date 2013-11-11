//
//  UITextField+custom.m
//  trial1
//
//  Created by Arjun Odukathil on 19/10/12.
//  Copyright (c) 2012 arjun@ideaminetech.com. All rights reserved.
//

#import "UITextField+custom.h"

@implementation UITextField (custom)

-(BOOL)isemptystring
{
    NSString *check = [[NSString alloc]init];
    check = self.text;
    if ([check isEqualToString:@""]) {
        return YES;
    }
    else {
        return NO;
    }
    
}

-(BOOL)isvalidemail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"; 
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex]; 
    
    return [emailTest evaluateWithObject:self.text];
}

@end
