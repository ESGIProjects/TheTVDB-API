//
//  TVShowListViewControllerTableViewController.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TVShowListViewController : UITableViewController {
    NSMutableArray* _tvShows;
}
@property(strong, nonatomic) NSMutableArray* tvShows;
@end
