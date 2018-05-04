//
//  MovieDataModel+CoreDataProperties.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 22.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//
//

#import "MovieDataModel+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface MovieDataModel (CoreDataProperties)

+ (NSFetchRequest<MovieDataModel *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *aboutString;
@property (nullable, nonatomic, copy) NSDate *createdDate;
@property (nullable, nonatomic, copy) NSString *genreString;
@property (nullable, nonatomic, retain) NSData *posterData;
@property (nullable, nonatomic, copy) NSDate *releaseDate;
@property (nullable, nonatomic, copy) NSString *titleString;
@property (nullable, nonatomic, copy) NSString *directorString;

@end

NS_ASSUME_NONNULL_END
