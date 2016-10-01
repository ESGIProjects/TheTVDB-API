//
//  ShowRatingViewController.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowDetailViewController.h"

@interface ShowRatingViewController : UIViewController{
    __weak TVShowDetailViewController* _delegate;
}
@property(weak, nonatomic) TVShowDetailViewController* delegate;
@end
