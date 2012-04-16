//
//  CALCViewController.m
//  Calculator
//
//  Created by D Lawson on 4/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CALCViewController.h"
#import "CALCCalculator.h"

@interface CALCViewController ()
@property (strong, nonatomic) CALCCalculator *calculator;
@property (weak, nonatomic) IBOutlet UILabel *display;
@property BOOL clearDisplayAfterKeyPress;
@end

@implementation CALCViewController

@synthesize display;
@synthesize calculator = _calculator;
@synthesize clearDisplayAfterKeyPress;

- (CALCCalculator *)calculator
{
    if(!_calculator)
        _calculator = [[CALCCalculator alloc] init];
    
    return _calculator;
}

- (NSNumber *)getCurrentNumber
{
    if(!numberFormatter)
        numberFormatter = [[NSNumberFormatter alloc] init];
    
    return [numberFormatter numberFromString:display.text];   
}

- (void)appendDigit:(NSString *)digit
{
    display.text = [display.text stringByAppendingString:digit];    
}

- (void)reformatDisplay
{
    NSString *newDisplay = [[self getCurrentNumber] stringValue];
    display.text = newDisplay;
}

- (void)clearDisplay
{
    display.text = @"";
}

- (BOOL)hasDecimalSeperator
{
    return [display.text rangeOfString:@"."].location == NSNotFound;
}

- (void)checkDisplayStatus
{
    if(self.clearDisplayAfterKeyPress) {
        self.clearDisplayAfterKeyPress = false;
        [self clearDisplay];
    }
}

- (void)storeCurrentNumber
{
    CALCAction *storeAction = [[CALCAction alloc] init];
    
    storeAction.action = Store;
    storeAction.number = [[self getCurrentNumber] floatValue];      
        
    [self.calculator pushAction:storeAction];
}

- (IBAction)decimalSeperatorPressed
{
    [self checkDisplayStatus];
    
    if([self hasDecimalSeperator]) {
        [self appendDigit:@"."];    
    }    
}

- (IBAction)digitPressed:(UIButton *)sender
{
    [self checkDisplayStatus];
    
    [self appendDigit:sender.currentTitle];
    [self reformatDisplay];
}

- (IBAction)plusPressed:(id)sender
{       
    [self pushOperator:Plus];
}

- (IBAction)minusPressed:(id)sender
{       
    [self pushOperator:Minus];
}

- (IBAction)multiplyPressed:(id)sender
{       
    [self pushOperator:Multiply];
}

- (IBAction)fracturePressed:(id)sender
{       
    [self pushOperator:Fracture];
}

- (IBAction)calculateResultsPressed
{
    [self storeCurrentNumber];
    display.text = [NSString stringWithFormat:@"%.3f", [self.calculator calculate]];
    
    [self.calculator clearActions];

    self.clearDisplayAfterKeyPress = true;
}

- (void)pushOperator:(CALCActionType)action
{
    [self checkDisplayStatus];    
    [self storeCurrentNumber];
    
    CALCAction *calcAction = [[CALCAction alloc] init];    
    calcAction.action = action;           
    
    [self.calculator pushAction:calcAction];
    
    self.clearDisplayAfterKeyPress = true;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

@end
