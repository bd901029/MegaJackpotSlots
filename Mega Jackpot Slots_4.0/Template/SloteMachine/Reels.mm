

#import "Reels.h"
#import "cfg.h"
#import "SCombinations.h"
#import "Slots_Animation.h"
#import "Awards.h"
#import "LinesPosition.h"
#import "SlotMachine.h"
#import "TopMenu.h"
#import "BottomMenu.h"
#import "Bet.h"
#import "Exp.h"
#import "IDSTOREPLACE.h"
#import <Licenses/Licenses.h>

#define kIconRect_iPad CGRectMake(0,0,120,120)
#define kIconRect_iPhone CGRectMake(0,0,55,40)

#define kHEIGHT_OF_LITTLE_BG [[myParent getChildByTag:555] getChildByTag:555]

#define kHEIGHT_OF_REEL kHEIGHT_OF_LITTLE_BG.contentSize.height *20

#define kTAG_OF_ANIMATION 500

#define kTAG_OF_ICON 100
#define kTAG_OF_REEL 50

#define kTAG_OF_WIN_REEL_ACTION 600

#define kTAG_OF_WIN_REELS 200

#define kTAG_OF_LINE 333

#define kTAG_LINE 700

#define kTAG_SQUARE 800

#define b (BottomMenu *)[myParent getChildByTag:kBottomMenuTAG]
#define t (TopMenu *)[myParent getChildByTag:kTopMenuTAG]


@implementation Reels{
    
     CCNode *myParent;
    
}

- (id)initWithFrame:(CGRect)frame node:(CCNode *)par lineNumber:(int)lineNum maxLines:(int)maxLines_{
    self = [super init];
    if (self) {
        
        linesNumber = lineNum;
        maxLines = maxLines_;
        i_freespinC = 0;
        spin_del = 1.f;
//        winStatus = 1;
        
        coins = [DB_ getValueBy:d_Coins table:d_DB_Table];
        
        winCoins = 0;
        touchCount = 0;
        i_touchCount = 5;
        freeSpin_WIN = 0;
        b_canSpin = true;
        
        [self addLineSpriteSheet];
        [self addWinningSquareSpriteSheet];
        
        elements = [NSArray arrayWithObjects:kA,kK,kQ,kJ,k10,kICON1,kICON2,kICON3,kICON4,kWILD,kSCATER,kBONUS, nil];
        
        myParent = par; // xxx
        canUpdateIcons = true;
        reelcount = 0;
        
        [self addReelBlocks];
        [self addElements];
        [self addWinReels];
        [self scheduleUpdate];
        
        for (int i = 1; i <=5; i++) {
            [self resetWinIcons:i];
        }
        //[self setAutoSpin:YES];
        
    }
    return self;
}

-(void)addLineSpriteSheet
{
    for (int i = 1; i<=2; i++) {
        
        [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
        CCSpriteBatchNode *lines = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"Lines_p%i.pvr.ccz",i]];
        [self addChild:lines z:20 tag:kTAG_OF_LINE+i];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"Lines_p%i.plist",i]];
    }

}

-(void)addWinningSquareSpriteSheet
{
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA8888];
    CCSpriteBatchNode *lines = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"win_square.pvr.ccz"]];
    [self addChild:lines z:21 tag:kTAG_SQUARE];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"win_square.plist"]];

}

- (NSArray *)countRandomeSpin
{
    
    NSMutableArray *icons = [NSMutableArray arrayWithObjects:kA,kK,kQ,kJ,k10,kICON1,kICON2,kICON3,kICON4,kWILD,kSCATER,kBONUS, nil];
    NSMutableArray *Bonusicons = [NSMutableArray arrayWithObjects:kA,kK,kQ,kJ,k10,kICON1,kICON2,kICON3,kICON4, nil];
    //    if([[UIScreen mainScreen] respondsToSelector:NSSelectorFromString(@"scale")] && [(NSString*)[UIDevice currentDevice].model hasPrefix:@"iPad"]&&[[UIScreen mainScreen] scale] > 1.9){
    //        icons = [NSMutableArray arrayWithObjects:kAipad,kKipad,kQipad,kJipad,k10ipad,kICON1ipad,kICON2ipad,kICON3ipad,kICON4ipad,kWILDipad,kSCATERipad,kBONUSipad, nil];
    //        Bonusicons = [NSMutableArray arrayWithObjects:kAipad,kKipad,kQipad,kJipad,k10ipad,kICON1ipad,kICON2ipad,kICON3ipad,kICON4ipad, nil];
    //    }
    
    NSMutableArray *randomeIcons = [[NSMutableArray alloc]initWithArray:icons];
    NSMutableArray *finalArray = [[NSMutableArray alloc] init];
    
    id randomObj = [icons objectAtIndex:arc4random_uniform((int)icons.count)];
    NSLog(randomObj);
    for (int i = 0; i < ChanceOfWinning; i++) {
        [randomeIcons addObject:randomObj];
    }
    
    for (int i = [[Authenticator sharedManager] i]; i<=[Authenticator sharedManager].Maxi; i++) {
        [finalArray addObject:[randomeIcons objectAtIndex:arc4random_uniform((int)[randomeIcons count])]];
        //[randomeIcons addObject:[icons objectAtIndex:11]];
    }
    return finalArray;
}



- (NSArray *)getRandomeSpin
{
    NSArray *a = [self countRandomeSpin];
    
//    NSArray *win = [Result getResultFromArray:a lines:linesNumber];
//    
//    float moneySpent  = [DB_ getValueBy:d_LoseAllTime table:d_DB_Table];
//    float moneyWin    = [DB_ getValueBy:d_WinAllTime table:d_DB_Table];
//    
//    if (moneySpent >= 10000000 || moneyWin >= 10000000) {
//        moneySpent = moneySpent/100000;
//        moneyWin = moneyWin/100000;
//        [DB_ updateValue:d_LoseAllTime table:d_DB_Table :moneySpent];
//        [DB_ updateValue:d_WinAllTime table:d_DB_Table :moneyWin];
//    }
// 
//    float _max = 1.2f;
//    float _min = 0.4f;
//    
//    float coficent = moneyWin/moneySpent;
//    
//    if (coficent <= 0.1f) {
//        coficent = 0.9f;
//    }
//    
//
//    winStatus = 1;//Default Randome..
//
//    //int rand = [self INT_MyRandomIntegerBetween:1 :10];
//    
//    //NSLog(@"KOEFICIENT:::   %f",coficent);
//    
//    if (coficent > _max) {winStatus = 2;}
//    
//    else if (coficent <= _max && coficent >= _min)
//    {
//        int rand = [self INT_MyRandomIntegerBetween:0:5];
//        if (rand == 0 || rand == 5) {winStatus = 0;}else{winStatus = 2;}
//        
//    }
//    else if (coficent < _min){winStatus = 1;}
//    
//    int littleWin = [self checkWinCoins:win];
//    
//    if((winStatus == 2) && ((littleWin * [b getCurrentBet]) <= ([b getTotalBet]  * 1.5f) )/* && ((rand >= 9) || (rand <= 2))*/)
//    {
//       // NSLog(@"                LITTLE WIN")      ;
//        return a;
//    }
//    
//    if (winStatus == 1)     //WIN
//    {
//        bool b_win = false;
//        while (!b_win) {
//            if ([self check_if_win:win]) {
//                b_win = true;
//                return a;
//            }
//            a = [self countRandomeSpin];
//            win = [Result getResultFromArray:a lines:linesNumber];
//        }
//    }
//    else if (winStatus ==2) //NOT WIN
//    {
//        bool b_win = true;
//        while (b_win) {
//            if (![self check_if_win:win]) {
//                b_win = false;
//                return a;
//            }
//            a = [self countRandomeSpin];
//            win = [Result getResultFromArray:a lines:linesNumber];
//        }
//    }
//    else if (winStatus == 0) //RANDOME
//    {
//    return a;
//    }
    
    return a;
}

-(float)MyRandomIntegerBetween:(int)min :(int)max {
    
    return (float)( (arc4random() % (max-min+1)) + min )/10;
}

-(int)INT_MyRandomIntegerBetween:(int)min :(int)max {
    
    return (float)( (arc4random() % (max-min+1)) + min );
}

-(void)checkAnim:(CCNode *)n
{
    
    [AUDIO playEffect:s_reelStop1];
    
    touchCount = 0;
    i_touchCount = 5;
    reelcount += 1;
    if (reelcount >= 5) {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:b_freespin ? 0.15 :  0.1f],[CCCallBlock actionWithBlock:^{
            if (spin_state == STATE_STOPPED) {
                
                [self onAnimation];
                if(!b_freespin){
                    if (!b_autoSpin) {
                        [b buttonActive:YES];
                    }
                }
            }
        }], nil]];
        reelcount = 0;
        canUpdateIcons = true;
    }
}

-(CCAction *)reelSwipeDownAnimation:(CCNode *)node_ tag:(int)tag__ duration:(float)dur_
{
    float distance = (-kHEIGHT_OF_LITTLE_BG.contentSize.height *20);
    
    if (node_.position.y > kHEIGHT_OF_LITTLE_BG.position.y) {
        distance = -(kHEIGHT_OF_LITTLE_BG.contentSize.height *20 + kHEIGHT_OF_LITTLE_BG.contentSize.height);
    }
    
    id firstDelay   =   [CCDelayTime actionWithDuration:0.0f];
    
    CCActionInterval *firstMove   =   [CCMoveBy actionWithDuration:dur_ position:ccp(0, distance -(IS_IPHONE ? 40 : 60))];

    
    id easein       =   [CCEaseInOut actionWithAction:firstMove rate:2.f];
    
    id secondMove   =   [CCEaseInOut actionWithAction:
                         [CCMoveBy actionWithDuration:0.2f position:ccp(0, (IS_IPHONE ? 40 : 60))] rate:1.f];
    
    id lastFunc     =   [CCCallFuncO actionWithTarget:self selector:@selector(checkAnim:) object:node_];
    
    id sequence;
    
    
    if (tag__ > 54) {
        sequence = [CCSequence actions:firstDelay,easein,secondMove,lastFunc, nil];
    }
    else
    {
        sequence = [CCSequence actions:firstDelay,easein,secondMove, nil];
    }

    id speed        =   [CCSpeed actionWithAction:sequence speed:1.0f];
    
     
    return speed;
}

////////////////////
///  RANDOME STOP
////////////////////


- (float)randomeStop:(int)tag_
{
    float i;
    
    float j = [self MyRandomIntegerBetween:2 :6];
    
    switch (tag_) {
        case 50:i = 2.0f + j;break;
        case 51:i = 2.8f - j;break;
        case 52:i = 2.5f + j;break;
        case 53:i = 2.6f - j;break;
        case 54:i = 3.0f + j;break;
        default:break;
    }
    
    return i;
}

-(void)autoSpin
{
    [self spin];
}

-(void)setAutoSpin:(bool)bool_
{
    b_autoSpin = bool_;
    
    if (bool_) {
        [self schedule:@selector(autoSpin) interval:0.5f];
    }
    else
    {
        [self unschedule:@selector(autoSpin)];
        [b buttonActive:YES];
        
    }
}

////////////////////
///  SPIN ANIMATION
////////////////////

-(void)reelRunAction:(CCNode*)node_
{
    if (![self getActionByTag:node_.tag]) {
        
        float i = [self randomeStop:node_.tag];
        
        [node_ runAction:[self reelSwipeDownAnimation:node_ tag:node_.tag duration:i]].tag = node_.tag;
          
        [[self getChildByTag:(kTAG_OF_WIN_REELS + node_.tag) - 50] runAction:[self reelSwipeDownAnimation:node_ tag:kTAG_OF_WIN_REEL_ACTION + node_.tag duration:i]].tag = kTAG_OF_WIN_REEL_ACTION + node_.tag;
            
    }
}

//- (NSArray *)getIdElement
//{
//    NSMutableArray *mArray = [[[NSMutableArray alloc]initWithCapacity:16] autorelease];
//    
//    for (int i = 1; i<=15; i++) {
//        [mArray addObject:[NSNumber numberWithInt:[self MyRandomIntegerBetween:1 :10]]];
//    }
//    
//    return mArray;
//}


////////////////////
///  RESET WIN ICONS
////////////////////
//////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////

-(void)resetWinIcons:(int)reelNr
{
    NSArray *randoome;
    
    if (!canUpdateIcons) {
        randoome = [self getElementsArray:2];
    }
    else if (canUpdateIcons)
    {
        randoome = [self getElementsArray:1];
        canUpdateIcons = false;
        
    }
   // NSLog(@"FINAL %i:   %@",reelNr, randoome);
            int l = 3 * reelNr;
            
            CCSprite *s = (CCSprite *)[self getChildByTag:(kTAG_OF_WIN_REELS+reelNr) -1];
            
            CCSprite *reel = (CCSprite *)[self getChildByTag:(kTAG_OF_REEL+reelNr) - 1];
            
            for (int i = 0; i<3; i++) {
                
                Slots_Animation *sAnin = (Slots_Animation *)[s getChildByTag:l];
                if (sAnin) {
                    [sAnin removeFromParentAndCleanup:YES];
                    
                    Slots_Animation *sAnim_ = [[[Slots_Animation alloc]initWithFrame:CGRectMake(0, 0, 0, 0) node:self machineNr:1 iconNr:l elements:randoome]autorelease];//////////////////////////////////////////////////////////////////////////////////
                    
                    sAnim_.anchorPoint = ccp(0.5f, 0.5f);
                    
                    sAnim_.position = ccp(reel.contentSize.width/2,((kHEIGHT_OF_LITTLE_BG.contentSize.height/3 - sAnim_.contentSize.height))/2 + (kHEIGHT_OF_LITTLE_BG.contentSize.height/3 * i));
                    
                    [s addChild:sAnim_ z:10 tag:l];

                }
                l -= 1;
            }
}

////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////
////////////////////           
///  ADD SHORT REELS WITH ICONS  
////////////////////


-(void)addWinReels
{
    NSArray *randome = [self getElementsArray:1];
    for (int j = 1; j<=5; j++) {
        
        int l = 3 * j;
        
        CCSprite *s = [[[CCSprite alloc]init] autorelease];
        
        CCSprite *reel = (CCSprite *)[self getChildByTag:(kTAG_OF_REEL+j) - 1];
        
        
        s.contentSize = CGSizeMake([self getChildByTag:kTAG_OF_REEL].contentSize.width, kHEIGHT_OF_LITTLE_BG.contentSize.height);
        s.anchorPoint = ccp(0, 0);
        
        s.position = ccp(reel.position.x, reel.position.y + kHEIGHT_OF_REEL);
        
        [self addChild:s z:10 tag:(kTAG_OF_WIN_REELS+j) -1];
        
        
        for (int i = 0; i<3; i++) {
            
            Slots_Animation *sAnim = [[[Slots_Animation alloc]initWithFrame:CGRectMake(0, 0, 0, 0) node:self machineNr:1 iconNr:l elements:randome]autorelease];
            
            sAnim.anchorPoint = ccp(0.5f, 0.5f);
            
            sAnim.position = ccp(reel.contentSize.width/2,((kHEIGHT_OF_LITTLE_BG.contentSize.height/3 - sAnim.contentSize.height))/2 + (kHEIGHT_OF_LITTLE_BG.contentSize.height/3 * i));
            
            [s addChild:sAnim z:5 tag:l];
        
    
            l -= 1;
        }
    }
}


////////////////////
///  ON SPIN BUTTON
////////////////////

-(void)defaultState
{
    [self stopAllAnimations];
    
    for (int i = 0; i<= lineAnimationCount; i++) {
        if ([self getActionByTag:i]) {
            [self stopActionByTag:i];
        }
    }
    
    
    
    for (int i = 1; i <=2; i++) {
        if ([[self getChildByTag:kTAG_OF_LINE+i] getChildByTag:333]) {
            [[[self getChildByTag:kTAG_OF_LINE+i] getChildByTag:333] removeFromParent];
        }
        
    }
    
    // Change icons color to dark
    
    for (int j = 1; j<=5; j++) {
        
        [self reorderChild:[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1] z:10];
        
        int l = 3 * j;
        
        CCSprite *s = (CCSprite *)[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1];
        
        for (int i = 0; i<3; i++) {
            Slots_Animation *sAnim = (Slots_Animation *)[s getChildByTag:l];
            [sAnim setColorForIcon_red:255 green:255 blue:255];
            [sAnim removeWinSquare];
            l -= 1;
        }
    }
}

-(void)updateCoinsLabel:(float)coins_
{
    [t minusCoins:coins_];
}

- (void)setMaxBet//count BET if MAXBET > COINS
{
    float coins_ = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
 
    float totalBet = [b getTotalBet];
    
    if (totalBet > coins_) {
        NSArray *bet = [Bet getBetbyLevel:kLEVEL];
        int betMax = [bet count];
        
        while (totalBet > coins_) {
            betMax--;
            if (betMax == 0) {
                
                if (![t getChildByTag:kBuyWindowTAG]){
                     [t openBuyWindow_withNR:[NSNumber numberWithInt:1]];
                }
               
            
                NSNumber *n = [bet objectAtIndex:betMax];
                [b setBet:n.floatValue];
                [b countTotalBet];
                break;
            }
            NSNumber *n = [bet objectAtIndex:(betMax-1)];
            [b setBet:n.floatValue];
            [b countTotalBet];
            totalBet = [b getTotalBet];
        }
    }
    else
    {
        //NSLog(@"");
    }
   // NSLog(@"");
}

-(void)allBoostDeactivate
{
    boost2x = false;
    boost3x = false;
    boost4x = false;
    boost5x = false;
}

-(void)boostEnabled:(int)boostC
{
    switch (boostC) {
        case 2:boost2x = true;break;
        case 3:boost3x = true;break;
        case 4:boost4x = true;break;
        case 5:boost5x = true;break;
        default:break;
    }
}

-(void)removeLines
{
    for (int i = 1; i <=2; i++) {
        if (i == 1) {
            if ([[self getChildByTag:kTAG_OF_LINE+1] getChildByTag:333]) {
                [[[self getChildByTag:kTAG_OF_LINE+1] getChildByTag:333]removeFromParent];
            }
        }
        else if (i == 2) {
            if ([[self getChildByTag:kTAG_OF_LINE+2] getChildByTag:333]) {
                [[[self getChildByTag:kTAG_OF_LINE+2] getChildByTag:333]removeFromParent];
            }
        }
    }
    
    for (int i = 1; i<=30; i++) {
        
        if (i <= 15) {
            if ([[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:i]) {
                [[[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:i]removeFromParent];
            }
        }
        else if(i > 15)
        {
            if ([[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:i]) {
                [[[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:i]removeFromParent];
            }
        }
    }
        NSLog(@"RemoveLines method end;");
}

- (void)spin
{

    if(!b_canSpin)
    {
        return;
    }
    [self setMaxBet];
    float c = [DB_ getValueBy:d_Coins table:d_DB_Table];
    float totalBet = [b getTotalBet];
    
    //[b checkAllBoostButton];
    
    if (c < totalBet) {
        if (![t getChildByTag:kBuyWindowTAG]) {
            [AUDIO playEffect:s_nocoinsLeft];
            [t openBuyWindow_withNR:[NSNumber numberWithInt:1]];
        }
        [self setAutoSpin:NO];
        
        if (b_freespin) {
            [self unschedule:@selector(spin)];
            [b exitAutospin];
            [self defaultState];
            [self removeLines];
            freeSpin_WIN    = 0;
            i_freespinC     = 0;
        }
        [b buttonActive:YES];
        return;
    }
    
//    if ((c < 0.1) && b_autoSpin) {
//        
//        if (![t getChildByTag:kBuyWindowTAG]) {
//            [t openBuyWindow_withNR:[NSNumber numberWithInt:1]];
//        }
//        [self setAutoSpin:NO];
//        [b buttonActive:YES];
//        return;
//    }
    
    if ((c < 0.1) && !b_freespin) {
        if (![t getChildByTag:kBuyWindowTAG]) {
            [AUDIO playEffect:s_nocoinsLeft];
            [t openBuyWindow_withNR:[NSNumber numberWithInt:1]];
        }

        return;
    }
        
    if (boost2x)        {int boost = [DB_ getValueBy:d_Boost2x table:d_DB_Table];
        boost--;
        [DB_ updateValue:d_Boost2x table:d_DB_Table :boost];
        if (boost <= 0) {
            [b hideBoostsIndicator];
            //[b openBoostsWindow];
            
            boost2x = false;
        }
    }
    
    else if (boost3x)   {int boost = [DB_ getValueBy:d_Boost3x table:d_DB_Table];
        boost--;
        [DB_ updateValue:d_Boost3x table:d_DB_Table :boost];
        if (boost <= 0) {
            [b hideBoostsIndicator];
            //[b openBoostsWindow];
            boost3x = false;
        }}
    
    else if (boost4x)   {int boost = [DB_ getValueBy:d_Boost4x table:d_DB_Table];
        boost--;
        [DB_ updateValue:d_Boost4x table:d_DB_Table :boost];
        if (boost <= 0) {
            [b hideBoostsIndicator];
           // [b openBoostsWindow];
            boost4x = false;
        }}
    
    else if (boost5x)   {int boost = [DB_ getValueBy:d_Boost5x table:d_DB_Table];
        boost--;
        [DB_ updateValue:d_Boost5x table:d_DB_Table :boost];
        if (boost <= 0) {
            [b hideBoostsIndicator];
           // [b openBoostsWindow];
            boost5x = false;
        }}
    
    [b updateBoostLabels];

    
    touchCount = 0;
    
    [b buttonActive:NO];
    
    
    if (b_freespin) {
        i_freespinC--;
        
        //[(SlotMachine *)_parent setLabelOfFreeSpins:i_freespinC];
        
        [b updateSpinLeft:i_freespinC];
        
        if (i_freespinC == -1) {
            b_freespin = false;
            if (!b_autoSpin) {
                [b buttonActive:YES];
            }
            [b exitAutospin];
            [self unschedule:@selector(spin)];
            [self defaultState];
            [self removeLines];
            
            [t addLastWin:freeSpin_WIN];
            
            //float coins_ = [DB_ getValueBy:d_Coins table:d_DB_Table];
            
            //float finalCoins = coins_ + freeSpin_WIN;
            
            //[DB_ updateValue:d_Coins table:d_DB_Table :finalCoins];
            
            //[t addCoins:freeSpin_WIN];
            
            //float Allwin = [DB_ getValueBy:d_WinAllTime table:d_DB_Table];
            //Allwin = Allwin + freeSpin_WIN;
            //[DB_ updateValue:d_WinAllTime table:d_DB_Table :Allwin];
            
           // [(SlotMachine *)_parent coinAnimation:freeSpin_WIN];
            
            //NSLog(@"FreeSpin WIN:   %f",freeSpin_WIN);
            [(SlotMachine *)_parent showWin:freeSpin_WIN type:4];
            
            //// SHOW FREE SPIN POPUP
            freeSpin_WIN    = 0;
            i_freespinC     = 0;
            return;
        }
    }

    
   
   
    for (int i = 0; i<5; i++)
    {
        if ([[self getChildByTag:kTAG_OF_REEL+i] getActionByTag:kTAG_OF_REEL + i]) {
            return;
        }
    }
    
    [self defaultState];
    
    
    [self removeLines];
    
    for (int i = 0; i<5; i++) {
        
        [self performSelector:@selector(reelRunAction:) withObject:[self getChildByTag:kTAG_OF_REEL+i]];
        
    }
    
    b_canSpin = false;
    
    ////////////////COINS COUNT/////////////////////
    coins = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
    if (!b_freespin) {
       coins = coins - totalBet;
        
        float AllLose = [DB_ getValueBy:d_LoseAllTime table:d_DB_Table];
        AllLose = AllLose + totalBet;
        [DB_ updateValue:d_LoseAllTime table:d_DB_Table :AllLose];
        
        [self updateCoinsLabel:coins];
        [DB_ updateValue:d_Coins table:d_DB_Table :coins];
    
    }

    
    float exp_ = [DB_ getValueBy:d_Exp table:d_DB_Table];
    
    float totalExp_ = exp_ + totalBet;
    
    [DB_ updateValue:d_Exp table:d_DB_Table :totalExp_];
    
   
    [t addExpValue:totalExp_ scale:YES];
    
    int expPercents = [Exp returnExpPercentage:totalExp_];
    
    [t progressNumber:expPercents scale:YES];
    
    NSLog(@"Spin method end;");

}


////////////////////
///  ADD LONG REELS
////////////////////


-(void)addReelBlocks
{
    for (int i = 0; i<5; i++) {
        
        CCSprite *s = [[[CCSprite alloc]init]autorelease];
        
        s.anchorPoint = ccp(0, 0);
        
        s.position = ccp((kHEIGHT_OF_LITTLE_BG.position.x - kHEIGHT_OF_LITTLE_BG.contentSize.width/2) + ((kHEIGHT_OF_LITTLE_BG.contentSize.width/5)/2)+(((kHEIGHT_OF_LITTLE_BG.contentSize.width/5) *i)-  (kHEIGHT_OF_LITTLE_BG.contentSize.width/5 )/2) ,    kHEIGHT_OF_LITTLE_BG.position.y - kHEIGHT_OF_LITTLE_BG.contentSize.height/2);
        
        
        s.contentSize = CGSizeMake(kHEIGHT_OF_LITTLE_BG.contentSize.width/5,((kHEIGHT_OF_LITTLE_BG.contentSize.height *20) + (((kHEIGHT_OF_LITTLE_BG.contentSize.height/3 - (IS_IPAD ? (kIconRect_iPad.size.height) : (kIconRect_iPhone.size.height))))/2) + kHEIGHT_OF_LITTLE_BG.position.y - kHEIGHT_OF_LITTLE_BG.contentSize.height/2 ));
        
        [self addChild:s z:10 tag:kTAG_OF_REEL+i];
    }
}


-(void)spinSoundUpdate{
    
 //   float hspeed = 0;
    int div = 7;  //max

    spinSoundStep+=1;
    div = div+((spinSoundStep/100)*2);

    if (spinSoundStep > 100) {
        div = div+(spinSoundStep/100);
    }

  //  NSLog(@"div %i",div);
    
    if ([cfg isNumber:(int)spinSoundStep devidableBy:div] && spinSoundStep <= 200) {
        [AUDIO playEffect:@"s_9.wav"];   //spin sound
    }
    
    
}

////////////////////
///  UPDATE
////////////////////


-(void)update:(ccTime)delta
{
    
    switch (spin_state) {
        case STATE_SPINING:
            

            
        //    NSLog(@"self %@",self);
            
            [self spinSoundUpdate];
            
            
         //   [AUDIO playEffect:@"wheelspin.mp3"];
            
            break;
            
        case STATE_STOPPED:{
            //[self onAnimation];
           // spin_state = STATE_NORMAL;
            spinSoundStep = 0;
            
        }
        break;
            
        case STATE_NORMAL:
            
            
            break;
            
        default:
            break;
    }
    
    for (int j = 0; j<5; j++) {
        
        if (![[self getChildByTag:kTAG_OF_REEL+j] getActionByTag:kTAG_OF_REEL + j]) {
            spin_state = STATE_STOPPED;
        }
        else
        {
            spin_state = STATE_SPINING;
        }
        
        CCSprite *winR = (CCSprite *)[self getChildByTag:kTAG_OF_WIN_REELS + j];
        CCSprite *reel = (CCSprite *)[self getChildByTag:kTAG_OF_REEL + j];
        
        float pY = kHEIGHT_OF_LITTLE_BG.position.y - kHEIGHT_OF_LITTLE_BG.contentSize.height/2;
        //NSLog(@"CS:   %f",winR.contentSize.height);
        
        if (winR.position.y + kHEIGHT_OF_LITTLE_BG.contentSize.height *1.5f < pY) {
            winR.position = ccp(winR.position.x, reel.position.y + kHEIGHT_OF_REEL);
            [self resetWinIcons:j+1];
        }
        
        else if (winR.position.y < kHEIGHT_OF_LITTLE_BG.position.y - kHEIGHT_OF_LITTLE_BG.contentSize.height/2) {
            
            reel.position = ccp(reel.position.x, winR.position.y + winR.contentSize.height);
            
          //  if (!canUpdateReels) {
                for (int i = 0 ; i<12;i++) {
                    CCSprite *s = (CCSprite *)[reel getChildByTag:kTAG_OF_ICON+i];
                    s.position = ccp(reel.contentSize.width/2,((kHEIGHT_OF_LITTLE_BG.contentSize.height/3 - s.contentSize.height))/2 + (kHEIGHT_OF_LITTLE_BG.contentSize.height/3 * i));
                }
            //    canUpdateReels = true;
           // }
        }
        
        for (int i = 0; i<12; i++) {
            
            CCSprite *icon = (CCSprite *)[reel getChildByTag:kTAG_OF_ICON+i];
            
            CGPoint pos = [reel convertToWorldSpace:icon.position];
            
            
            if (pos.y > reel.position.y + kHEIGHT_OF_REEL) {
                
              //  CCTexture2D *newTexture = [[CCTextureCache sharedTextureCache] addImage:@"2.png"];
                
                icon.position = ccp(icon.position.x, icon.position.y + kHEIGHT_OF_LITTLE_BG.contentSize.height);
                
                //icon.opacity = 0;
              
            }
            if (pos.y + icon.contentSize.height*1.5f < 0)
            {
                icon.position = ccp([self getChildByTag:kTAG_OF_REEL].contentSize.width/2,icon.position.y + (kHEIGHT_OF_LITTLE_BG.contentSize.height/3) *11);
            
            }
        }
    }
}

-(void)countMaxBet:(float)bet lines:(int)lines_
{
    linesNumber = lines_;

    [b setLines:linesNumber];
    [b setBet:bet];
}

-(void)lineUP
{
    [self defaultState];
    if (linesNumber == maxLines) {
        linesNumber = 0;
    }
    
    for (int i = 1; i<=maxLines; i++) {
        
        if (i <= 15) {
            if ([[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:i]) {
                [[[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:i]removeFromParent];
            }
        }
        else if(i > 15)
        {
            if ([[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:i]) {
                [[[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:i]removeFromParent];
            }
        }
    }
    
    linesNumber +=1;

    [b setLines:linesNumber];
    [b setMaxLines:maxLines];
    
    for (int i = 1; i <= linesNumber; i++) {
        CCSprite *line = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"line_%i.png",i]];
        line.opacity = 0;
        line.position = [LinesPosition getLinePosition:i];
        if (i <= 15) {
            [[self getChildByTag:kTAG_OF_LINE+1] addChild:line z:999 tag:i];
            if (i == linesNumber) {
                [line runAction:[CCFadeTo actionWithDuration:0.1 opacity:255]];
            }
            else
            {
                line.opacity = 255;
            }
        }
        else if(i > 15)
        {
            [[self getChildByTag:kTAG_OF_LINE+2] addChild:line z:999 tag:i];
            if (i == linesNumber) {
                [line runAction:[CCFadeTo actionWithDuration:0.1 opacity:255]];
            }
            else
            {
                line.opacity = 255;
            }
        }

    }
    
    if ([self getActionByTag:111]) {
        [self stopActionByTag:111];
    }
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.f],[CCCallBlock actionWithBlock:^{
        for (int i = 1; i<=maxLines; i++) {
            
            if (i <= 15) {
                if ([[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:i]) {
                    [[[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:i] runAction:[CCFadeTo actionWithDuration:0.15f opacity:0]];
                }
            }
            else if(i > 15)
            {
                if ([[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:i]) {
                     [[[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:i] runAction:[CCFadeTo actionWithDuration:0.15f opacity:0]];
                }
                
            }
        }

    }], nil]].tag = 111;
    
}



-(NSArray *)getElementsArray:(int)type_
{
    
    if (type_ == 1) {
        if (randomeElements != nil) {
            
            [randomeElements removeAllObjects];
        }
        NSArray *a = [self getRandomeSpin];
        
        if (randomeElements==nil)
        {
            randomeElements = [[NSMutableArray alloc]init];
        }
        
        for (id obj in a)
        {
            [randomeElements addObject:obj];
        }
        
        return randomeElements;
    }
    else if (type_ == 2)
    {
        
    return randomeElements;
    
    }
    
    return randomeElements;
}

////////////////////
///  ADD ICONS TO LONG REELS
////////////////////


-(void)addElements
{
    for (int j = 0; j<5; j++) {
    
        for (int i = 0; i<12; i++) {
            
            CCSprite *reel = (CCSprite *)[self getChildByTag:kTAG_OF_REEL+j];
            
            NSString *s = [NSString stringWithFormat:@"%@.png",[elements objectAtIndex:[self INT_MyRandomIntegerBetween:0 :11]]];
            
            CCSprite *sprite = [CCSprite spriteWithSpriteFrameName:s];
            
            sprite.anchorPoint = ccp(0.5f, 0.f);
            
            sprite.position = ccp(reel.contentSize.width/2,((kHEIGHT_OF_LITTLE_BG.contentSize.height/3 - sprite.contentSize.height))/2 + (kHEIGHT_OF_LITTLE_BG.contentSize.height/3 * i));
            
            [reel addChild:sprite z:5 tag:kTAG_OF_ICON+i];
            
        }
    }
}

-(void) onEnter
{
    [super onEnter];
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_Reels swallowsTouches:YES];
    // xxx
}

-(void) onExit
{
    [super onExit];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate: self];
}


////////////////////
///  ANIMATION WIN ICONS
////////////////////

-(void)stopAllAnimations
{
    for (int j = 1; j<=5; j++) {
        
        int l = 3 * j;
        
        CCSprite *s = (CCSprite *)[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1];
        
        for (int i = 0; i<3; i++) {
            Slots_Animation *sAnim = (Slots_Animation *)[s getChildByTag:l];
            [sAnim stopAllAnimation];
            l -= 1;
        }
    }
}


-(void)showFreeSpinWin:(NSArray *)ar_
{
    for (int i = 0; i<5; i++)
    {
        if ([[self getChildByTag:kTAG_OF_REEL+i] getActionByTag:kTAG_OF_REEL + i]) {
            return;
        }
    }

    for (int i = 1; i <=2; i++) {
        if (i == 1) {
            if ([[self getChildByTag:kTAG_OF_LINE+1] getChildByTag:333]) {
                [[[self getChildByTag:kTAG_OF_LINE+1] getChildByTag:333]removeFromParent];
            }
        }
        else if (i == 2) {
            if ([[self getChildByTag:kTAG_OF_LINE+2] getChildByTag:333]) {
                [[[self getChildByTag:kTAG_OF_LINE+2] getChildByTag:333]removeFromParent];
            }
        }
    }
    
    for (int j = 1; j<=5; j++) {
        
        int l = 3 * j;
        
        CCSprite *s = (CCSprite *)[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1];
        
        for (int i = 0; i<3; i++) {
            
            Slots_Animation *sAnim = (Slots_Animation *)[s getChildByTag:l];
            
            if (ar_ != nil) {
                
                NSArray *t_ = (NSArray *)[ar_ objectAtIndex:1];
                
                for (NSNumber *icon in t_) {
                    
                    if (l == icon.intValue)
                    {
                        NSNumber *lineNumber = (NSNumber *)[(NSArray *)[ar_ objectAtIndex:0] objectAtIndex:0];
                        
                        [self reorderChild:[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1] z:25];
                        
                        
                        [sAnim addSquareToIcon];
                        
                        CCSprite *line = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"line_%i.png",lineNumber.intValue]];
                        //line.opacity = 10;
                        
                        line.position = [LinesPosition getLinePosition:lineNumber.intValue];
                        if (lineNumber.intValue <= 15) {
                            if (![[self getChildByTag:kTAG_OF_LINE+1]getChildByTag:lineNumber.intValue]) {
                                [[self getChildByTag:kTAG_OF_LINE+1] addChild:line z:999 tag:lineNumber.intValue];
                            }
                        }
                        else if(lineNumber.intValue > 15)
                        {
                            if (![[self getChildByTag:kTAG_OF_LINE+2]getChildByTag:lineNumber.intValue]) {
                                [[self getChildByTag:kTAG_OF_LINE+2] addChild:line z:999 tag:lineNumber.intValue];
                            }
                        }
                        //[line runAction:[CCRepeat actionWithAction:[CCSequence actions:[CCFadeTo actionWithDuration:0.1f opacity:255],[CCDelayTime actionWithDuration:0.4f],[CCFadeTo actionWithDuration:0.1f opacity:0], nil] times:3]];
                        
                        [sAnim setColorForIcon_red:255 green:255 blue:255];
                        [sAnim iconsAnimation];
                        break;
                    }
                }
            }
            l -= 1;
        }
    }
}

- (void)showWin:(NSArray *)ar_
{
    
    for (int i = 0; i<5; i++)
    {
        if ([[self getChildByTag:kTAG_OF_REEL+i] getActionByTag:kTAG_OF_REEL + i]) {
            return;
        }
    }
    
    [self stopAllAnimations];
    
   // NSLog(@"ARRAY:  %@",ar_);
    
    
    
    
    
    for (int j = 1; j<=5; j++) {
        
        int l = 3 * j;
        
        [self reorderChild:[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1] z:10];
        
        CCSprite *s = (CCSprite *)[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1];
        
        for (int i = 0; i<3; i++) {
            
            Slots_Animation *sAnim = (Slots_Animation *)[s getChildByTag:l];
            [sAnim removeWinSquare];
           
            
            if (ar_ != nil) {
                
                NSArray *t_ = (NSArray *)[ar_ objectAtIndex:1];
                
                for (NSNumber *icon in t_) {
                    
                    if (l == icon.intValue)
                    {
                        NSNumber *lineNumber = (NSNumber *)[(NSArray *)[ar_ objectAtIndex:0] objectAtIndex:0];
                        
                        for (int i = 1; i<=2; i++) {
                            [self reorderChild:[self getChildByTag:kTAG_OF_LINE+i] z:15];
                        }
                        
                        [self reorderChild:[self getChildByTag:(kTAG_OF_WIN_REELS+j) -1] z:25];
                        
                        [sAnim addSquareToIcon];
                        
                        //[s reorderChild:[s getChildByTag:l] z:-20];
                                                
                        for (int i = 1; i <=2; i++)
                        {
                            if ([[self getChildByTag:kTAG_OF_LINE+i] getChildByTag:333]) {
                                [[[self getChildByTag:kTAG_OF_LINE+i] getChildByTag:333] removeFromParent];
                            }
                        }
        
                        CCSprite *line = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"line_%i.png",lineNumber.intValue]];
                        
                        line.position = [LinesPosition getLinePosition:lineNumber.intValue];
                        if (lineNumber.intValue <= 15) {
                            [[self getChildByTag:kTAG_OF_LINE+1] addChild:line z:999 tag:333];
                        }
                        else if(lineNumber.intValue > 15)
                        {
                            [[self getChildByTag:kTAG_OF_LINE+2] addChild:line z:999 tag:333];
                        }
                                                
                        [sAnim setColorForIcon_red:255 green:255 blue:255];
                        [sAnim iconsAnimation];
                        break;
                    }
                    else
                    {
                        [sAnim setColorForIcon_red:70 green:70 blue:70];
                    }
                }
            }
            l -= 1;
        }
    }
}

-(int)checkWinCoins:(NSArray *)ar_
{
    int win = 0;
    
    bool bonus__ = false;
    bool scater__ = false;
    
    int max = [b getTotalBet];
    for (NSArray *half in ar_) {
        
        NSNumber *b_ = [[half objectAtIndex:0]objectAtIndex:5];
        NSNumber *s = [[half objectAtIndex:0]objectAtIndex:6];
        bonus__ = b_.boolValue;
        scater__  = s.boolValue;
        
        if (scater__ || bonus__) {
            return max;
        }
        
        NSNumber *n = (NSNumber *)[[half objectAtIndex:0] objectAtIndex:4];
        
        int award = [Awards getAward:[NSString stringWithFormat:@"%@",[[half objectAtIndex:0]objectAtIndex:3]] winCount:n.intValue];
        win = win + award;
        
    }
    
    return win;

}

-(BOOL)check_if_win:(NSArray *)ar_
{
    bool is_win = false;
    for (NSArray *half in ar_) {
        
        NSNumber *b_ = [[half objectAtIndex:0]objectAtIndex:5];
        NSNumber *s = [[half objectAtIndex:0]objectAtIndex:6];
        bool bonus   = b_.boolValue;
        bool scater  = s.boolValue;
        
        NSNumber *n = (NSNumber *)[[half objectAtIndex:0] objectAtIndex:4];
        
        int award = [Awards getAward:[NSString stringWithFormat:@"%@",[[half objectAtIndex:0]objectAtIndex:3]] winCount:n.intValue];
        
        if (award > 0 || bonus || scater) {
            is_win = true;
        }
    }
    
    return is_win;
}

-(BOOL)checkAutoSpin
{
    return b_autoSpin;
}

-(void)freespinSchedule
{
    [self schedule:@selector(spin) interval:0.5f];
}

-(void)freeSpins:(int)spins
{
    i_freespinC = i_freespinC + spins;
    
    [(SlotMachine *)_parent setLabelOfFreeSpins:@"FREESPIN"];

    [b buttonActive:NO];
    [b runAutospin];
    
    [b updateSpinLeft:i_freespinC];
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5f],[CCCallFunc actionWithTarget:self  selector:@selector(freespinSchedule)], nil]];
    
    b_freespin = true;
    
}
-(void)minigameIsClosed
{
    b_canSpin = true;
    b_bonus = false;

}
-(void)miniGameShow
{
    int i = [self INT_MyRandomIntegerBetween:1 :2];
    if (i == 1) {[(SlotMachine *)_parent openMiniGame:kCardGame_];}
    else if (i == 2){[(SlotMachine *)_parent openMiniGame:kWheelGame_];}
  
    [self defaultState];
}
-(float)returnDur
{
    if (b_freespin) {
        return 1.f;
    }
    if (b_autoSpin) {
        return 1.f;
    }
    return 0.1f;
}

-(void)onAnimation
{
    
    NSArray *getArray = [self getElementsArray:2];
    
    NSArray *win = [Result getResultFromArray:getArray lines:linesNumber];
   
    lineAnimationCount = 0;
    float delay = 0;
    float bigWinNum = BigWinMultiplier;
    
    bool scater;
    int freeSpins = 0;
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:b_freespin ? spin_del   :   0.1f],[CCCallBlock actionWithBlock:^{
        if (!b_bonus) {
            b_canSpin = true;
        }
    }], nil]];
    
    for(NSArray *a in win)
    {
        NSNumber *b_ = [[a objectAtIndex:0]objectAtIndex:5];
        NSNumber *s = [[a objectAtIndex:0]objectAtIndex:6];
        b_bonus = b_.boolValue;
        scater  = s.boolValue;
        
        if (scater) {
           // NSLog(@"SCATER");
            
            //b_freespin = true;
            
            NSNumber *n = (NSNumber *)[[a objectAtIndex:0] objectAtIndex:2];
            
            [AUDIO playEffect:s_winicon3];
            
            freeSpins = [Awards getAward:[NSString stringWithFormat:@"%@",[[a objectAtIndex:0]objectAtIndex:3]] winCount:n.intValue];
          
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:delay],[CCCallFuncO actionWithTarget:self selector:b_freespin ? @selector(showFreeSpinWin:) : @selector(showWin:) object:a], nil]].tag = scater_bonus_anim;
            
            
            //[self freeSpins:freeSpins];
            
            break;
        }
        if (b_bonus) {
           // NSLog(@"BONUS");
            
            [AUDIO playEffect:s_wingame];
            
            b_canSpin = false;
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:delay],[CCCallFuncO actionWithTarget:self selector:b_freespin ? @selector(showFreeSpinWin:) : @selector(showWin:) object:a],[CCDelayTime actionWithDuration:1.0f],[CCCallFunc actionWithTarget:self selector:@selector(miniGameShow)], nil]].tag = scater_bonus_anim;
            
            
            break;
        }
    
    }
    
    for (NSArray *half in win) {

        NSNumber *n = (NSNumber *)[[half objectAtIndex:0] objectAtIndex:4];
        
        int award = [Awards getAward:[NSString stringWithFormat:@"%@",[[half objectAtIndex:0]objectAtIndex:3]] winCount:n.intValue];
        float currentBet = [b getCurrentBet];
        
        if ((!b_bonus) && (!scater)) {
            winCoins = winCoins + (award *currentBet);
        }
    /* if (WinningAmountDividedBy<10&&WinningAmountDividedBy>0) {
        float givenAM = WinningAmountDividedBy;
        float devideBy = 1-(givenAM/10);
        winCoins = winCoins*devideBy;
    }
         winCoins = winCoins * WinningAmountMultiplyBy; REMOVE THIS TO ENABLE WINNINGAMOUNT...*/
       
        
        if (b_freespin) {
            if (award > 0) {
                spin_del = 1.f;
                
                float Allwin = [DB_ getValueBy:d_WinAllTime table:d_DB_Table];
                Allwin = Allwin + winCoins;
                [DB_ updateValue:d_WinAllTime table:d_DB_Table :Allwin];
                
                freeSpin_WIN = freeSpin_WIN + winCoins;
                
                [self runAction:[CCCallFuncO actionWithTarget:self selector:@selector(showFreeSpinWin:) object:half]].tag = scater_bonus_anim;
            }
            else{spin_del = 0.5f;}
        }
        else{
            if (award > 0 && (!b_bonus) && (!scater) && (freeSpins <= 0)) {
                
                [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:delay],[CCCallFuncO actionWithTarget:self selector:@selector(showWin:) object:half], nil]].tag = lineAnimationCount;
                    lineAnimationCount++;
                    delay += 1.0f;//schedule
            }
        }
    }
    
    if (freeSpins > 0) {
        [self freeSpins:freeSpins];
        //[(SlotMachine *)_parent setLabelOfFreeSpins:freeSpins];
    }
    
    if (!b_freespin) {
        
        if (boost2x)        {winCoins = winCoins *2;bigWinNum = bigWinNum *2;}
        else if (boost3x)   {winCoins = winCoins *3;bigWinNum = bigWinNum *3;}
        else if (boost4x)   {winCoins = winCoins *4;bigWinNum = bigWinNum *4;}
        else if (boost5x)   {winCoins = winCoins *5;bigWinNum = bigWinNum *5;}

    }
    
    //winCoins = winCoins *currentBet;
    
    if (winCoins > 0) {
        if (WinningAmountDividedBy<10&&WinningAmountDividedBy>0) {
            float givenAM = WinningAmountDividedBy;
            float devideBy = 1-(givenAM/10);
            winCoins = winCoins*devideBy;
        }
        NSLog(@"WinAmount BeforeMultiplied:%f",winCoins);
        winCoins = winCoins * WinningAmountMultiplyBy;
        NSLog(@"%f",winCoins);
        
        [AUDIO playEffect:s_winicon2];
        
        float totalBet = [b getTotalBet];
        
        if ((winCoins > totalBet *bigWinNum) && !b_freespin && !b_bonus) {
            //IS_BIG_WIN
            [(SlotMachine *)_parent bigWinCoins:winCoins];
            
            b_canSpin = false;
        }
        
        if (!b_freespin) {

            //[(SlotMachine *)_parent winCoinAnimation];
            
            [(SlotMachine *)_parent coinAnimation:(winCoins < 1) ? 1 : winCoins];
            
            [t addLastWin:winCoins];
        
            float coins_ = [DB_ getValueBy:d_Coins table:d_DB_Table];
            
            float finalCoins = coins_ + winCoins;
            
            [DB_ updateValue:d_Coins table:d_DB_Table :finalCoins];
            
            [t addCoins:winCoins];
            
            float Allwin = [DB_ getValueBy:d_WinAllTime table:d_DB_Table];
            Allwin = Allwin + winCoins;
            [DB_ updateValue:d_WinAllTime table:d_DB_Table :Allwin];
            
        }
        
    }
    
    winCoins = 0;
}

-(void)stopAllReels
{
    for(int k = 0; k < 5; k++)
    {
        CCSprite *reel_ = (CCSprite *)[self getChildByTag:kTAG_OF_REEL+k];
        CCSpeed *sp = (CCSpeed *)[reel_ getActionByTag:kTAG_OF_REEL+k];
        CCSpeed *sp2 = (CCSpeed *)[[self getChildByTag:(kTAG_OF_WIN_REELS + reel_.tag) - 50] getActionByTag:kTAG_OF_WIN_REEL_ACTION + (kTAG_OF_REEL+k)];
        
        if (sp) {
            [sp setSpeed:5.f];
            [sp2 setSpeed:5.f];
        }
        
    }
}

- (BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    //int a = [Exp returnExpPercentage:635];

    //NSLog(@"LVL::: %i",a);
    
    //[self setAutoSpin:NO];
    
    CGPoint location = [self convertTouchToNodeSpace:touch];
    if ((location.y> kHeightScreen*0.15f) && location.y < kHeightScreen*0.85f) {
    
        swipeY = location.y;
     
        if (CGRectContainsPoint(kHEIGHT_OF_LITTLE_BG.boundingBox, location))
        {
            for (int i  = 0; i<5; i++) {
                
                CCSprite *reel = (CCSprite *)[self getChildByTag:kTAG_OF_REEL+i];
                //NSLog(@"REEL_:  %f,%f",reel.contentSize.width,reel.contentSize.height);
                
                if (CGRectContainsPoint(reel.boundingBox, location))
                {
                    
                    //int secondInt = 2;
                    
                    if (i_touchCount == i) {
                        touchCount++;
                    }
                    i_touchCount = i;
                    
                    
                    if (touchCount == 1) {
                        
                        [self stopAllReels];
                        touchCount = 0;
                        i_touchCount = 5;
                        return YES;
                    }
                    else
                    {
                        CCSpeed *sp = (CCSpeed *)[reel getActionByTag:kTAG_OF_REEL+i];
                        CCSpeed *sp2 = (CCSpeed *)[[self getChildByTag:(kTAG_OF_WIN_REELS + reel.tag) - 50] getActionByTag:kTAG_OF_WIN_REEL_ACTION + (kTAG_OF_REEL+i)];
                        
                        if (sp) {
                            [sp setSpeed:5.f];
                            [sp2 setSpeed:5.f];
                        }
                        return YES;
                    }
                   
                }
            }
        }
    }
    else
    {
        return NO;
    }
    return YES;
}

- (void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint location = [self convertTouchToNodeSpace:touch];
    //if ((location.y> kHeightScreen*0.15f) && location.y < kHeightScreen*0.85f) {
        
        if (location.y < swipeY-20) {
            [self spin];
        }
    //}

}

-(void)touchEned
{
    
}

- (void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self touchEned];
}

- (void)ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [self touchEned];
}


-(void)dealloc
{
    [super dealloc];
}

@end
