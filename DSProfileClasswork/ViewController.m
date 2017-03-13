//
//  ViewController.m
//  DSProfileClasswork
//
//  Created by ios on 06.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "ViewController.h"
#import "DSViewController.h"
#import "DSPerson.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISwitch *sexSwitchOutlet;
@property (weak, nonatomic) IBOutlet UIButton *printButtonOutlet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewConstraint;
@property (assign, nonatomic) const float initialValueBottomConstraint;
@property (weak, nonatomic) DSViewController *controller;
@end



@implementation ViewController

#pragma mark - InitializationView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNameField.textContentType = UITextContentTypeName;
    self.lastNameField.textContentType = UITextContentTypeFamilyName;
    self.countryField.textContentType = UITextContentTypeCountryName;
    self.initialValueBottomConstraint = self.bottomViewConstraint.constant;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self subscribToKeyboardNotifications];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.view becomeFirstResponder];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self unSubscribToKeyboardNotifications];
}

#pragma mark - Actions

- (IBAction)actionSex:(UISwitch *)sender {
    self.sexField.text = self.sexSwitchOutlet.on ? @"Man" : @"Women";
}

- (IBAction)actionButton:(UIButton *)sender {
    [self performSegueWithIdentifier:@"showUserInfo" sender:sender];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showUserInfo"]) {
       // self.controller = [segue destinationViewController];
        self.controller.firstName = self.firstNameField.text;
        self.controller.lastName = self.lastNameField.text;
        self.controller.age = self.ageField.text;
        self.controller.sex = self.sexField.text;
        self.controller.country = self.countryField.text;
    }
}

#pragma mark - Notifications

- (void) subscribToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidChange:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardDidHide:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

- (void) unSubscribToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
   }

- (void) keyboardDidChange:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey]CGRectValue];
    self.bottomViewConstraint.constant = keyboardFrame.size.height;
    [UIView animateWithDuration:duration animations:^{
        [self.view setNeedsDisplay];
    }];
}

- (void) keyboardDidHide:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    NSTimeInterval duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey]doubleValue];
    self.bottomViewConstraint.constant = self.initialValueBottomConstraint;
    [UIView animateWithDuration:duration animations:^{
        [self.view setNeedsDisplay];
    }];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return  YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField isEqual:self.firstNameField] ? [self.lastNameField becomeFirstResponder] :
    [textField isEqual:self.lastNameField] ? [self.ageField becomeFirstResponder] :
    [textField isEqual:self.ageField] ? [self.countryField becomeFirstResponder] :
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if ([textField isEqual:self.firstNameField] || [textField isEqual:self.lastNameField] || [textField isEqual:self.countryField]) {
        NSCharacterSet *validationSet = [[NSCharacterSet letterCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        if ([components count] > 1) return NO;
        NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return [resultString length] <= 30;
    } else {
        NSCharacterSet *validationSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
        NSArray *components = [string componentsSeparatedByCharactersInSet:validationSet];
        if ([components count] > 1) return NO;
        NSString *resultString = [textField.text stringByReplacingCharactersInRange:range withString:string];
        return [resultString length] <= 2;
    }
    return YES;
}

@end
