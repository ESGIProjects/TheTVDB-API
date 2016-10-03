//
//  TVShowDetailViewController.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShow.h"

@interface TVShowDetailViewController : UITableViewController {
    TVShow* _tvShow;
    __weak UIViewController* _currentViewController;

}

@property(strong, nonatomic) TVShow* tvShow;
@property(weak, nonatomic) UIViewController* currentViewController;

-(void)showContainerWithIdentifier:(NSString*)identifier;
- (void)showImageController;

@end
