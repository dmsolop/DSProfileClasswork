//
//  DSViewController.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 12.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSViewController.h"
#import "DSLocalBase.h"
#import "DSPerson.h"


@implementation DSViewController {
    DSLocalBase *base;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    base = [DSLocalBase singleToneLocalBase];
    self.firstNameOutlet.text = base.firstName;
    self.lastNameOutlet.text = base.lastName;
    self.ageOutlet.text = [NSString stringWithFormat:@"%ld", base.age];
    self.sexOutlet.text = base.sex;
    self.countryOutlet.text = base.country;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)printArrayOfPersons:(UIButton *)sender {
    [base printBase];
}

@end
