//
//  MovieViewController.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieData.h"
#import "AddEditMovieController.h"

@interface MovieViewController : UITableViewController <AddEditMovieDelegate>

@property (strong, nonatomic) id<AddEditMovieDelegate> movieCatalogController;

@property (assign, nonatomic) BOOL isEditable;
@property (strong, nonatomic) MovieData* movieData;

@end
