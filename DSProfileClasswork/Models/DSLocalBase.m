//
//  DSLocalBase.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 18.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSLocalBase.h"
#import "DSPerson.h"

@implementation DSLocalBase

- (instancetype)init
{
    self = [super init];
    if (self) {
        _listOfPersons = [NSMutableArray arrayWithCapacity:1];
    }
    return self;
}

+ (id)singleToneLocalBase {
    static DSLocalBase *base = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        base = [[DSLocalBase alloc]init];
    });
    return base;
}

- (void) addPersonToList {
    DSPerson *person = [DSPerson new];
    person.firstName = self.firstName;
    person.lastName = self.lastName;
    person.sex = self.sex;
    person.age = self.age;
    person.dateOfBirth = self.dateOfBirth;
    person.country = self.country;
    [self.listOfPersons addObject:person];
}

- (void) printBase {
    NSInteger index = 0;
    for (DSPerson *per in self.listOfPersons) {
        NSLog(@"Person %ld\nfirst name: %@\nlast anme: %@\nbirthday: %@\nage: %ld\nsex: %@\ncountry: %@", index, per.firstName, per.lastName, per.dateOfBirth, per.age, per.sex, per.country);
        index ++;
    }
}

@end
