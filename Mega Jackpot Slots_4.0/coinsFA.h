//
//  coinsFA.h
//  Template
//
//  Created by macbook on 2013-10-28.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "cocos2d.h"
enum coinflymode{
    
    state_coinfly_1   = 1,
    state_coinfly_2   = 2,
    
};

@interface coinsFA : CCSprite{
    
    CGPoint startPosition;
    CGPoint endPosition;
    
    int minCoins;
    int maxCoins;
    int coinsNumber;
    float power;
    
    float timeMax;
    
}
@property (assign) float timeMax;
@property (assign) float power;
@property (assign) int coinsNumber;
@property (assign) int maxCoins;
@property (assign) int minCoins;

@property (assign) CGPoint startPosition;
@property (assign) CGPoint endPosition;

-(void)setup_;

-(int)getPowerByCoinsAmmount:(int)coinsNumber_;

-(void)startFlyAct;

@end
