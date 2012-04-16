//
//  CALCAction.h
//  Calculator
//
//  Created by D Lawson on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum CALCActionType
{
    Store,
    Plus,
    Minus,
    Fracture,
    Multiply
} CALCActionType;

@interface CALCAction : NSObject
@property (nonatomic) float number;
@property (nonatomic) CALCActionType action;
@end