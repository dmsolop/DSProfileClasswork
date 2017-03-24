//
//  DSViewController.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 12.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSViewController.h"
#import "DSPerson.h"

@interface DSViewController ()


@end

@implementation DSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    DSPerson *person = [DSPerson singleTonePerson];
    self.firstNameOutlet.text = person.firstName;
    self.lastNameOutlet.text = person.lastName;
    self.ageOutlet.text = person.age;
    self.sexOutlet.text = person.sex;
    self.countryOutlet.text = person.country;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
