//
//  ShowRatingView.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "ShowRatingViewController.h"
#import "TVShowDetailViewController.h"

@interface ShowRatingViewController()
@property (weak, nonatomic) IBOutlet UIPickerView *ratePicker;
@end

@implementation ShowRatingViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)cancelButton {
    [self.delegate showContainerWithIdentifier:@"showDetail"];
}

- (IBAction)okButton {
    [self.delegate showContainerWithIdentifier:@"showDetail"];
}

@end
