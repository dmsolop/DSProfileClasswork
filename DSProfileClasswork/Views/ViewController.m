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

static const CGFloat DSPickersDownPosition = 306.f;
static const CGFloat DSAnimationDuration = 0.5;

@interface ViewController (){
    UITextField *activeField;
    NSInteger fullAge;
}

@property (strong, nonatomic) NSDate *dateOfBirth;
@property (strong, nonatomic) NSArray *countriesArray;
@property (strong, nonatomic) NSString *selectedCountry;

@property (weak, nonatomic) IBOutlet UIView *countryPickerView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintCountryView;
@property (weak, nonatomic) IBOutlet UIPickerView *countryPickerOutlet;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePickerOutlet;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraintDateView;
@property (weak, nonatomic) IBOutlet UIView *datePickerView;
@property (weak, nonatomic) IBOutlet UISwitch *sexSwitchOutlet;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (strong, nonatomic) IBOutletCollection(UITextField) NSArray *textFields;

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
    
    self.bottomConstraintCountryView.constant = - DSPickersDownPosition;
    self.bottomConstraintDateView.constant = - DSPickersDownPosition;
    
    self.countriesArray = [NSLocale ISOCountryCodes];
    self.countryPickerOutlet.delegate = self;
    
    for (UITextField * textField in self.textFields){
        textField.delegate = self;
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
    base.sex = self.sexField.text;
    base.country = self.countryField.text;
    base.dateOfBirth = self.dateOfBirth;
    base.age = fullAge;
    [base addPersonToList];
}

- (IBAction)didPushButtonWithBirthday:(id)sender {
    
    self.dateOfBirth = self.datePickerOutlet.date;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear fromDate:self.dateOfBirth toDate:[NSDate date] options:0];
    NSDateFormatter *dateForm = [[NSDateFormatter alloc] init];
    [dateForm setDateFormat:@"dd MMMM yyyy"];
    self.ageField.text = [dateForm stringFromDate:self.dateOfBirth];
    fullAge = components.year;
    
    [self pickersHide];
}

- (IBAction)didPushButtonWithCountry:(id)sender {
    self.countryField.text = self.selectedCountry;
    [self pickersHide];
}

#pragma mark - NSNotificationCenter Methods

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
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
    
    CGRect aRect = self.view.frame;
    aRect.size.height -= keyboardSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin)){
        [self.scrollView scrollRectToVisible:activeField.frame animated:YES];
    }
}

- (void) keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.scrollView.contentInset = contentInsets;
    self.scrollView.scrollIndicatorInsets = contentInsets;
}

#pragma mark - UITextFieldDelegate Methods

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    activeField = textField;
    if ([textField isEqual:self.ageField] || [textField isEqual:self.countryField]) {
        [self pickersShow];
        [self.view endEditing:YES];
        return NO;
    }
    [self pickersHide];
    return YES;
}

- (void) textFieldDidEndEditing:(UITextField *)textField{
    activeField = nil;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField isEqual:self.firstNameField] ? [self.lastNameField becomeFirstResponder] :
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

#pragma mark - UIPickerViewDataSource Methods

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.countriesArray.count;
}

#pragma mark - UIPickerViewDelegate Methods

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countriesArray[row]];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    self.selectedCountry = [[NSLocale currentLocale] displayNameForKey:NSLocaleCountryCode value:self.countriesArray[row]];
}

#pragma mark - UIPickerViewShowHide Methods

- (void) pickersHide {
    self.bottomConstraintCountryView.constant = - DSPickersDownPosition;
    self.bottomConstraintDateView.constant = - DSPickersDownPosition;
    [UIView animateWithDuration:DSAnimationDuration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsZero;
        [self.view layoutIfNeeded];
    }];
}

- (void) pickersShow {
    [UIView animateWithDuration:DSAnimationDuration animations:^{
        self.scrollView.contentInset = UIEdgeInsetsMake(0, 0, DSPickersDownPosition - 100, 0);
        [self.scrollView scrollRectToVisible:CGRectMake(self.scrollView.contentSize.width - 1,
                                                        self.scrollView.contentSize.height - 1, 1, 1) animated:YES];
    }];
        [activeField isEqual:self.ageField] ?
    (self.bottomConstraintDateView.constant = 0,
     self.bottomConstraintCountryView.constant = - DSPickersDownPosition) :
    (self.bottomConstraintCountryView.constant = 0,
     self.bottomConstraintDateView.constant = - DSPickersDownPosition);
    
}

@end
