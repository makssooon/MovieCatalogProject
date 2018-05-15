//
//  MovieCatalogData.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 15.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MovieData.h"
#import "NSStringUsefullStuff.h"
#import <CoreData/CoreData.h>
#import "MovieDataModel+CoreDataClass.h"
#import "MovieDataModel+CoreDataProperties.h"

typedef NS_ENUM(NSInteger, MovieCatalogDataSearchType) {
    MovieCatalogDataSearchTypeByTitle       = 0,
    MovieCatalogDataSearchTypeByGenre       = 1,
    MovieCatalogDataSearchTypeByRelease     = 2,
    MovieCatalogDataSearchTypeByAbout       = 3,
    MovieCatalogDataSearchTypeByCreatedDate = 4
    
};

@interface MovieCatalogData : NSObject

@property (strong, nonatomic, readonly) NSMutableArray* userMoviesData;
@property (strong, nonatomic, readonly) NSMutableArray* worldTopRatedMoviesData;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;

- (void)addMovieData:(MovieData*)movieData;
- (void)changeMovieData:(MovieData*)movieData toMovieData:(MovieData*)newMovieData;
- (void)deleteMovieData:(MovieData*)movieData;
- (NSArray*)getSearchBy:(MovieCatalogDataSearchType)type filter:(NSString *)filter;

@end
