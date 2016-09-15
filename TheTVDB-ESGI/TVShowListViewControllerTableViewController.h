//
//  TVShowListViewControllerTableViewController.h
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TVShowListViewControllerTableViewController : UITableViewController {
    NSMutableArray* _tvShows;
    NSMutableArray* _tvGenre;
}
@property(strong, nonatomic) NSMutableArray* tvShows;
@property(strong, nonatomic) NSMutableArray* tvGenre;

@end
