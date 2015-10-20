/**
 @author Sergey Mamontov
 @copyright © 2009-2015 PubNub, Inc.
 */
#import "ViewController.h"
#import "BTBSparController.h"


#pragma mark Private interface declaration

@interface ViewController ()


#pragma mark - Properties

/**
 @brief  Stores reference on client which is used for battle.
 */
@property (nonatomic) IBOutlet BTBSparController *client;


#pragma mark - Handlers

/**
 @brief  Handle user switch between players.
 
 @param cnotrol Reference on control which has been tapped.
 */
- (IBAction)handlePlayerSwitch:(UISegmentedControl *)control;

/**
 @brief  Handle user tap on rise sword button.
 
 @param button Reference on button which has been tapped.
 */
- (IBAction)handleUpButtonTouch:(UIButton *)button;

/**
 @brief  Handle user tap on swing sword down button.
 
 @param button Reference on button which has been tapped.
 */
- (IBAction)handleDownButtonTouch:(UIButton *)button;

#pragma mark -


@end


#pragma mark - Interface implementation

@implementation ViewController


#pragma mark - Handlers

- (IBAction)handlePlayerSwitch:(UISegmentedControl *)control {
    
//    self.view.layer.shadowOffset
    [self.client setPlayer:control.selectedSegmentIndex];
}

- (IBAction)handleUpButtonTouch:(UIButton *)sender {
    
    [self.client hitUp];
}

- (IBAction)handleDownButtonTouch:(UIButton *)sender {
    
    [self.client hitDown];
}

@end
