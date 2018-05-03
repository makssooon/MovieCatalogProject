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
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UILabel* directorLabel;
@property (weak, nonatomic) IBOutlet UILabel* genreLabel;
@property (weak, nonatomic) IBOutlet UILabel* releaseLabel;
@property (weak, nonatomic) IBOutlet UITextView* aboutTextView;
@property (weak, nonatomic) IBOutlet UILabel* createdDateLabel;

@end
