//
//  MovieCellComponent.m
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import "MovieCellComponent.h"

@interface MovieCellComponent()

@end

@implementation MovieCellComponent

- (void)setMovieData:(MovieData*)movieData {
    _movieData = movieData;
    
    self.titleLabel.text = self.movieData.title;
    self.posterImageView.image = self.movieData.poster;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
