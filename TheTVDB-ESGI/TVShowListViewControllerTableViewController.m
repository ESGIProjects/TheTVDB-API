//
//  TVShowListViewControllerTableViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "TVShowListViewControllerTableViewController.h"

@interface TVShowListViewControllerTableViewController () {
    NSArray* tvShows;
}

@end

@implementation TVShowListViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tvShows = @[@"Friends",@"How I Met Your Mother",@"South Park"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [tvShows count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:@"tvShow" forIndexPath:indexPath];
    cell.textLabel.text = tvShows[indexPath.row];
    return cell;
}

@end
