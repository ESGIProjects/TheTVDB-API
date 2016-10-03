//
//  TVShowListViewControllerTableViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "TVShowListViewController.h"
#import "TVShowDetailViewController.h"
#import "TVDBApi.h"
#import "TVShow.h"
#import "NameCell.h"

@interface TVShowListViewController ()
@property (nonatomic) IBInspectable NSString* fetchMode;
@end

@implementation TVShowListViewController
@synthesize tvShows = _tvShows;

- (void)viewDidLoad {
    [super viewDidLoad];
        
    [self.tableView registerNib:[UINib nibWithNibName:@"NameCell" bundle:nil] forCellReuseIdentifier:@"NameCell"];
    
    
    NSLog(@"%@", self.fetchMode);
    
    [self updateTableViewData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToTVShow"]) {
        NSIndexPath* indexPath = (NSIndexPath*)sender;
        TVShowDetailViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.tvShow = [self.tvShows objectAtIndex:indexPath.row];
    }
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tvShows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NameCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
    if (cell==nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"NameCell" owner:self options:nil] objectAtIndex:0];
    }
    
    TVShow* tvShow = [self.tvShows objectAtIndex:indexPath.row];
    
    cell.name.text = tvShow.name;
    cell.genre.text = [tvShow.genre componentsJoinedByString:@", "];
    cell.thumbnail.image = tvShow.thumbnail;
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 108;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"segueToTVShow" sender:indexPath];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - Helper

- (void)updateTableViewData {
    
    void (^lastUpdated)() = ^(NSData* data, NSURLResponse* response, NSError* error) {
        if (data) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (json) {
                NSMutableArray* idArray = [NSMutableArray new];
                
                for (NSDictionary* dictionnary in json[@"data"]) {
                    TVShow* tvShow = [[TVShow alloc] initWithId:dictionnary[@"id"]];
                    [idArray addObject:tvShow];
                }
                
                self.tvShows = idArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    
                    for (int i = 0; i < [self.tvShows count]; i++) {
                        [self updateCellAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                });
            }
            else {
                NSLog(@"%@", error.localizedDescription);
            }
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    };
    
    void (^favorites)() = ^(NSData* data, NSURLResponse* response, NSError* error) {
        if (data) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (json) {
                NSMutableArray* idArray = [NSMutableArray new];
                
                for (NSNumber* favorites in json[@"data"][@"favorites"]) {
                    TVShow* tvShow = [[TVShow alloc] initWithId:favorites];
                    [idArray addObject:tvShow];
                }
                
                self.tvShows = idArray;
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.tableView reloadData];
                    
                    for (int i = 0; i < [self.tvShows count]; i++) {
                        [self updateCellAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
                    }
                });
            }
            else {
                NSLog(@"%@", error.localizedDescription);
            }
        }
        else {
            NSLog(@"%@", error.localizedDescription);
        }
    };
    
    if ([self.fetchMode isEqualToString:@"lastUpdated"])
        [TVDBApi getLastUpdatedSeriesWithCompletion:lastUpdated];
    
    if ([self.fetchMode isEqualToString:@"favorites"])
        [TVDBApi getFavoritesWithCompletion:favorites];
}

- (void) updateCellAtIndexPath:(NSIndexPath*)indexPath {
    TVShow* tvShow = [self.tvShows objectAtIndex:indexPath.row];

    [tvShow updateWithCompletion:^(NSData* data, NSURLResponse* response, NSError* error) {
        NSDictionary* seriesData = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
        if (seriesData) {
            NSDictionary* series = [seriesData objectForKey:@"data"];
            if (series) {
                if ([[[series objectForKey:@"seriesName"] class] isSubclassOfClass:[NSString class]])
                    tvShow.name = [series objectForKey:@"seriesName"];
                
                if ([[[series objectForKey:@"overview"] class] isSubclassOfClass:[NSString class]])
                    tvShow.overview = [series objectForKey:@"overview"];
                
                if ([[[series objectForKey:@"genre"] class] isSubclassOfClass:[NSArray class]])
                    tvShow.genre = [series objectForKey:@"genre"];
                
                if ([[[series objectForKey:@"banner"] class] isSubclassOfClass:[NSString class]]) {
                    NSString* urlImage = [NSString stringWithFormat:@"https://thetvdb.com/banners/%@", series[@"banner"]];
                    NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlImage]];
                    
                    if (data != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIImage* image = [UIImage imageWithData:data];
                            tvShow.thumbnail = image;
                            
                        });
                    }
                }
            }
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView beginUpdates];
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
                [self.tableView endUpdates];
            });
        }
    }];
}

@end
