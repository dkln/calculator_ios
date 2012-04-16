//
//  CALCCalculator.m
//  Calculator
//
//  Created by D Lawson on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CALCCalculator.h"

@interface CALCCalculator()
@property (nonatomic, strong) NSMutableArray *actions;
@end

@implementation CALCCalculator

@synthesize actions = _actions;

- (NSMutableArray *)actions
{
    if(!_actions)
        _actions = [[NSMutableArray alloc] init];
    
    return _actions;
}

- (void)pushAction:(CALCAction *)action
{
    [self.actions addObject:action];
}

- (float)calculate
{
    float calculation = 0;
    CALCActionType operator;
    
    for(CALCAction *action in self.actions)
    {
        if(action.action == Store) {
            switch(operator) {
                case Plus:
                    calculation = calculation + action.number;
                    break;
                case Minus:
                    calculation = calculation - action.number;
                    break;
                case Multiply:
                    calculation = calculation * action.number;
                    break;
                case Fracture:
                    calculation = calculation / action.number;
                    break;
                default:
                    break;
            }
        } else {
            operator = action.action;
        }
    }
    
    return calculation;
}

- (void)clearActions
{
    [self.actions removeAllObjects];
    _actions = NULL;
}

@end