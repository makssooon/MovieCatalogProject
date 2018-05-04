//
//  AddMovieController.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 14.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieData.h"
#import "NSStringUsefullStuff.h"

@protocol AddEditMovieDelegate

- (void)addMovieToCatalog:(MovieData*)movieData;
- (void)changeMovieData:(MovieData*)movieData toMovieData:(MovieData*)newMovieData;

@end

@interface AddEditMovieController : UITableViewController <UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UITextViewDelegate>

@property (assign, nonatomic) BOOL isEdit;
@property (strong, nonatomic) MovieData* editingMovieData;
@property (strong, nonatomic) id<AddEditMovieDelegate> movieCatalogController;

@property (weak, nonatomic) IBOutlet UITableViewCell* titleCell;
@property (weak, nonatomic) IBOutlet UITextField* titleTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell* posterCell;
@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;
@property (weak, nonatomic) IBOutlet UIButton* selectPosterButton;

@property (weak, nonatomic) IBOutlet UITableViewCell* directorCell;
@property (weak, nonatomic) IBOutlet UITextField* directorTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell* genreCell;
@property (weak, nonatomic) IBOutlet UITextField* genreTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell* releaseCell;
@property (weak, nonatomic) IBOutlet UITextField* releaseTextField;

@property (weak, nonatomic) IBOutlet UITableViewCell* aboutCell;
@property (weak, nonatomic) IBOutlet UITextView* aboutTextView;

@end
