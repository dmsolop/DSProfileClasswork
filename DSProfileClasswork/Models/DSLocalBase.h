//
//  DSLocalBase.h
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 18.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@class DSPerson;
@interface DSLocalBase : NSObject

@property (copy, nonatomic) NSString *firstName;
@property (copy, nonatomic) NSString *lastName;
@property (copy, nonatomic) NSString *sex;
@property (copy, nonatomic) NSString *country;
@property (assign, nonatomic) NSInteger age;
@property (copy, nonatomic) NSDate *dateOfBirth;
@property (copy, nonatomic) NSMutableArray <DSPerson*> *listOfPersons;


+ (id)singleToneLocalBase;
- (void) addPersonToList;
- (void) printBase;

@end
