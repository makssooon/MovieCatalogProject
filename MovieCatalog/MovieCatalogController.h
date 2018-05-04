//
//  MovieCatalogController.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieCatalogData.h"
#import "MovieCellComponent.h"
#import "MovieViewController.h"
#import "AddEditMovieController.h"


@interface MovieCatalogController : UITableViewController <UITableViewDataSource, UITableViewDelegate, AddEditMovieDelegate, UISearchBarDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem* addButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem* searchButton;
@property (weak, nonatomic) IBOutlet UISearchBar* searchBar;

@end
