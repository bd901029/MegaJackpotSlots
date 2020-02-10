//  Created by Eimio on 10/9/13.
//  Copyright 2013 bsixlux. All rights reserved.
#import <Foundation/Foundation.h>
#import "cocos2d.h"

#import "SpriteFlipCard.h"


@interface CardGame : CCSprite <CCTouchOneByOneDelegate>
{
    CCSpriteBatchNode *CARD_IMG;
    CCSpriteBatchNode *SET_IMG;
    CCSprite          *background_;
    
    NSMutableArray      *shuffle;
    
    CCSpriteFrame       *cActive1;
    CCSpriteFrame       *cNotActive1;
    
    SpriteFlipCard      *cardSprite;
    
    CCSprite            *closeBtn;
    
    CCLabelBMFont *winNumber;
    CCLabelBMFont *winText;
    CCLabelBMFont *livesNumber;
    CCLabelBMFont *livesText;
    
    CCLabelBMFont *nLabel;

    float     BET;
    
    int     cardNumber;
    int     secondC;
    int     cNumber1;
    int     cNumber2;
    float   nr_;
    float   fNUMBER;
    int     p_;
    int     countGood;
    
    int     guess1;
    int     guess2;
    
    float   totalWin_;
    int     totalLives_;
    
    BOOL    gameON;
    BOOL    BLOCK_TOUCH;
    
    int blocked_1 ;
    int blocked_2 ;
    
    int cColor_R;
    int cColor_G;
    int cColor_B;
    
    
}

-(id)init_withYourBET:(float)bet_;
-(void)exitGame;

@end
