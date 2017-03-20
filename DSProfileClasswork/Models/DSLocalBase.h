//
//  DSLocalBase.h
//  DSProfileClasswork
//
//  Created by Дмитрий Солоп on 18.03.17.
//  Copyright © 2017 ios. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DSPerson.h"

@interface DSLocalBase : NSObject

@property (weak, nonatomic) DSPerson *person;
@property (copy, nonatomic) NSMutableArray <DSPerson*> *listOfPersons;

+ (id)singleToneLocalBase;
- (void) makeListOfPersons;
- (void) printBase;

@end
