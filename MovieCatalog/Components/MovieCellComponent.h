//
//  MovieCellComponent.h
//  MovieCatalog1.0
//
//  Created by Maksym Popovych on 13.04.2018.
//  Copyright © 2018 Maksym Popovych. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MovieData.h"

@interface MovieCellComponent : UITableViewCell

@property (strong, nonatomic) MovieData* movieData;
@property (weak, nonatomic) IBOutlet UILabel* titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView* posterImageView;

@end
