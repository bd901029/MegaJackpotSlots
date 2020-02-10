
#import "cocos2d.h"

@interface Slots_Animation : CCSprite
{
    CCNode *myParent;
    CCSpriteBatchNode *spriteSheet;
    NSArray *randomeElements;
    NSMutableArray *allElements;
    
    int machineNumber;
    int iconNumber;
    int animationInter;
}

- (id)initWithFrame:(CGRect)frame node:(CCNode *)par machineNr:(int)id_ iconNr:(int)nr_ elements:(NSArray *)el_;
- (void)playAnimarionByTag:(int)tag__ repeat:(int)times_;
- (void)setColorForIcon_red:(float)red green:(float)green blue:(float)blue;
- (void)iconsAnimation;
- (void)stopAllAnimation;
- (void)addSquareToIcon;
- (void)removeWinSquare;
-(void)scaleFirstIname:(float)float__;

@end
