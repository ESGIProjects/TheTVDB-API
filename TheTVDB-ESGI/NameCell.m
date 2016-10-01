//
//  NameCell.m
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 14/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "NameCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation NameCell

@synthesize name = _name;
@synthesize genre = _genre;
@synthesize thumbnail = _thumbnail;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Set dark overlay on thumbnail
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = self.thumbnail.bounds;
    
    UIColor* topColor = [UIColor colorWithWhite:0 alpha:0.25];
    UIColor* bottomColor = [UIColor colorWithWhite:0.667 alpha:0.25];
    
    gradient.colors = @[
                        (id)[topColor CGColor],
                        (id)[bottomColor CGColor],
                        ];
    [self.thumbnail.layer addSublayer:gradient];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
