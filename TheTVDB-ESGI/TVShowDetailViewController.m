//
//  TVShowDetailViewController.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "TVShowDetailViewController.h"
#import "ShowDetailViewController.h"
#import "ShowRatingViewController.h"
#import "ImageShowViewController.h"

@interface TVShowDetailViewController ()
@property (weak, nonatomic) IBOutlet UIView *containerView;
@end

@implementation TVShowDetailViewController
@synthesize tvShow = _tvShow;
@synthesize currentViewController = _currentViewController;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.tvShow.name;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    [self showContainerWithIdentifier:@"showDetail"];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"segueToImage"]) {
        ImageShowViewController* destinationViewController = segue.destinationViewController;
        destinationViewController.tvShow = self.tvShow;
    }
}

- (IBAction)castButton:(id)sender {
    
}

#pragma mark - Container switching

-(void)addSubview:(UIView*)subView toParentView:(UIView*)parentView {
    [parentView addSubview:subView];
    [subView sizeToFit];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[subView]|" options:0 metrics:0 views:@{@"subView":subView}]];
    [parentView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[subView]|" options:0 metrics:0 views:@{@"subView":subView}]];
}

-(void)cycleFromViewController:(UIViewController*)oldViewController toViewController:(UIViewController*)newViewController {
    // Supprimer l'ancien VC
    [oldViewController willMoveToParentViewController:nil];
    
    // Ajouter le nouveau
    [self addChildViewController:newViewController];
    [self addSubview:newViewController.view toParentView:self.containerView];
    newViewController.view.alpha = 0;
    [newViewController.view layoutIfNeeded];
    
    // Animation
    
    [UIView animateWithDuration:0.5 animations:^{
        newViewController.view.alpha = 1;
        oldViewController.view.alpha = 0;
    }completion:^(BOOL finished) {
        [oldViewController.view removeFromSuperview];
        [oldViewController removeFromParentViewController];
        [newViewController didMoveToParentViewController:self];
    }];

}

#pragma mark - Delegate

- (void)showContainerWithIdentifier:(NSString*)identifier {
    UIViewController* newViewController = [self.storyboard instantiateViewControllerWithIdentifier:identifier];
    
    if ([identifier isEqualToString:@"showRating"])
        ((ShowRatingViewController*)newViewController).delegate = self;
    
    if ([identifier isEqualToString:@"showDetail"])
        ((ShowDetailViewController*)newViewController).delegate = self;
    
    newViewController.view.translatesAutoresizingMaskIntoConstraints = NO;
    
    if (self.currentViewController)
        [self cycleFromViewController:self.currentViewController toViewController:newViewController];
    else {
        [self addChildViewController:newViewController];
        [self addSubview:newViewController.view toParentView:self.containerView];
    }
    self.currentViewController = newViewController;
}

- (void)showImageController {
    [self performSegueWithIdentifier:@"segueToImage" sender:nil];
}

@end
