//
//  NameCell.h
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 14/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *name;
@property (nonatomic, weak) IBOutlet UILabel *genre;
@property (nonatomic, weak) IBOutlet UIImageView *thumbnail;

@end
