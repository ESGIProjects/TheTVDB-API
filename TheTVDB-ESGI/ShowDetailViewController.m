//
//  ShowDetailViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "ShowDetailViewController.h"
#import "TVShowDetailViewController.h"

@interface ShowDetailViewController()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ShowDetailViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)favoriteButton:(UIButton*)sender {
    BOOL favorite = self.delegate.tvShow.favorite;
    
    if (favorite) {
        [sender setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
    }
    else {
        [sender setImage:[UIImage imageNamed:@"Star-Filled"] forState:UIControlStateNormal];
    }
    
    self.delegate.tvShow.favorite = !favorite;
    
    NSLog(@"Favorite");
}

- (IBAction)rateButton {
    [self.delegate showContainerWithIdentifier:@"showRating"];
    NSLog(@"Rate");
}

- (IBAction)imagesButton {
    NSLog(@"Images");
}

@end
