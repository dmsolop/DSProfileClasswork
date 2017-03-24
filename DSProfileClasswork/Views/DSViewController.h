//
//  DSViewController.h
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 12.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DSViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *firstNameOutlet;
@property (weak, nonatomic) IBOutlet UILabel *lastNameOutlet;
@property (weak, nonatomic) IBOutlet UILabel *ageOutlet;
@property (weak, nonatomic) IBOutlet UILabel *sexOutlet;
@property (weak, nonatomic) IBOutlet UILabel *countryOutlet;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirth;

@end
