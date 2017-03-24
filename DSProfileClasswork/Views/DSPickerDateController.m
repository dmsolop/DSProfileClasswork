//
//  DSPickerDateController.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 21.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSPickerDateController.h"
//#import "ViewController.h"

@interface DSPickerDateController()
//@property (weak, nonatomic) ViewController *viewController;
@end

@implementation DSPickerDateController

- (void)viewDidLoad {
    [super viewDidLoad];
   // self.delegate = self.viewController;
}

- (IBAction)nextCliced:(id)sender {
    [self.delegate didPushButtonWithBirthday:self];
    NSLog(@"%@", self.datePicker.date);
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
