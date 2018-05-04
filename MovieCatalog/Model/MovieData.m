//
//  MovieData.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "MovieData.h"

@implementation MovieData

- (instancetype)init {
    self = [self initWithCreationDate:[NSDate date]];
    
    return self;
}

- (instancetype)initWithCreationDate:(NSDate*)date {
    self = [super init];
    if (self) {
        _creationDate = date;
    }
    
    return self;
}

@end
