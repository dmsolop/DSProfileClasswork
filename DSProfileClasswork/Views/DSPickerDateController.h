//
//  DSPickerDateController.h
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 21.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DSPickerDateControllerDelegate;

@interface DSPickerDateController : UIViewController

@property (weak, nonatomic) id <DSPickerDateControllerDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *close;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@protocol DSPickerDateControllerDelegate <NSObject>

- (void) didPushButtonWithBirthday:(DSPickerDateController*)dateController;

@end
