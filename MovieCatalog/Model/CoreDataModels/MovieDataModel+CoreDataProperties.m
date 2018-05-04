//
//  MovieDataModel+CoreDataProperties.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 22.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//
//

#import "MovieDataModel+CoreDataProperties.h"

@implementation MovieDataModel (CoreDataProperties)

+ (NSFetchRequest<MovieDataModel *> *)fetchRequest {
	return [NSFetchRequest fetchRequestWithEntityName:@"MovieDataModel"];
}

@dynamic aboutString;
@dynamic createdDate;
@dynamic genreString;
@dynamic posterData;
@dynamic releaseDate;
@dynamic titleString;
@dynamic directorString;

@end
