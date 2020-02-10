//
//  coinsFA.m
//  Template
//
//  Created by macbook on 2013-10-28.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "coinsFA.h"
#import "cfg.h"
#import "coinFrame.h"

@implementation coinsFA{
    
    CCSpriteBatchNode *_batch;
    float t_;
    NSMutableArray *_CObject;
    
}

@synthesize startPosition,endPosition;
@synthesize minCoins,maxCoins,coinsNumber;
@synthesize timeMax;
@synthesize power;

-(void)prepareBatches{
    
    NSString *name = (IS_IPAD) ? @"coins_fly" : @"coins_fly_iPhone";
    
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    _batch = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.pvr.ccz",name] capacity:100000];
    [self addChild:_batch];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist",name]];
    
}

-(void)setup_{
    
    [self prepareBatches];
    
    if (endPosition.x == 0 && endPosition.y == 0)
    {
        endPosition = ccp(kWidthScreen*0.37f, kHeightScreen*0.955f);
    }
    
    //add coin
    
   // [self performSelector:@selector(startFlyAct) withObject:nil afterDelay:3];

    
    
    
}

-(int)getPowerByCoinsAmmount:(int)coinsNumber_{
    
    int i = coinsNumber_;
    
    int power_ = 1;
    
    if (i > 1000000) {
        power_ = 20;
    }
    else if (i > 750000){
        power_ = 15;
    }
    else if (i > 500000){
        power_ = 14;
    }
    else if (i > 250000){
        power_ = 13;
    }
    else if (i > 100000){
        power_ = 12;
    }
    else if (i > 75000){
        power_ = 11;
    }
    else if (i > 50000){
        power_ = 10;
    }
    else if (i > 40000){
        power_ = 9;
    }
    else if (i > 30000){
        power_ = 8;
    }
    else if (i > 20000){
        power_ = 7;
    }
    else if (i > 10000){
        power_ = 6;
    }
    else if (i > 5000){
        power_ = 5;
    }
    else if (i > 2500){
        power_ = 4;
    }
    else if (i > 1000){
        power_ = 3;
    }
    else if (i > 500){
        power_ = 2;
    }
    else {
        power_ = 1;
    }
    return power_;
}

-(void)startFlyAct{
    
    //coinsNumber = 30;
    
   
    
    float flyCoins = coinsNumber;
    
    power = [self getPowerByCoinsAmmount:coinsNumber];
    
    
    
    if (flyCoins > 100) {
        flyCoins = 100 + (100 * power/30) ;
        
    }
    else if (flyCoins <= 99){
        
        flyCoins = flyCoins/2;
        
    }
    float t= 0;
    
    for (int i = 0; i < power; i++) {
        
        for (int x = 0; x < flyCoins; x++)
        {
            
            t+=1.f;;
            
            float height = 12.f;
            
            float offset = pow(height, 2.5);

            offset *= (sin(t * 2.0) * 0.2f);
            
            coinFrame *_coin = [coinFrame spriteWithSpriteFrameName:@"coin_flat.png"];
            [_batch addChild:_coin];
           // _coin.scale = kSCALEVALY;   //(IS_IPAD) ? 0.65f : 0.4f;
            if (IS_IPHONE && [Combinations isRetina]) {
                _coin.scale = 0.8f;
            }
            if (IS_IPHONE && (![Combinations isRetina]))
            {
                _coin.scale = 0.8f;
            }
            if (IS_IPAD && [Combinations isRetina]) {
                _coin.scale = 1.3f;
            }
            
            if (IS_IPAD && ![Combinations isRetina]) {
                _coin.scale = kSCALEVALY;
                _coin.scale = _coin.scale * 0.8f;
            }
            
            _coin.position = startPosition;
            
           // NSLog(@"START POS %f %f",_coin.position.x,_coin.position.y);
            
            _coin.position = ccpAdd(_coin.position, ccp(offset, 0));
            [_coin setEndPos:endPosition];
            _coin.visible = NO;
            
            [_coin setup_afterDelay:(float)x/60 par:self];
            
        }
    }
    

    
}

-(void)dealloc
{
    [super dealloc];
}

-(void) onEnter
{
    [super onEnter];
}

-(void)onExit
{
    [super onExit];
}

@end
