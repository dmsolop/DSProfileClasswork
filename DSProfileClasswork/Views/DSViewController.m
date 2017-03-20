//
//  DSViewController.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 12.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSViewController.h"
#import "DSViewControllerKB.h"
#import "DSLocalBase.h"
#import "DSPerson.h"


@implementation DSViewController {
    DSLocalBase *base;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    base = [DSLocalBase singleToneLocalBase];
    self.firstNameOutlet.text = base.listOfPersons[0].firstName;
    self.lastNameOutlet.text = base.listOfPersons[0].lastName;
    self.ageOutlet.text = base.listOfPersons[0].age;
    self.sexOutlet.text = base.listOfPersons[0].sex;
    self.countryOutlet.text = base.listOfPersons[0].country;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (IBAction)printArrayOfPersons:(UIButton *)sender {
    [base printBase];
}

@end
