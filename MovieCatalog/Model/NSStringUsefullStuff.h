//
//  NSStringUsefullStuff.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 15.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (UsefullStuff)

- (BOOL)isYear;
- (BOOL)isDateInFormat:(NSDateFormatter*)dateFormatter;
- (BOOL)isNumber;
- (BOOL)isMovieTitle;
- (BOOL)isDirector;
- (BOOL)isMovieGenre;
- (BOOL)isMovieRelease;
- (BOOL)isMovieAbout;

@end
