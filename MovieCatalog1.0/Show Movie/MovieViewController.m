//
//  MovieViewController.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "MovieViewController.h"

@interface MovieViewController ()

@end

@implementation MovieViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIBarButtonItem* editButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemEdit
                                                                                target:self
                                                                                action:@selector(editButtonClicked:)];
    self.navigationItem.rightBarButtonItem = editButton;
    [self setData:self.movieData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setData:(MovieData*)movieData {
    self.movieData = movieData;
    
    self.titleLabel.text = movieData.title;
    self.posterImageView.image = movieData.poster;
    self.directorLabel.text = movieData.director;
    self.genreLabel.text = movieData.genreString;
    NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"dd MMMM yyyy"];
    self.releaseLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:movieData.releaseDate]];
    self.aboutTextView.text = movieData.movieDescription;
    [dateFormatter setDateFormat:@"MMMM yyyy"];
    self.createdDateLabel.text = [NSString stringWithFormat:@"created on %@", [dateFormatter stringFromDate:movieData.creationDate]];
}

#pragma mark - Actions

- (IBAction)editButtonClicked:(UIBarButtonItem*)sender {
    AddEditMovieController* editMovieController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddMovieController"];
    editMovieController.isEdit = YES;
    editMovieController.editingMovieData = self.movieData;
    editMovieController.movieCatalogController = self;
    [self.navigationController pushViewController:editMovieController animated:YES];
}

#pragma mark - AddEditMovieDelegate

- (void)addMovieToCatalog:(MovieData *)movieData {
    [self.movieCatalogController addMovieToCatalog:movieData];
}

- (void)changeMovieData:(MovieData *)movieData toMovieData:(MovieData *)newMovieData {
    [self.movieCatalogController changeMovieData:movieData toMovieData:newMovieData];
    
    [self setData:newMovieData];
}

@end
