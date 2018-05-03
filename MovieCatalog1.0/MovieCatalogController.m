//
//  MovieCatalogController.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "MovieCatalogController.h"

@interface MovieCatalogController ()

@property (strong, nonatomic) MovieCatalogData* movieCatalogData;
@property (strong, nonatomic) NSArray* currentCatalog;
@property (strong, nonatomic) UIButton* upButton;
@property (assign, nonatomic) BOOL isSearching;

@end

@implementation MovieCatalogController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    creating model...
    self.movieCatalogData = [[MovieCatalogData alloc] init];
    self.currentCatalog = self.movieCatalogData.userMoviesData;
    
//    some preparatoins...
    self.isSearching = NO;
    self.addButton.target = self;
    self.addButton.action = @selector(addButtonClicked:);
    self.searchBar.delegate = self;
    self.searchButton.target = self;
    self.searchButton.action = @selector(searchButtonClicked:);
    
    self.upButton = [[UIButton alloc] initWithFrame:CGRectMake(0.f, 0.f, 50.f, 50.f)];
    [self.upButton setImage:[UIImage imageNamed:@"top"] forState:UIControlStateNormal];
    [self.upButton addTarget:self action:@selector(upButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    self.upButton.hidden = YES;
    [self.tableView addSubview:self.upButton];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    if (!animated)
        [self moveToFirstCell:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}

static float topBarHeight = 20.f;
- (void)moveToFirstCell:(BOOL)animated {
    [self.tableView setContentOffset:CGPointMake(0.f, self.searchBar.frame.origin.y + self.searchBar.frame.size.height - self.navigationController.navigationBar.frame.size.height - topBarHeight) animated:animated];
}

#pragma mark - Actions

- (IBAction)addButtonClicked:(UIBarButtonItem*)sender {
    AddEditMovieController* addMovieController = [self.storyboard instantiateViewControllerWithIdentifier:@"AddMovieController"];
    addMovieController.isEdit = NO;
    addMovieController.movieCatalogController = self;
    [self.navigationController pushViewController:addMovieController animated:YES];
}

- (IBAction)searchButtonClicked:(UIBarButtonItem*)sender {
    [self.tableView setContentOffset:CGPointMake(0.f, self.searchBar.frame.origin.y - self.navigationController.navigationBar.frame.size.height - topBarHeight) animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW,
                                 (int64_t)(0.3f * NSEC_PER_SEC)),
                   dispatch_get_main_queue(), ^{
                       [self.searchBar becomeFirstResponder];
    });
}

- (IBAction)upButtonClicked:(UIBarButtonItem*)sender {
    [self moveToFirstCell:YES];
}

#pragma mark - AddEditMovieDelegate

- (void)addMovieToCatalog:(MovieData *)movieData {
    [self.movieCatalogData addMovieData:movieData];
    [self.tableView reloadData];
}

- (void)changeMovieData:(MovieData*)movieData toMovieData:(MovieData*)newMovieData {
    [self.movieCatalogData changeMovieData:movieData toMovieData:newMovieData];
    [self.tableView reloadData];
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.isSearching)
        return 1;
    else
        return 2;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return @"Your Movies";
        case 1:
            return @"World Top Rated Movies";
        default:
            return @"Error";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return self.currentCatalog.count;
        case 1:
            return self.movieCatalogData.worldTopRatedMoviesData.count;
        default:
            return 0;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString* movieCellIdentifier = @"MovieCellComponent";

    MovieCellComponent* cell = [tableView dequeueReusableCellWithIdentifier:movieCellIdentifier];
    if (indexPath.section == 0)
        cell.movieData = [self.currentCatalog objectAtIndex:indexPath.row];
    else
        cell.movieData = [self.movieCatalogData.worldTopRatedMoviesData objectAtIndex:indexPath.row];
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 150.f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    MovieViewController* movieViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieViewController"];
    movieViewController.movieCatalogController = self;
    if (indexPath.section == 0) {
        movieViewController.movieData = [self.currentCatalog objectAtIndex:indexPath.row];
        movieViewController.isEditable = YES;
    }
    else {
        movieViewController.movieData = [self.movieCatalogData.worldTopRatedMoviesData objectAtIndex:indexPath.row];
        movieViewController.isEditable = NO;
    }
    [self.navigationController pushViewController:movieViewController animated:YES];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0)
        return YES;
    else
        return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1)
        return;
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        MovieData* movieDataToDelete = [self.currentCatalog objectAtIndex:indexPath.row];
        [self.movieCatalogData deleteMovieData:movieDataToDelete];
        
        [self.tableView beginUpdates];
        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        [self.tableView endUpdates];
    }
}

#pragma mark - UISearchBarDelegate

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar {
    [searchBar setShowsCancelButton:YES animated:YES];
    
    return YES;
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    if ([searchText isEqualToString:@""]) {
        self.currentCatalog = self.movieCatalogData.userMoviesData;
        self.isSearching = NO;
    }
    else {
        self.currentCatalog = [self.movieCatalogData getSearchBy:searchBar.selectedScopeButtonIndex filter:searchText];
        self.isSearching = YES;
    }
    [self.tableView reloadData];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
    [searchBar setShowsCancelButton:NO animated:YES];
    searchBar.text = @"";
    self.currentCatalog = self.movieCatalogData.userMoviesData;
    self.isSearching = NO;
    [self.tableView reloadData];
    [self moveToFirstCell:YES];
}

- (void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    self.currentCatalog = [self.movieCatalogData getSearchBy:selectedScope filter:searchBar.text];
    [self.tableView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (scrollView.contentOffset.y > 200)
        self.upButton.hidden = NO;
    else
        self.upButton.hidden = YES;
    
    CGPoint upButtonPos = CGPointMake(scrollView.contentOffset.x + scrollView.frame.size.width - self.upButton.frame.size.width, scrollView.contentOffset.y + scrollView.frame.size.height - self.upButton.frame.size.height);
    self.upButton.center = upButtonPos;
}

@end
