#import <Foundation/Foundation.h>


#pragma mark Types & Structures

/**
 @brief      Enum represent possible type of players.
 @discussion Basically describe from which side player is standing.
 */
typedef NS_ENUM(NSUInteger, BTBPlayer) {
    
    BTBFirstPlayer,
    BTBSecondPlayer,
};

/**
 @brief  Class which describe interface to manage turtle fight.
 
 @author Sergey Mamontov
 @copyright © 2009-2015 PubNub, Inc.
 */
@interface BTBSparController : NSObject


///------------------------------------------------
/// @name Gameplay
///------------------------------------------------

/**
 @brief  Specify player side.
 */
- (void)setPlayer:(BTBPlayer)player;

/**
 @brief  Players movement.
 */
- (void)hitUp;
- (void)hitDown;

#pragma mark -


@end
