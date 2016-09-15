//
//  NameCell.m
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 14/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "NameCell.h"

@implementation NameCell

@synthesize name = _name;
@synthesize genre = _genre;
@synthesize thumbnail = _thumbnail;

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
