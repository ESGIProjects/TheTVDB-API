//
//  CastingCell.h
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 15/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CastingCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *name;
@property (weak, nonatomic) IBOutlet UILabel *role;
@property (weak, nonatomic) IBOutlet UIImageView *thumbnail;

@end
