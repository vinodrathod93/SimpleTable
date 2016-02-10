//
//  NSString+Validation.m
//  MindnWellness
//
//  Created by Vinod Rathod on 04/02/16.
//
//

#import "NSString+Validation.h"

@implementation NSString (Validation)


- (BOOL)isValidEmail {
    NSString *regex = @"[^@]+@[A-Za-z0-9.-]+\\.[A-Za-z]+";
    NSPredicate *emailPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [emailPredicate evaluateWithObject:self];
}

- (BOOL)isValidCity {
    return (self.length >= 2);
}

- (BOOL)isValidName {
    return (self.length >= 1);
}

@end
