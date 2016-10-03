//
//  ImageShowViewController.m
//  TheTVDB-ESGI
//
//  Created by Kévin Le on 02/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "ImageShowViewController.h"
#import "ImageCell.h"
#import "TVDBApi.h"

@interface ImageShowViewController () 

@end

@implementation ImageShowViewController
@synthesize tvShow = _tvShow;
@synthesize imagesShow = _imagesShow;

static NSString * const reuseIdentifier = @"Cell";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.collectionView registerClass:[ImageCell class] forCellWithReuseIdentifier:reuseIdentifier];
    
    [self updateCollectionView];
}

#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.imagesShow count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    UIImage* image = self.imagesShow[indexPath.item];
    cell.imageView.image = image;
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

#pragma mark - Helpers

- (void) updateCollectionView {
    [TVDBApi getImageQueryWithId:self.tvShow.showId completionHandler:^(NSData* data, NSURLResponse* response, NSError* error) {
        if (data) {
            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
            if (json) {
                NSDictionary* dataDict = json[@"data"];
                [dataDict enumerateKeysAndObjectsUsingBlock:^(id key, id value, BOOL *stop) {
                    NSLog(@"%@ - %d", (NSString*)key, [((NSNumber*)value) intValue]);
                }];
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

@end
