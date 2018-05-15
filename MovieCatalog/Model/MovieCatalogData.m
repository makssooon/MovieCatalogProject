//
//  MovieCatalogData.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 15.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "MovieCatalogData.h"
@interface MovieCatalogData ()

@end

@implementation MovieCatalogData

-(instancetype)init {
    self = [super init];
    if (self) {
        _userMoviesData = [NSMutableArray array];
        _worldTopRatedMoviesData = [NSMutableArray array];

        NSArray* result = [self movieDataModelsWithPredicate:nil];
        
        MovieData* movieData;
        
//        creating some movies to start with...
        movieData = [[MovieData alloc] init];
        movieData.poster = [UIImage imageNamed:@"Titanic"];
        movieData.title = @"Titanic";
        movieData.director = @"James Cameron";
        movieData.genreString = @"Drama, Romance";
        NSCalendar* calendar = [NSCalendar currentCalendar];
        NSDateComponents* components = [[NSDateComponents alloc] init];
        [components setDay:19];
        [components setMonth:12];
        [components setYear:1997];
        movieData.releaseDate = [calendar dateFromComponents:components];
        movieData.movieDescription = @"84 years later, a 100 year-old woman named Rose DeWitt Bukater tells the story to her granddaughter Lizzy Calvert, Brock Lovett, Lewis Bodine, Bobby Buell and Anatoly Mikailavich on the Keldysh about her life set in April 10th 1912, on a ship called Titanic when young Rose boards the departing ship with the upper-class passengers and her mother, Ruth DeWitt Bukater, and her fiancé, Caledon Hockley. Meanwhile, a drifter and artist named Jack Dawson and his best friend Fabrizio De Rossi win third-class tickets to the ship in a game. And she explains the whole story from departure until the death of Titanic on its first and last voyage April 15th, 1912 at 2:20 in the morning.";
        [self.worldTopRatedMoviesData addObject:movieData];
        
        movieData = [[MovieData alloc] init];
        movieData.poster = [UIImage imageNamed:@"Legend"];
        movieData.title = @"Legend";
        movieData.director = @"Brian Helgeland";
        movieData.genreString = @"Biography, Crime, Drama";
        [components setDay:9];
        [components setMonth:9];
        [components setYear:2015];
        movieData.releaseDate = [calendar dateFromComponents:components];
        movieData.movieDescription = @"The true story of London's most notorious gangsters, twins Reggie and Ronnie Kray. As the brothers rise through the criminal underworld, Ronnie advances the family business with violence and intimidation while Reggie struggles to go legitimate for local girl Frances Shea. In and out of prison, Ronnie's unpredictable tendencies and the slow disintegration of Reggie's marriage threaten to bring the brothers' empire tumbling to the ground.";
        [self.worldTopRatedMoviesData addObject:movieData];
        
        movieData = [[MovieData alloc] init];
        movieData.poster = [UIImage imageNamed:@"WhoAmI"];
        movieData.title = @"Who Am I";
        movieData.director = @"Baran bo Odar";
        movieData.genreString = @"Crime, Drama, Mystery";
        [components setDay:25];
        [components setMonth:9];
        [components setYear:2014];
        movieData.releaseDate = [calendar dateFromComponents:components];
        movieData.movieDescription = @"Benjamin, a young German computer whiz, is invited to join a subversive hacker group that wants to be noticed on the world's stage.";
        [self.worldTopRatedMoviesData addObject:movieData];
        
        movieData = [[MovieData alloc] init];
        movieData.poster = [UIImage imageNamed:@"TheGame"];
        movieData.title = @"The Game";
        movieData.director = @"David Fincher";
        movieData.genreString = @"Drama, Mystery, Thriller";
        [components setDay:12];
        [components setMonth:9];
        [components setYear:1997];
        movieData.releaseDate = [calendar dateFromComponents:components];
        movieData.movieDescription = @"Nicholas Van Orton is a very wealthy San Francisco banker, but he is an absolute loner, even spending his birthday alone. In the year of his 48th birthday (the age his father committed suicide) his brother Conrad, who has gone long ago and surrendered to addictions of all kinds, suddenly returns and gives Nicholas a card giving him entry to unusual entertainment provided by something called Consumer Recreation Services (CRS). Giving in to curiosity, Nicholas visits CRS and all kinds of weird and bad things start to happen to him.";
        [self.worldTopRatedMoviesData addObject:movieData];
        
//        filling movies data from core data...
        for (MovieDataModel* movieDataModel in result) {
            movieData = [[MovieData alloc] initWithCreationDate:movieDataModel.createdDate];
            movieData.poster = [UIImage imageWithData:movieDataModel.posterData];
            movieData.title = movieDataModel.titleString;
            movieData.director = movieDataModel.directorString;
            movieData.genreString = movieDataModel.genreString;
            movieData.releaseDate = movieDataModel.releaseDate;
            movieData.movieDescription = movieDataModel.aboutString;
            [self.userMoviesData addObject:movieData];
        }
    }
    
    return self;
}

- (MovieDataModel*)movieDataModelWithMovieData:(MovieData*)movieData {
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"createdDate = %@", movieData.creationDate];
    
    NSArray* result = [self movieDataModelsWithPredicate:predicate];
    
    return [result lastObject];
}

- (NSArray*)movieDataModelsWithPredicate:(NSPredicate*)predicate {
    NSFetchRequest* request = [[NSFetchRequest alloc] init];
    NSSortDescriptor* sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"createdDate" ascending:NO];
    NSEntityDescription* description = [NSEntityDescription entityForName:@"MovieDataModel" inManagedObjectContext:self.persistentContainer.viewContext];
    [request setEntity:description];
    [request setSortDescriptors:@[sortDescriptor]];
    if (predicate)
        [request setPredicate:predicate];
    
    NSError* error = nil;
    NSArray* result = [self.persistentContainer.viewContext executeFetchRequest:request error:&error];
    
    return result;
}

- (void)addMovieData:(MovieData*)movieData {
    [self.userMoviesData insertObject:movieData atIndex:0];
    
    MovieDataModel* movieDataModel = [NSEntityDescription insertNewObjectForEntityForName:@"MovieDataModel" inManagedObjectContext:self.persistentContainer.viewContext];
    movieDataModel.titleString = movieData.title;
    movieDataModel.posterData = UIImagePNGRepresentation(movieData.poster);
    movieDataModel.directorString = movieData.director;
    movieDataModel.genreString = movieData.genreString;
    movieDataModel.releaseDate = movieData.releaseDate;
    movieDataModel.aboutString = movieData.movieDescription;
    movieDataModel.createdDate = movieData.creationDate;

    NSError* error = nil;
    [self.persistentContainer.viewContext save:&error];
}

- (void)changeMovieData:(MovieData*)movieData toMovieData:(MovieData*)newMovieData {
    NSInteger index = [self.userMoviesData indexOfObject:movieData];
    [self.userMoviesData replaceObjectAtIndex:index withObject:newMovieData];
    
    MovieDataModel* movieDataModel = [self movieDataModelWithMovieData:movieData];
    movieDataModel.titleString = newMovieData.title;
    movieDataModel.posterData = UIImagePNGRepresentation(newMovieData.poster);
    movieDataModel.directorString = newMovieData.director;
    movieDataModel.genreString = newMovieData.genreString;
    movieDataModel.releaseDate = newMovieData.releaseDate;
    movieDataModel.aboutString = newMovieData.movieDescription;
    movieDataModel.createdDate = newMovieData.creationDate;
    
    NSError* error = nil;
    [self.persistentContainer.viewContext save:&error];
}

- (void)deleteMovieData:(MovieData*)movieData {
    [self.userMoviesData removeObject:movieData];
    
    MovieDataModel* movieDataModel = [self movieDataModelWithMovieData:movieData];
    if (movieDataModel)
        [self.persistentContainer.viewContext deleteObject:movieDataModel];
    
    NSError* error = nil;
    [self.persistentContainer.viewContext save:&error];
}

- (NSArray*)getSearchBy:(MovieCatalogDataSearchType)type filter:(NSString *)filter {
    if ([filter isEqualToString:@""])
        return self.userMoviesData;
    
    NSMutableArray* result = [NSMutableArray array];
    for (MovieData* movieData in self.userMoviesData) {
        BOOL notFound = NO;
        switch (type) {
            case MovieCatalogDataSearchTypeByTitle: {
                if ([movieData.title rangeOfString:filter options:NSCaseInsensitiveSearch].location == NSNotFound)
                    notFound = YES;
                break;
            }
            case MovieCatalogDataSearchTypeByGenre: {
                if ([movieData.genreString rangeOfString:filter options:NSCaseInsensitiveSearch].location == NSNotFound)
                    notFound = YES;
                break;
            }
            case MovieCatalogDataSearchTypeByRelease: {
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"dd MMMM yyyy"];
                NSString* release = [dateFormatter stringFromDate:movieData.releaseDate];
                if ([release rangeOfString:filter options:NSCaseInsensitiveSearch].location == NSNotFound)
                    notFound = YES;
                break;
            }
            case MovieCatalogDataSearchTypeByAbout: {
                if ([movieData.movieDescription rangeOfString:filter options:NSCaseInsensitiveSearch].location == NSNotFound)
                    notFound = YES;
                break;
            }
            case MovieCatalogDataSearchTypeByCreatedDate: {
                NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
                [dateFormatter setDateFormat:@"MMMM yyyy"];
                NSString* created = [dateFormatter stringFromDate:movieData.creationDate];
                if ([created rangeOfString:filter options:NSCaseInsensitiveSearch].location == NSNotFound)
                    notFound = YES;
                break;
            }
            default:
                break;
        }
        
        if (!notFound)
            [result addObject:movieData];
    }
    
    return result;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"MovieCatalogDataModel"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
