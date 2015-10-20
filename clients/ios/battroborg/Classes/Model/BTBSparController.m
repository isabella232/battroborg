/**
 @author Sergey Mamontov
 @copyright © 2009-2015 PubNub, Inc.
 */
#import "BTBSparController.h"
#import <PubNub/PubNub.h>
#import <UIKit/UIKit.h>


#pragma mark Static

/**
 @brief  Stores reference on keys which is used to connect to the application.
 */
static NSString * const kBTBApplicationSubscribeKey = @"demo-36";
static NSString * const kBTBApplicationPublishKey = @"demo-36";

/**
 @brief  Stores name of the channel on which battle will be.
 */
static NSString * const kBTBApplicationChannel = @"battroborg";


#pragma mark - Private interface declaration

@interface BTBSparController ()


#pragma mark - Properties

/**
 @brief  Stores reference on \b PubNub client which is used to communicate with other turtle fight
         player on the ring.
 */
@property (nonatomic) PubNub *client;

/**
 @brief  Stores current player type.
 */
@property (nonatomic, assign) BTBPlayer player;


#pragma mark - Processing

- (void)sendCommand:(NSString *)command;


#pragma mark - Misc

- (NSString *)playerSide;

#pragma mark -


@end


#pragma mark - Interface implementation

@implementation BTBSparController


#pragma mark - Initialization and Configuration

- (instancetype)init {
    
    // Check whether initialization was successful or not.
    if ((self = [super init])) {
        
        [PNLog enabled:NO];
        PNConfiguration *configuration = [PNConfiguration configurationWithPublishKey:kBTBApplicationPublishKey
                                                                         subscribeKey:kBTBApplicationSubscribeKey];
        _client = [PubNub clientWithConfiguration:configuration];
    }
    
    return self;
}


#pragma mark - Gameplay

- (void)setPlayer:(BTBPlayer)player {
    
    _player = player;
}

- (void)hitUp {
    
    [self sendCommand:@"up"];
}

- (void)hitDown {
    
    [self sendCommand:@"down"];
}


#pragma mark - Processing

- (void)sendCommand:(NSString *)command {
    
    [self.client publish:@{@"opID": command, @"channelID": [self playerSide]}
               toChannel:kBTBApplicationChannel withCompletion:^(PNPublishStatus *status) {
        
       if (status.isError) {
           
           UIAlertView *view = [[UIAlertView alloc] initWithTitle:@"Command failed."
                                message:@"Looks like there is some kind of error while processing command."
                               delegate:nil cancelButtonTitle:nil otherButtonTitles:nil, nil];
           [view show];
       }
    }];
}


#pragma mark - Misc

- (NSString *)playerSide {
    
    return (self.player == BTBFirstPlayer ? @"a" : @"b");
}

#pragma mark -


@end
