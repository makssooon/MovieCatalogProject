//
//  NSStringUsefullStuff.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 15.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "NSStringUsefullStuff.h"

@implementation NSString (UsefullStuff)

- (BOOL)isYear {
    BOOL result = [self isNumber];
    
    NSNumberFormatter* numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber* release = [numberFormatter numberFromString:self];
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy"];
    NSString *yearString = [dateFormatter stringFromDate:[NSDate date]];
    NSNumber* currentYear = [numberFormatter numberFromString:yearString];
    result = result && release.integerValue <= currentYear.integerValue;
    
    return result;
}

- (BOOL)isDateInFormat:(NSDateFormatter*)dateFormatter {
    NSDate* date = [dateFormatter dateFromString:self];
    if (date)
        return YES;
    else
        return NO;
}

- (BOOL)isNumber {
    NSCharacterSet* nonNumbers = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    NSArray* components = [self componentsSeparatedByCharactersInSet:nonNumbers];
    BOOL result = [components count] <= 1;
    
    return result;
}

- (BOOL)isMovieTitle {
    
    return ![self isEqualToString:@""];
}

- (BOOL)isDirector {
    
    return ![self isEqualToString:@""];
}

- (BOOL)isMovieGenre {
    
    return ![self isEqualToString:@""];
}

- (BOOL)isMovieRelease {
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    
    return ![self isEqualToString:@""] && [self isDateInFormat:dateFormatter];
}

- (BOOL)isMovieAbout {
    
    return ![self isEqualToString:@""] && [self rangeOfString:@"add movie description..." options:NSCaseInsensitiveSearch].location == NSNotFound;
}

@end
