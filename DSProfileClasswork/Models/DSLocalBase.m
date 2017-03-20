//
//  DSLocalBase.m
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 18.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import "DSLocalBase.h"

@implementation DSLocalBase
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.person = [DSPerson new];
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

- (void) makeListOfPersons {
    [self.listOfPersons insertObject:self.person atIndex:0];
}

- (void) printBase {
    NSInteger index = 0;
    for (DSPerson *person in self.listOfPersons) {
        NSLog(@"Person %ld\nfirst name: %@\nlast anme: %@age: %@\nsex: %@\ncountry: %@", index, person.firstName, person.lastName, person.age, person.sex, person.country);
        index ++;
    }
}

@end
