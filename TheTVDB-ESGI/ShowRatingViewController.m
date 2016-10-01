//
//  ShowRatingView.m
//  TheTVDB-ESGI
//
//  Created by Jason Pierna on 01/10/2016.
//  Copyright © 2016 Jason Pierna. All rights reserved.
//

#import "ShowRatingViewController.h"
#import "TVShowDetailViewController.h"

@interface ShowRatingViewController() {
    NSArray* _pickerData;
    NSString* _selectedItem;
    
}
@property (weak, nonatomic) IBOutlet UIPickerView *ratePicker;
@end

@implementation ShowRatingViewController
@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _pickerData = @[
                    @"1",
                    @"2",
                    @"3",
                    @"4",
                    @"5",
                    @"6",
                    @"7",
                    @"8",
                    @"9",
                    @"10"
                    ];
    
    _selectedItem = [_pickerData firstObject];
    
    self.ratePicker.dataSource = self;
    self.ratePicker.delegate = self;
}

#pragma mark - Actions

- (IBAction)cancelButton {
    [self.delegate showContainerWithIdentifier:@"showDetail"];
}

- (IBAction)okButton {
    [self.delegate showContainerWithIdentifier:@"showDetail"];
}

#pragma mark - UIPickerViewDelegate

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    _selectedItem = _pickerData[row];
}

#pragma mark - UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return _pickerData.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return _pickerData[row];
}

@end
