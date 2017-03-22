//
//  ViewController.m
//  DSProfileClasswork
//
//  Created by ios on 06.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "ViewController.h"
#import "DSViewController.h"
#import "DSLocalBase.h"
#import "DSPickerDateController.h"
#import "DSPickerCountryController.h"

@interface ViewController ()
{
    UITextField *activeField;
    UIScrollView *scrollView;
}
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitchOutlet;

@end

@implementation ViewController{
    DSLocalBase *base;
}

#pragma mark - InitializationView

- (void)viewDidLoad {
    [super viewDidLoad];
    self.firstNameField.textContentType = UITextContentTypeName;
    self.lastNameField.textContentType = UITextContentTypeFamilyName;
    self.countryField.textContentType = UITextContentTypeCountryName;
    
    NSArray *arraySubviews = self.view.subviews;
    for (UIView *view in arraySubviews) {
        if ([view isKindOfClass:[UIScrollView class]]) {
            scrollView = (UIScrollView*)view;
            break;
        }
    }
    if (scrollView) {
        UIView *contentView = scrollView.subviews[0];
        CGRect frameView = [contentView frame];
        scrollView.contentSize = frameView.size;
        if ([contentView isKindOfClass:[UIControl class]]) {
            [(UIControl*)contentView addTarget:self action:@selector(touchFieldView:) forControlEvents:UIControlEventTouchDown];
        }
        NSArray *arraySubviewsOfContentView = contentView.subviews;
        for (id editOrNo in arraySubviewsOfContentView) {
            if ([editOrNo isKindOfClass:[UITextField class]]) {
                UITextField *tField = editOrNo;
                [tField setDelegate:self];
            }
        }
    }
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
    base = [DSLocalBase singleToneLocalBase];
    base.firstName = self.firstNameField.text;
    base.lastName = self.lastNameField.text;
    base.age = [self.ageField.text integerValue];
    base.sex = self.sexField.text;
    base.country = self.countryField.text;
    [base addPersonToList];
}

- (IBAction)ageFieldWillActive:(UITextField *)sender {
[self performSegueWithIdentifier:@"SeguDatePicker" sender:sender];
}


#pragma mark - Notifications

- (void) subscribToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self
                           selector:@selector(keyboarWasShown:)
                               name:UIKeyboardWillShowNotification
                             object:nil];
    [notificationCenter addObserver:self
                           selector:@selector(keyboardWillBeHidden:)
                               name:UIKeyboardWillHideNotification
                             object:nil];
}

- (void) unSubscribToKeyboardNotifications {
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter removeObserver:self];
}

- (void) keyboarWasShown:(NSNotification*)aNotification {
    NSDictionary *info = [aNotification userInfo];
    CGSize keyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height + 60, 0.0);
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin)){
        [scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return  YES;
}

- (void) textFieldDidBeginEditing:(UITextField *)textField {
    activeField = textField;
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField isEqual:self.firstNameField] ? [self.lastNameField becomeFirstResponder] :
    [textField isEqual:self.lastNameField] ? [self.ageField resignFirstResponder] :
   // [textField isEqual:self.ageField] ? [self.countryField becomeFirstResponder] :
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
        NSInteger ageRange = [resultString integerValue];
        if (ageRange < 0 || ageRange > 150 || [resultString length] > 3) return NO;
    }
    return YES;
}

- (IBAction)touchFieldView:(id)sender {
    if (activeField) [activeField resignFirstResponder];
}

#pragma mark - Input methods

- (BOOL)resignFirstResponder {
    
    return YES;
}

@end
