//
//  DSPickerCountryController.h
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 21.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSPickerCountryControllerDelegate;

@interface DSPickerCountryController : UIViewController

@property (weak, nonatomic) id <DSPickerCountryControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIPickerView *countryPickerOutlet;

@end

@protocol DSPickerCountryControllerDelegate <NSObject>

- (void) didPushButtonWithCountry:(DSPickerCountryController*)countryController;

@end
