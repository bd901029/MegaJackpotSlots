
#import "cocos2d.h"
#import "coinsFA.h"


@interface SlotMachine : CCSprite <CCTouchOneByOneDelegate>
{
    NSArray *elements;
    int machineNumber;
    int betCount;
    int currentBet;
    coinsFA *CFA;
    
    bool unlockM;
    
    int lineNum;
}
+(CCScene *) sceneWithMachineNr:(int)machineNumber;
-(id) initWithMachineNr:(int)number;
-(void)spin;
-(void)lineUP;
-(void)betUp;
-(void)levelUp:(int)lvl levelup:(bool)bool_;
-(void)unlockMachine;
-(void)winCoinAnimation;
-(void)setMaxBet;
-(void)setLabelOfFreeSpins:(NSString *)str_;
-(void)bigWinCoins:(float)award;
-(void)stopSpinning;
-(void) closeWheelGame;
-(void) closeCardGame;
-(void)openMiniGame:(NSString *)miniGame;
-(void)setAutoSpin:(bool)bool_;
-(void)boostEnabled:(int)boost;
-(void)coinDropAnimation;
-(void)showWin:(int)win type:(int)type_;
-(void)removeBlackBG;
-(void)removeBigWin;
-(int)resumeMachineNum;
-(void)coinAnimation:(int)coins;
-(void)bigWinClose;
-(void)levelupClose;
@end
