//
//  ShowDetailViewController.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVShowDetailViewController.h"

@interface ShowDetailViewController : UIViewController{
    __weak TVShowDetailViewController* _delegate;
}
@property(weak, nonatomic) TVShowDetailViewController* delegate;

-(void)configureTVShow:(TVShow*)tvshow;
@end
