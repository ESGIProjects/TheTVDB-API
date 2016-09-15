//
//  TVShowListViewControllerTableViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 12/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "TVShowListViewControllerTableViewController.h"
#import "TVDBApi.h"
#import "NameCell.h"

@interface TVShowListViewControllerTableViewController () {
    NSArray* tvShows;
    NSArray* tvGenre;
}

@end

@implementation TVShowListViewControllerTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tvShows = @[@"Friends",@"How I Met Your Mother",@"South Park",@"Suits"];
    tvGenre = @[@"Comedy",@"Comedy",@"Animation",@"Drama"];
    
    [self.tableView registerNib:[UINib nibWithNibName:@"NameCell" bundle:nil] forCellReuseIdentifier:@"NameCell"];
    
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
    NameCell* cell = [tableView dequeueReusableCellWithIdentifier:@"NameCell" forIndexPath:indexPath];
    NSLog(@"%@", cell);
    //cell.textLabel.text = tvShows[indexPath.row];
    cell.name.text = tvShows[indexPath.row];
    cell.genre.text = tvGenre[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}

@end
