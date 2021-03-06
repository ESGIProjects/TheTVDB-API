//
//  CastingCell.m
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 15/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "CastingCell.h"

@implementation CastingCell

@synthesize name = _name;
@synthesize role = _role;
@synthesize thumbnail = _thumbnail;

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Round thumbnail
    [self.thumbnail.layer setCornerRadius:55.5];
    [self.thumbnail.layer setMasksToBounds:YES];
    [self.thumbnail setClipsToBounds:YES];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
