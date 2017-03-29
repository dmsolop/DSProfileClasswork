//
//  DSPickerCountryController.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 21.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSPickerCountryController.h"

@interface DSPickerCountryController ()

@end

@implementation DSPickerCountryController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)acceptButton:(id)sender {
    [self.delegate didPushButtonWithCountry:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
