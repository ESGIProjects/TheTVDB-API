//
//  CastingTableViewController.m
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 15/09/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "CastingTableViewController.h"
#import "CastingCell.h"

@interface CastingTableViewController ()

@end

@implementation CastingTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"CastingCell" bundle:nil] forCellReuseIdentifier:@"CastingCell"];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CastingCell* cell = [tableView dequeueReusableCellWithIdentifier:@"CastingCell" forIndexPath:indexPath];
    cell.name.text = @"Onche Patrick Harris";
    cell.role.text = @"Harvey Stinson";
    cell.thumbnail.image = [UIImage imageNamed:@"Homer"];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 128;
}

@end
