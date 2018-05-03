//
//  AddMovieController.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 14.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "AddEditMovieController.h"

@interface AddEditMovieController ()

@property (strong, nonatomic) UIColor* errorCellColor;
@property (strong, nonatomic) UIColor* defaultCellColor;
@property (assign, nonatomic) BOOL isMovieDataReady;
@property (strong, nonatomic) NSDateFormatter* dateFormatter;
@property (strong, nonatomic) UIBarButtonItem* saveButton;
@property (strong, nonatomic) UIBarButtonItem* doneButton;

@end

@implementation AddEditMovieController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    creating date picker for release text field...
    self.dateFormatter = [[NSDateFormatter alloc] init];
    [self.dateFormatter setDateFormat:@"dd MMMM yyyy"];
    UIDatePicker* datePicker = [[UIDatePicker alloc] init];
    datePicker.datePickerMode = UIDatePickerModeDate;
    NSCalendar* calendar = [NSCalendar currentCalendar];
    NSDateComponents* components = [[NSDateComponents alloc] init];
    [components setDay:14];
    [components setMonth:10];
    [components setYear:1888];
    NSDate* firstMovieReleaseDate = [calendar dateFromComponents:components];
    datePicker.minimumDate = firstMovieReleaseDate;
    UIToolbar* keyboardToolBar = [[UIToolbar alloc] init];
    [keyboardToolBar sizeToFit];
    UIBarButtonItem* flexBarButton = [[UIBarButtonItem alloc]
                                      initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                      target:nil action:nil];
    UIBarButtonItem* nextButton = [[UIBarButtonItem alloc] initWithTitle:@"Next"
                                                                   style:UIBarButtonItemStyleDone
                                                                  target:self
                                                                  action:@selector(nextButtonClicked:)];
    keyboardToolBar.items = @[flexBarButton, nextButton];
    self.releaseTextField.inputAccessoryView = keyboardToolBar;
    [datePicker addTarget:self action:@selector(releaseDatePickerValueChanged:) forControlEvents:UIControlEventValueChanged];
    if (self.isEdit)
        datePicker.date = self.editingMovieData.releaseDate;
    [self.releaseTextField setInputView:datePicker];
    
//    filling text fields and image if needed...
    if (self.isEdit) {
        self.posterImageView.image = self.editingMovieData.poster;
        self.titleTextField.text = self.editingMovieData.title;
        self.directorTextField.text = self.editingMovieData.director;
        self.genreTextField.text = self.editingMovieData.genreString;
        self.releaseTextField.text = [self.dateFormatter stringFromDate:self.editingMovieData.releaseDate];
        self.aboutTextView.text = self.editingMovieData.movieDescription;
    }
    
//    some preparations...
    self.titleTextField.delegate = self;
    self.directorTextField.delegate = self;
    self.genreTextField.delegate = self;
    self.releaseTextField.delegate = self;
    self.aboutTextView.delegate = self;
    
    self.defaultCellColor = [UIColor whiteColor];
    self.errorCellColor = [UIColor colorWithRed:250.f green:0.f blue:0.f alpha:.3f];
    self.isMovieDataReady = NO;
    
    self.doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone
                                                                                target:self
                                                                                action:@selector(doneButtonClicked:)];
    self.saveButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                                                    target:self
                                                                    action:@selector(saveButtonClicked:)];
    self.navigationItem.rightBarButtonItem = self.saveButton;
    [self.selectPosterButton addTarget:self action:@selector(selectImageFromGalleryButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)closeKeyboard {
    if ([self.titleTextField isFirstResponder])
        [self.titleTextField resignFirstResponder];
    else if ([self.directorTextField isFirstResponder])
        [self.directorTextField resignFirstResponder];
    else if ([self.genreTextField isFirstResponder])
        [self.genreTextField resignFirstResponder];
    else if ([self.releaseTextField isFirstResponder])
        [self.releaseTextField resignFirstResponder];
    else if ([self.aboutTextView isFirstResponder])
        [self.aboutTextView resignFirstResponder];
}
                                   
#pragma mark - Actions

- (IBAction)doneButtonClicked:(UIBarButtonItem*)sender {
    [self closeKeyboard];
    
    self.navigationItem.rightBarButtonItem = self.saveButton;
}

- (IBAction)nextButtonClicked:(UIBarButtonItem*)sender {
    [self.directorTextField becomeFirstResponder];
}

- (IBAction)saveButtonClicked:(UIBarButtonItem*)sender {
    [self closeKeyboard];
    self.isMovieDataReady = YES;
    
//    ckecking for valid...
    if (!self.posterImageView.image) {
        self.isMovieDataReady = NO;
    }
    [self textFieldShouldEndEditing:self.titleTextField];
    [self textFieldShouldEndEditing:self.directorTextField];
    [self textFieldShouldEndEditing:self.genreTextField];
    [self textFieldShouldEndEditing:self.releaseTextField];
    [self textViewShouldEndEditing:self.aboutTextView];
    
    if (self.isMovieDataReady) {
        
//        creating new movie data...
        MovieData* movieData = [[MovieData alloc] init];
        movieData.title = self.titleTextField.text;
        movieData.poster = self.posterImageView.image;
        movieData.director = self.directorTextField.text;
        movieData.genreString = self.genreTextField.text;
        movieData.releaseDate = [self.dateFormatter dateFromString:self.releaseTextField.text];
        movieData.movieDescription = self.aboutTextView.text;
        
//        changing movie data...
        if (self.isEdit) {
            [self.movieCatalogController changeMovieData:self.editingMovieData toMovieData:movieData];
            [self.navigationController popViewControllerAnimated:YES];
        }
//        writing new movie data to core data...
        else {
            [self.movieCatalogController addMovieToCatalog:movieData];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

- (IBAction)selectImageFromGalleryButtonClicked:(UIButton*)sender {
    UIImagePickerController* pickerViewController = [[UIImagePickerController alloc] init];
    pickerViewController.allowsEditing = NO;
    pickerViewController.delegate = self;
    [pickerViewController setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self presentViewController:pickerViewController animated:YES completion:nil];
}

- (void)releaseDatePickerValueChanged:(UIDatePicker*)sender {
    self.releaseTextField.text = [self.dateFormatter stringFromDate:sender.date];
}

#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo {
    [self dismissViewControllerAnimated:picker completion:nil];
    self.posterImageView.image = image;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    self.navigationItem.rightBarButtonItem = self.doneButton;
    
    if ([textField isEqual:self.titleTextField])
        self.titleCell.backgroundColor = self.defaultCellColor;
    if ([textField isEqual:self.directorTextField])
        self.directorCell.backgroundColor = self.defaultCellColor;
    if ([textField isEqual:self.genreTextField])
        self.genreCell.backgroundColor = self.defaultCellColor;
    if ([textField isEqual:self.releaseTextField])
        self.releaseCell.backgroundColor = self.defaultCellColor;
    
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [textField isEqual:self.releaseTextField] ? NO : YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField isEqual:self.titleTextField])
        [self.genreTextField becomeFirstResponder];
    else if ([textField isEqual:self.genreTextField])
        [self.releaseTextField becomeFirstResponder];
    else if ([textField isEqual:self.releaseTextField])
        [self.directorTextField becomeFirstResponder];
    else if ([textField isEqual:self.directorTextField])
        [self.aboutTextView becomeFirstResponder];
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    if ([textField isEqual:self.titleTextField] && ![self.titleTextField.text isMovieTitle]) {
        self.isMovieDataReady = NO;
        [UIView animateWithDuration:.1f animations:^{
            self.titleCell.backgroundColor = self.errorCellColor;
        }];
    }
    else if ([textField isEqual:self.directorTextField] && ![self.directorTextField.text isDirector]) {
        self.isMovieDataReady = NO;
        [UIView animateWithDuration:.1f animations:^{
            self.directorCell.backgroundColor = self.errorCellColor;
        }];
    }
    else if ([textField isEqual:self.genreTextField] && ![self.genreTextField.text isMovieGenre]) {
        self.isMovieDataReady = NO;
        [UIView animateWithDuration:.1f animations:^{
            self.genreCell.backgroundColor = self.errorCellColor;
        }];
    }
    else if ([textField isEqual:self.releaseTextField] && ![self.releaseTextField.text isMovieRelease]) {
        self.isMovieDataReady = NO;
        [UIView animateWithDuration:.1f animations:^{
            self.releaseCell.backgroundColor = self.errorCellColor;
        }];
    }
    
    return YES;
}

#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.navigationItem.rightBarButtonItem = self.doneButton;
    self.aboutCell.backgroundColor = self.defaultCellColor;
    
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView {
    if ([self.aboutTextView.text isEqualToString:@""])
        NSLog(@"alalal");
    if (![self.aboutTextView.text isMovieAbout]) {
        self.isMovieDataReady = NO;
        [UIView animateWithDuration:.1f animations:^{
            self.aboutCell.backgroundColor = self.errorCellColor;
        }];
    }
    
    return YES;
}

@end
