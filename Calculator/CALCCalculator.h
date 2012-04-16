//
//  CALCCalculator.h
//  Calculator
//
//  Created by D Lawson on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CALCAction.h"

@interface CALCCalculator : NSObject
- (void)pushAction:(CALCAction *)action;
- (float)calculate;
- (void)clearActions;
@end
