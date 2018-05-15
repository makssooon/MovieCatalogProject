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


@end
