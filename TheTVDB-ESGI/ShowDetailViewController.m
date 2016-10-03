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
@property (weak, nonatomic) IBOutlet UITextView *overview;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ShowDetailViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureTVShow:self.delegate.tvShow];
}

- (IBAction)favoriteButton:(UIButton*)sender {
    BOOL favorite = NO;
    
    if (favorite) {
        [sender setImage:[UIImage imageNamed:@"Star"] forState:UIControlStateNormal];
    }
    else {
        [sender setImage:[UIImage imageNamed:@"Star-Filled"] forState:UIControlStateNormal];
    }
}

- (IBAction)rateButton {
    [self.delegate showContainerWithIdentifier:@"showRating"];
}

- (IBAction)imagesButton {
    
}

- (void)configureTVShow:(TVShow *)tvshow {
    NSLog(@"%@", tvshow);
    NSLog(@"%@", tvshow.overview);
    NSLog(@"%@", self.overview);
    NSLog(@"%@", self.overview.text);
    self.overview.text = tvshow.overview;
}

@end
