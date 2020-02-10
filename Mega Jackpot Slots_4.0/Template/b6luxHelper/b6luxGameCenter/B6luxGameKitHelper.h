//
//  B6luxGameKitHelper.h
//
//  Created by Steffen Itterheim on 05.10.10.
//  Copyright 2010 Steffen Itterheim. All rights reserved.
//

#import "cocos2d.h"
#import <GameKit/GameKit.h>

#define gc_MAIN @"Main_"
#define gc_BRAIN @"Brain_"

#define gc_LEVEL(__X__) [NSString stringWithFormat:@"Level%i_",(__X__)]

#define gc_TopPlayerNickName 0
#define gc_TopPlayerScore 1

@protocol B6luxGameKitHelperProtocol

-(void) onLocalPlayerAuthenticationChanged;

-(void) onFriendListReceived:(NSArray*)friends;
-(void) onPlayerInfoReceived:(NSArray*)players;

-(void) onScoresSubmitted:(bool)success;
-(void) onScoresReceived:(NSArray*)scores;

-(void) onAchievementReported:(GKAchievement*)achievement;
-(void) onAchievementsLoaded:(NSDictionary*)achievements;
-(void) onResetAchievements:(bool)success;

-(void) onMatchFound:(GKMatch*)match;
-(void) onPlayersAddedToMatch:(bool)success;
-(void) onReceivedMatchmakingActivity:(NSInteger)activity;

-(void) onPlayerConnected:(NSString*)playerID;
-(void) onPlayerDisconnected:(NSString*)playerID;
-(void) onStartMatch;
-(void) onReceivedData:(NSData*)data fromPlayer:(NSString*)playerID;

-(void) onMatchmakingViewDismissed;
-(void) onMatchmakingViewError;
-(void) onLeaderboardViewDismissed;
-(void) onAchievementsViewDismissed;

@end


@interface B6luxGameKitHelper : NSObject <GKLeaderboardViewControllerDelegate, GKAchievementViewControllerDelegate, GKMatchmakerViewControllerDelegate, GKMatchDelegate,GKGameCenterControllerDelegate>
{
	id<B6luxGameKitHelperProtocol> delegate;
	bool isGameCenterAvailable;
	NSError* lastError;
	
    NSMutableDictionary* topPlayer;
	NSMutableDictionary* achievements;
	NSMutableDictionary* cachedAchievements;
	
    GKLeaderboard *leaderboardRequest;
	GKMatch* currentMatch;
	bool matchStarted;
    
    BOOL isLeaderboardShow;
}

@property (nonatomic, retain) id<B6luxGameKitHelperProtocol> delegate;
@property (nonatomic, readonly) bool isGameCenterAvailable;
@property (nonatomic, readonly) NSError* lastError;
@property (nonatomic, readonly) NSMutableDictionary* topPlayer;
@property (nonatomic, readonly) NSMutableDictionary* achievements;
@property (nonatomic, readonly) GKMatch* currentMatch;
@property (nonatomic, readonly) bool matchStarted;
@property (assign) BOOL isLeaderboardShow;

/** returns the singleton object, like this: [B6luxGameKitHelper sharedB6luxGameKitHelper] */
+(B6luxGameKitHelper*) sharedB6luxGameKitHelper;

// Player authentication, info
-(NSString *)getLocalPlayerAlias;
-(void) authenticateLocalPlayer;
-(void) getLocalPlayerFriends;
-(void) getPlayerInfo:(NSArray*)players;

// Scores
-(void) submitBrainScore:(int)score;
-(void) submitMainScore:(int)score;
-(void) submitScore:(int)score level:(int)level;
-(void) checkTopPlayers;
- (NSString *)returnTopPlayerByCategory:(NSString *)category type:(int)type_;
-(void) retrieveScoresForPlayers:(NSArray*)players
						category:(NSString*)category 
						   range:(NSRange)range
					 playerScope:(GKLeaderboardPlayerScope)playerScope 
					   timeScope:(GKLeaderboardTimeScope)timeScope;

// Achievements
-(GKAchievement*) getAchievementByID:(NSString*)identifier;
- (void) retrieveTopPlayerFromCategory:(NSString *)category;
-(void) reportAchievementWithID:(NSString*)identifier percentComplete:(float)percent;
-(void) resetAchievements;
-(void) reportCachedAchievements;
-(void) saveCachedAchievements;

// Matchmaking
-(void) disconnectCurrentMatch;
-(void) findMatchForRequest:(GKMatchRequest*)request;
-(void) addPlayersToMatch:(GKMatchRequest*)request;
-(void) cancelMatchmakingRequest;
-(void) queryMatchmakingActivity;

// Game Center Views
-(void) showLeaderboard:(NSString *)category;
-(void) showAchievements;
-(void) showMatchmakerWithInvite:(GKInvite*)invite;
-(void) showMatchmakerWithRequest:(GKMatchRequest*)request;

-(void) sendDataToAllPlayers:(void*)data length:(NSUInteger)length;

@end
