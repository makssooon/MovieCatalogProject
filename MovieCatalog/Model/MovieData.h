//
//  MovieData.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MovieData : NSObject

@property (strong, nonatomic) NSString* title;
@property (strong, nonatomic) UIImage* poster;
@property (strong, nonatomic) NSString* director;
@property (strong, nonatomic) NSString* genreString;
@property (strong, nonatomic) NSDate* releaseDate;
@property (strong, nonatomic) NSString* movieDescription;
@property (strong, nonatomic, readonly) NSDate* creationDate;

- (instancetype)initWithCreationDate:(NSDate*)date;

@end
