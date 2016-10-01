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
@end

@implementation TVShowListViewController
@synthesize tvShows = _tvShows;

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.tvShows = [[NSMutableArray alloc] initWithArray:@[@"Friends",@"How I Met Your Mother",@"South Park",@"Suits",@"Simpsons"]];
    //self.tvGenre = [[NSMutableArray alloc] initWithArray:@[@"Comedy",@"Comedy",@"Animation",@"Drama",@"Comedy"]];
        
    [self.tableView registerNib:[UINib nibWithNibName:@"NameCell" bundle:nil] forCellReuseIdentifier:@"NameCell"];
    
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
    [TVDBApi getLastUpdatedSeriesWithCompletion: ^(NSData* data, NSURLResponse* response, NSError* error) {
        if (data) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (json) {
                NSMutableArray* idArray = [NSMutableArray new];
                
                NSLog(@"%@", json[@"data"]);
                
                for (NSDictionary* dictionnary in json[@"data"]) {
                    TVShow* tvShow = [[TVShow alloc] initWithId:dictionnary[@"id"]];
                    [idArray addObject:tvShow];
                }
                
                self.tvShows = idArray;
                
                NSLog(@"%@", self.tvShows);
                
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
    }];
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
                
                if ([[[series objectForKey:@"banner"] class] isSubclassOfClass:[NSArray class]]) {
                    NSString* urlImage = [NSString stringWithFormat:@"https://thetvdb.com/banners/%@", series[@"banner"]];
                    NSData* data = [[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:urlImage]];
                    
                    NSLog(@"%@", data);
                    if (data != nil) {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            UIImage* image = [UIImage imageWithData:data];
                            NameCell* cell = (NameCell*)[self tableView:self.tableView cellForRowAtIndexPath:indexPath];
                            cell.thumbnail.image =  image;
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
