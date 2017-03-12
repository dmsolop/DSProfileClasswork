//
//  DSViewController.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 12.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSViewController.h"

@interface DSViewController ()


@end

@implementation DSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.firstNameOutlet.text = self.firstName;
    self.lastNameOutlet.text = self.lastName;
    self.ageOutlet.text = self.age;
    self.sexOutlet.text = self.sex;
    self.countryOutlet.text = self.country;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
