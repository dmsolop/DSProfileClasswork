//
//  DSPerson.h
//  DSProfileClasswork
//
//  Created by ios on 13.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DSPerson : NSObject


@property (strong, nonatomic) NSString *firstName;
@property (strong, nonatomic) NSString *lastName;
@property (strong, nonatomic) NSString *country;
@property (strong, nonatomic) NSString *sex;
@property (assign, nonatomic) NSInteger age;
@property (strong, nonatomic) NSDate *dateOfBirth;

@end
