#import "TopMenu.h"
#import "cfg.h"
#import "Constants.h"
#import "Menu.h"
#import "SCombinations.h"
#import "HelloWorldLayer.h"

#import "SimpleAudioEngine.h"
#import "Exp.h"
#import "WheelGame.h"
#import "CardGame.h"
#import "SlotMachine.h"
#import "WinsWindow.h"
#import "coinsFA.h"
#import "b6luxLoadingView.h"
#import "IDSTOREPLACE.h"


#define kTAGOFSTAR 222
#define kTAGOFEXPLBL 333
@implementation TopMenu



-(id)initWithRect:(CGRect)rect type:(int)TYPE experience:(int)EXP coins:(float)COINS
{
    if((self = [super init]))
    {
        self.position       = rect.origin;
        self.contentSize    = rect.size;
        counter = 0;
        
        int lvl = [Exp returnLevelByEXP:EXP];
        level_ = lvl;

        TOP_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_top_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_top_menu.plist"]];
        [self addChild:TOP_MENU_];
        
        
        settingsBtn_Active          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_settings_active.png"]];
        paytableBtn_Active          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_paytable_active.png"]];
        lobbyBtn_Active             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_lobby_active.png"]];
        buyBtn_Active               = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_menubuy_active.png"]];
        
        settingsBtn_notActive       = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_settings.png"]];
        paytableBtn_notActive       = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_paytable.png"]];
        lobbyBtn_notActive          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_lobby.png"]];
        buyBtn_notActive            = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_menubuy.png"]];
        
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        //Preloading background music
     //   [[SimpleAudioEngine sharedEngine] preloadBackgroundMusic:@"music_sample2.mp3"];

        //Preloading effects
      //  [[SimpleAudioEngine sharedEngine] preloadEffect:@"btn2.mp3"];

        menuType = TYPE;
        
        if      (TYPE == 1)
        {
            gamePlay = true;
        }
        else if (TYPE == 2)
        {
            gamePlay = false;
            //[[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"music_sample2.mp3"];//play background music
        }
        
        if (IS_IPAD)    { fSize = 16; lHeight = 3.5f; }
        
        //                        10            5.0
        else            { fSize = 10; lHeight = 5.0f; }
        
        exp_   = EXP;
        coins_ = COINS;
        
        if (TYPE == 1)
        {
            [self addMenuLine];
            [self addButtons];
            [self addScoreLabel];
            [self addWinLabel];
            [self addLevelLabel];
            [self addExpLabel];
        }
        else if (TYPE == 2)
        {
            [self addMenuLine];
            [self addButtons];
            [self addScoreLabel];
            [self addLevelLabel];
            [self addExpLabel];
        }
        
        [self addExpValue:exp_ scale:NO];
        [self addCoins:coins_];
        [self changeButtons_boundingBoxes];

        openSett = false;
        openPay  = false;
        
        progress_value = 0;
        sizee          = 0;
        
        int expPercents = [Exp returnExpPercentage:EXP];
      
        
        [self progressNumber:expPercents scale:NO];
        
//      [self addChild:[SCombinations boxWithColor:ccc4(100, 100, 120, 200) pos:self.position size:self.contentSize] z:999];
        
        [self activeButtons:YES];
 
    }
    
    return self;
}

-(void)addMenuLine
{
    menu_line = [CCSprite spriteWithSpriteFrameName:@"top_bar.png"];
    menu_line.anchorPoint = ccp(0.5f, 0.5f);
    menu_line.position = ccp(kWidthScreen / 2, kHeightScreen - menu_line.boundingBox.size.height/2);
    [TOP_MENU_ addChild:menu_line z:5];
}

-(void)addButtons
{    
// --------------------------------------------------------------------------------------------------------------------------
    setings_button              = [CCSprite spriteWithSpriteFrameName:@"btn_settings.png"];
    setings_button.anchorPoint  = ccp(0.5f, 0.5f);
    setings_button.position     = ccp(menu_line.position.x + (menu_line.boundingBox.size.width/2) - setings_button.boundingBox.size.width/1.2, menu_line.position.y);
    [TOP_MENU_ addChild:setings_button z:10];
// --------------------------------------------------------------------------------------------------------------------------
    expBg                       = [CCSprite spriteWithSpriteFrameName:@"exp_field.png"];
    expBg.anchorPoint           = ccp(0.5f, 0.5f);
    expBg.position              = ccp(menu_line.position.x - (menu_line.boundingBox.size.width/2) + expBg.boundingBox.size.width/1.5f, menu_line.position.y);
    [TOP_MENU_ addChild:expBg z:8];
    
    /// STAR
    
    expStar                     = [CCSprite spriteWithSpriteFrameName:@"exp_field_star.png"];
    expStar.anchorPoint         = ccp(0.5f, 0.5f);
    expStar.position            = ccp(expBg.position.x - (expBg.boundingBox.size.width/2), expBg.position.y);
    [self addChild:expStar z:11 tag:kTAGOFSTAR];
    
    
    progressSp                  = [CCSprite spriteWithSpriteFrameName:@"exp_field_fill.png"];
    //progressSp.anchorPoint      = ccp(0.f, 0.5f);
    //progressSp.scaleX           = 0.f;
    //progressSp.position         = ccp(expBg.position.x - (expBg.boundingBox.size.width/2.05f), expBg.position.y);
    
    ////////////////PROGRESS
    _progress                   = [CCProgressTimer progressWithSprite:progressSp];
    _progress.type              = kCCProgressTimerTypeBar;
    _progress.barChangeRate     = ccp(1,0);
    _progress.midpoint          = ccp(0.0,0.0f);
    //_progress.percentage        = 100;
    _progress.position        = ccp(expBg.position.x - (expBg.boundingBox.size.width/2.05f), expBg.position.y);
    //_progress.position          = ccp(0,0);
    _progress.anchorPoint       = ccp(0.f, 0.5f);

    [self addChild:_progress z:10];
    /////////////////////////////////
// --------------------------------------------------------------------------------------------------------------------------
    coinsBg                     = [CCSprite spriteWithSpriteFrameName:@"coins_field.png"];
    coinsBg.anchorPoint         = ccp(0.5f, 0.5f);
    if (gamePlay)
    { coinsBg.position          = ccp(expBg.position.x + (expBg.boundingBox.size.width/2) + coinsBg.boundingBox.size.width/1.9f, menu_line.position.y); }
    else
    {  coinsBg.position         = ccp(menu_line.position.x, menu_line.position.y); }
    
    [TOP_MENU_ addChild:coinsBg z:9];
    
    coins_button                = [CCSprite spriteWithSpriteFrameName:@"btn_menubuy.png"];
    coins_button.anchorPoint    = ccp(0.5f, 0.5f);
    coins_button.position       = ccp(coinsBg.position.x + (coinsBg.boundingBox.size.width/2.035f) - (coins_button.boundingBox.size.width/2), coinsBg.position.y - (coinsBg.boundingBox.size.height*0.015f));
    [self addChild:coins_button z:10];
    
    [coins_button addChild:[SCombinations boxWithColor:ccc4(100, 100, 120, 200) pos:self.position size:self.contentSize] z:999];
    
// --------------------------------------------------------------------------------------------------------------------------
    if (gamePlay)
    {
        winBg                     = [CCSprite spriteWithSpriteFrameName:@"exp_field.png"];
        winBg.anchorPoint         = ccp(0.5f, 0.5f);
        winBg.position        = ccp(coinsBg.position.x + (coinsBg.boundingBox.size.width/2) + winBg.boundingBox.size.width/1.8f, menu_line.position.y);
        [TOP_MENU_ addChild:winBg z:9];
    }
// --------------------------------------------------------------------------------------------------------------------------
    
    if (gamePlay)
    {
        lobby_button              = [CCSprite spriteWithSpriteFrameName:@"btn_lobby.png"];
        lobby_button.anchorPoint  = ccp(0.5f, 0.5f);
        lobby_button.position = ccp(winBg.position.x + (winBg.boundingBox.size.width/2) + lobby_button.boundingBox.size.width/1.8f, menu_line.position.y);
        [TOP_MENU_ addChild:lobby_button z:9];
    }
    else
    {
        lobby_button.position = ccp(kWidthScreen, kHeightScreen);
    }
// --------------------------------------------------------------------------------------------------------------------------
    if (gamePlay)
    {
        ptable_button             = [CCSprite spriteWithSpriteFrameName:@"btn_paytable.png"];
        ptable_button.anchorPoint = ccp(0.5f, 0.5f);
        ptable_button.position = ccp(lobby_button.position.x + (lobby_button.boundingBox.size.width/2) + ptable_button.boundingBox.size.width, menu_line.position.y);
        [TOP_MENU_ addChild:ptable_button z:9];
    }
    else
    {
        ptable_button.position = ccp(kWidthScreen, kHeightScreen);
    }
    // --------------------------------------------------------------------------------------------------------------------------
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addLevelLabel
{
    levelLabel = [CCLabelBMFont labelWithString:@"" fntFile:IS_IPAD ? ([Combinations isRetina]) ? kFONT_BIG : kFONT_MEDIUM  : kFONT_MEDIUM];
    levelLabel.anchorPoint = ccp(0.5f,0.5f);
    levelLabel.scale = 0.75f;
    if (iPhone3) { levelLabel.scale = 0.35f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        levelLabel.scale = 1.0;
    }
    levelLabel.alignment = kCCTextAlignmentCenter;
    levelLabel.position = ccp(expStar.contentSize.width/2.1f ,expStar.contentSize.height/2);
    levelLabel.color    = ccc3(69, 42, 4);
    
    
    [[self getChildByTag:kTAGOFSTAR] addChild:levelLabel z:1];
}

-(void)addLevelNr:(int)levelValue
{
    if (level_ < levelValue)
    {
        
        [(SlotMachine *)_parent levelUp:levelValue levelup:NO];
        
        [expStar runAction:[CCEaseInOut actionWithAction:[CCRotateBy actionWithDuration:0.5f angle:360] rate:1.5f]];
    }
    level_ = levelValue;
    
    [levelLabel setString:[NSString stringWithFormat:@"%d", level_]];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addExpLabel
{
    expLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    expLabel.position = ccp(expBg.position.x, expBg.position.y);
    expLabel.color    = ccWHITE;
    if (iPhone3) { expLabel.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD||IS_IPAD) {
        expLabel.scale = 1.6;
    }
    
    [self addChild:expLabel z:10];
}



-(void)scaleAction:(CCNode *)node_
{
    //float a = 1.1f;
    //float b = 1.0f;
    
    if (iPhone3) {
        //a = 0.75f;
        //b = 0.85f;
    }
    id buttonAnimation3 = [CCScaleTo actionWithDuration:0.05f scale:node_.scale + 0.1f];
    id buttonAnimation4 = [CCScaleTo actionWithDuration:0.1f  scale:node_.scale];
    
    //id buttonAnimation5 = [CCTintTo actionWithDuration:0.05f red:253 green:243 blue:217];
    //id buttonAnimation6 = [CCTintTo actionWithDuration:0.1f red:255 green:255 blue:255];
    //id spawn1           = [CCSpawn actions:buttonAnimation3,buttonAnimation5, nil];
    //id spawn2           = [CCSpawn actions:buttonAnimation4,buttonAnimation6, nil];
    
    id runAnimation2    = [CCSequence actions:buttonAnimation3, buttonAnimation4, nil];
    [node_ runAction:runAnimation2];

}
-(void)addExpValue:(float)expValue scale:(bool)bool_
{
    if (bool_) {
       [self scaleAction:expStar];
    }
    
    exp_ = expValue;
    
    // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
    NSString *stringFormated = [cfg formatTo3digitsValue:exp_];
    [expLabel setString:stringFormated];
    
    
    
    int lvl = [Exp returnLevelByEXP:exp_];
    [self addLevelNr:lvl];
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addWinLabel
{
    CCLabelTTF *winL = [CCLabelBMFont labelWithString:@"Win:" fntFile:kFONT_MENU];
    winL.anchorPoint  = ccp(0.5f, 0.5f);
    winL.position     = ccp((winBg.position.x - winBg.boundingBox.size.width*0.55) + winL.boundingBox.size.width, menu_line.position.y);
    winL.color        = ccWHITE;
    if (iPhone3) { winL.scale = 0.65f;  winL.position = ccp((winBg.position.x - winBg.boundingBox.size.width*0.60f) + winL.boundingBox.size.width, menu_line.position.y);}
    if (IS_STANDARD_IPHONE_6_PLUS) {
        winL.position = ccp((winBg.position.x - winBg.boundingBox.size.width*0.45 ) + winL.boundingBox.size.width, menu_line.position.y);
        winL.scale = 1.3;
    }
    if (IS_IPAD) {
        winL.scale = 1.3;
    }
    
    
    winLabel = [CCLabelBMFont labelWithString:@"0" fntFile:kFONT_MENU];
    winLabel.anchorPoint  = ccp(0.0f, 0.5f);
    winLabel.position = ccp(winBg.position.x - winBg.boundingBox.size.width*0.15f, menu_line.position.y);
    winLabel.color    = ccc3(233, 192, 0);
    if (iPhone3) { winLabel.scale = 0.65f;
    winLabel.position = ccp(winBg.position.x - winBg.boundingBox.size.width*0.1f, menu_line.position.y);}
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        //winLabel.position = ccp(winBg.position.x , menu_line.position.y);
        winLabel.scale = 1.3;
    }
    
    [self addChild:winL z:10];
    [self addChild:winLabel z:10];
    
}

-(void)addLastWin:(float)winValue
{
    win_ = winValue;
    
    NSString *numberString;
    
    if (win_ < 10  && win_ >= 0.1) {
        numberString = [NSString stringWithFormat:@"%.1f0", win_];
        [winLabel setString:numberString];
    }
    else
    {
        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
        NSString *stringFormated = [cfg formatTo3digitsValue:win_];
        [winLabel setString:stringFormated];
    }
    
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addScoreLabel
{
    //Create and add the score label as a child
    coinsLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    coinsLabel.anchorPoint  = ccp(0.5f, 0.5f);
    coinsLabel.position     = ccp(coinsBg.position.x - coins_button.boundingBox.size.width/3, menu_line.position.y);
    coinsLabel.color        = ccc3(233, 192, 0);
    if (iPhone3) { coinsLabel.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        coinsLabel.scale = 1.6;
    }
    
    [self addChild:coinsLabel z:9];
}

-(void)activeButtons:(bool)bool_
{
    buttonActive = bool_;
    
    if (bool_) {
   
        id tintIn = [CCTintTo actionWithDuration:0.1f red:255 green:255 blue:255];
        
        [lobby_button       runAction:tintIn];
        [setings_button     runAction:[tintIn copy]];
        [ptable_button      runAction:[tintIn copy]];
    }
    else
    {
        id tintOut = [CCTintTo actionWithDuration:0.1f red:130 green:130 blue:130];
        
        [lobby_button       runAction:tintOut];
        [setings_button     runAction:[tintOut copy]];
        [ptable_button      runAction:[tintOut copy]];
    }

}


-(void)txtAnimation:(ccTime)dt
{
    int i = [(coinsFA *)[_parent getChildByTag:675] getPowerByCoinsAmmount:coins_];
    //coinsFA *f = (coinsFA*)[_parent getChildByTag:675];
    int ff = 100;
    if (coins_ < 100) {
        ff = coins_;
    }
    
    float coinsSpeed = 3;
    
    if (coins_ > 1000 && coins_ < 50) {
        coinsSpeed = 2;
    }
    else if (coinsSpeed > 100000) {
        coinsSpeed = 1;
    }
    soundloop++;
   
    if ([cfg isNumber:soundloop devidableBy:coinsSpeed]) {
         [AUDIO playEffect:s_coinHit];
    }
    
   // [AUDIO playEffect:s_coinHit];
    //[SOUND_ playSound:s_coinHit looping:NO];
    
    counter+=(coins_ *0.03f)/((((ff/60)) + ((coins_ < 100) ? 0.1f : 0.7f)));
    
    NSString *numberString;
  
    if (final_coins < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", (final_coins - coins_) + counter];
        [coinsLabel setString:numberString];
    }
    else
    {
        numberString = [NSString stringWithFormat:@"%.0f", (final_coins - coins_) + counter];
        
        NSString *stringFormated = [cfg formatTo3digitsValue:numberString.floatValue];
        [coinsLabel setString:stringFormated];
    }
  //  l.scale = 1.1;
   
    if (((final_coins - coins_) + counter) >= final_coins) {
        
        if (final_coins < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", final_coins];
            [coinsLabel setString:numberString];
        }
        else
        {
           // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
             NSString *stringFormated = [cfg formatTo3digitsValue:final_coins];
            [coinsLabel setString:stringFormated];
        }
        
        
        //[coinsLabel setString:[NSString stringWithFormat:@"%@", numberString]];
        
        counter = 0;
        soundloop = 0;
        
        [self unschedule:@selector(txtAnimation:)];
        coinDropAnim = false;
        
    }
    
}
-(void)loading
{
    UIView *view__ = [[[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_MACHINE]autorelease];
    view__.tag = kLOADINGTAG;
    [[[CCDirector sharedDirector] openGLView]addSubview:view__];
    
}
-(void)minusCoins:(float)coins
{
    //float c = [DB_ getValueBy:d_Coins table:d_DB_Table];
    [DB_ updateValue:d_Coins table:d_DB_Table :coins];

    NSString *numberString;
    NSString *stringFormated = [cfg formatTo3digitsValue:coins];

    
    if (coins > 0.09 && coins < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", coins];
        [coinsLabel setString:numberString];
    }
    else
    {
        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
        [coinsLabel setString:stringFormated];
    }
    
    [self unschedule:@selector(txtAnimation:)];
    //[coinsLabel setString:stringFormated];

}

-(void)addCoins:(float)coinsValue
{
    coins_ = coinsValue;
    
    if (coins_ <= 0.1f) {
        [DB_ updateValue:d_WinAllTime table:d_DB_Table :0];
        [DB_ updateValue:d_LoseAllTime table:d_DB_Table :0];
    }
    
    final_coins = [DB_ getValueBy:d_Coins table:d_DB_Table];
    
   // [self scaleAction:coinsLabel];

    
    if (coins_ == final_coins) {
        
    
        NSString *numberString;
    
        if (coins_ > 0.09 && coins_ < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", coins_];
            [coinsLabel setString:numberString];
        }
        else
        {
            // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
            NSString *stringFormated = [cfg formatTo3digitsValue:coins_];
            [coinsLabel setString:stringFormated];
        }
        
        
        //formatter
        
//        float value = final_coins;
//        NSNumberFormatter * formatter = [NSNumberFormatter new];
//        [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
//        [formatter setMaximumFractionDigits:3]; // Set this if you need 2 digits
//        NSString * newString =  [formatter stringFromNumber:[NSNumber numberWithFloat:value]];
//        [coinsLabel setString:newString];
//        [formatter release];
        //
        
        
        
        return;
    }
    
    if (coinDropAnim) {
        [self unschedule:@selector(txtAnimation:)];
        NSString *numberString;
        
        if (final_coins > 0.09 && final_coins < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", final_coins];
            [coinsLabel setString:numberString];
        }
        else
        {
            // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
            NSString *stringFormated = [cfg formatTo3digitsValue:final_coins];
            [coinsLabel setString:stringFormated];
        }
        
        counter = 0;
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7f],[CCCallBlock actionWithBlock:^{
            coinDropAnim = true;
            [self schedule:@selector(txtAnimation:) interval:0.03f];
        }], nil]];
        
        return;
    }
    
    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.7f],[CCCallBlock actionWithBlock:^{
        coinDropAnim = true;
         [self schedule:@selector(txtAnimation:) interval:0.03f];
    }], nil]];
   
    
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)progressNumber:(float)progress_number scale:(bool)bool_
{
    if (bool_) {
        [self scaleAction:_progress];
        [self scaleAction:expLabel];
    }
    _progress.percentage = progress_number;
}

//////////////////////////////////////////////////////////////////////////////////////////// < -------------------------------------------------------------- >

/////////////////////////////////////////////////////////////////////
-(void) changeButtons_boundingBoxes
{
    buyButton_Rect               = coins_button.boundingBox;
    buyButton_Rect.origin.x      = buyButton_Rect.origin.x - buyButton_Rect.size.width/2;
    buyButton_Rect.origin.y      = buyButton_Rect.origin.y - buyButton_Rect.size.height/2;
    buyButton_Rect.size.width    = buyButton_Rect.size.width  * 2.0f;
    buyButton_Rect.size.height   = buyButton_Rect.size.height * 2.0f;
    
    settingsButton_Rect               = setings_button.boundingBox;
    settingsButton_Rect.origin.x      = settingsButton_Rect.origin.x - settingsButton_Rect.size.width/2;
    settingsButton_Rect.origin.y      = settingsButton_Rect.origin.y - settingsButton_Rect.size.height/2;
    settingsButton_Rect.size.width    = settingsButton_Rect.size.width  * 2.0f;
    settingsButton_Rect.size.height   = settingsButton_Rect.size.height * 2.0f;
    
    paytableButton_Rect               = ptable_button.boundingBox;
    paytableButton_Rect.origin.x      = paytableButton_Rect.origin.x - paytableButton_Rect.size.width/2;
    paytableButton_Rect.origin.y      = paytableButton_Rect.origin.y - paytableButton_Rect.size.height/2;
    paytableButton_Rect.size.width    = paytableButton_Rect.size.width  * 1.5f;
    paytableButton_Rect.size.height   = paytableButton_Rect.size.height * 1.5f;
    
    
}
/////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////////// < -------------------------------------------------------------- >


-(void) onEnter
{
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_Buttons swallowsTouches:NO];
    
    [super onEnter];
}
-(void)onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{

    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
    
    if (touchPos.y < kHeightScreen - menu_line.contentSize.height) {
        return NO;
    }

    CGRect r = lobby_button.boundingBox;
    
    r.origin.y = r.origin.y - r.size.height*2;
    r.size.height = r.size.height*5;
    
    ////////////// changed boundingox ////////////////////
    if ((CGRectContainsPoint(settingsButton_Rect, touchPos)) && buttonActive)
    {   
        [setings_button setDisplayFrame:settingsBtn_Active];
        
        openSett = true;
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncN actionWithTarget:self  selector:@selector(openSettingsWindow)], nil]];
      
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    ////////////// changed boundingox ////////////////////
    else if (CGRectContainsPoint(buyButton_Rect,   touchPos))
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        if ([self.parent isKindOfClass:[SlotMachine class]]) {
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                                  action:@"Clicked Store button"
                                                                   label:nil
                                                                   value:nil] build]];
        }else{
        
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Lobby"
                                                                  action:@"Clicked Store button"
                                                                   label:nil
                                                                   value:nil] build]];

        }
       
        [coins_button setDisplayFrame:buyBtn_Active];
        
        openSett = true;
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncO actionWithTarget:self selector:@selector(openBuyWindow_withNR:) object:[NSNumber numberWithInt:1]], nil]];
     [AUDIO playEffect:s_click1];
       /// [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    else if ((CGRectContainsPoint(r, touchPos)) && buttonActive)
    {
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.f],[CCCallFunc actionWithTarget:self selector:@selector(loading)], nil]];
        
        [lobby_button setDisplayFrame:lobbyBtn_Active];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Lobby button"
                                                               label:nil
                                                               value:nil] build]];

        sizee = 0;
    
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallBlock actionWithBlock:^{
            if ([_parent isKindOfClass:[Menu class]])
            {
            [_parent performSelector:@selector(closeTopMenu) withObject:nil];
            }
             [AUDIO playEffect:s_click1];
           // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
            [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];//node]];

            }], nil]];

        return NO;
    }
    
    ////////////// changed boundingox ////////////////////
    else if ((CGRectContainsPoint(paytableButton_Rect, touchPos)) && buttonActive)
    {
         [ptable_button setDisplayFrame:paytableBtn_Active];
        
        if (openPay == false && gamePlay == true)
        {
            openPay = true;
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFuncN actionWithTarget:self  selector:@selector(openPayTableWindow)], nil]];
             [AUDIO playEffect:s_click1];
           // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        }
    }

    
    
    return YES;
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    [setings_button setDisplayFrame:settingsBtn_notActive];
    [ptable_button setDisplayFrame:paytableBtn_notActive];
    [lobby_button setDisplayFrame:lobbyBtn_notActive];
    [coins_button setDisplayFrame:buyBtn_notActive];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
    
    openSett = false;
    openPay  = false;
    
    [setings_button setDisplayFrame:settingsBtn_notActive];
    [ptable_button setDisplayFrame:paytableBtn_notActive];
    [lobby_button setDisplayFrame:lobbyBtn_notActive];
    [coins_button setDisplayFrame:buyBtn_notActive];
    
    ////////////// changed boundingox ////////////////////
    if ((CGRectContainsPoint(settingsButton_Rect, touchPos)) && buttonActive)
    {
        if (openSett == false)
        {
//            openSett = true;
//            [self openSettingsWindow];
//            [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        }
        
    }
    ////////////// changed boundingox ////////////////////
    else if (CGRectContainsPoint(buyButton_Rect,   touchPos))
    {
        if (openSett == false)
        {
//            openSett = true;
//            [self openBuyWindow];
//            [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        }
        
    }
    
    else if ((CGRectContainsPoint(lobby_button.boundingBox, touchPos)) && buttonActive)
    {
//        sizee = 0;
//        
//        if ([_parent isKindOfClass:[Menu class]])
//        {
//            [_parent performSelector:@selector(closeTopMenu) withObject:nil];
//            [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
//        }
//        
//        [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer node]];
        
    }
    
    ////////////// changed boundingox ////////////////////
    else if ((CGRectContainsPoint(paytableButton_Rect, touchPos)) && buttonActive)
    {
       // sizee = sizee + 200;
        
       // [self progressNumber:sizee nextLevel:2500];
       // progressSp.scaleX = scaleXsize;
        
        
        
    }

}

-(void) fastBack
{
    CCScrollLayer *s = (CCScrollLayer *)[self getChildByTag:100];
    [s goFast];
}
-(void) openSettingsWindow
{
    if ([self.parent isKindOfClass:[SlotMachine class]]) {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Opened settings"
                                                               label:nil
                                                               value:nil] build]];

    }else{
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Lobby"
                                                              action:@"Opened settings"
                                                               label:nil
                                                               value:nil] build]];

    }
       PopupManager *SWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
    SWindow.anchorPoint = ccp(0, 0);
    [self addChild:SWindow z:15 tag:kSetWindowTAG];
    [SWindow setUp:kWindowSettings someValue:0];
}

-(void) openPayTableWindow
{
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                          action:@"Clicked Paytables button"
                                                           label:nil
                                                           value:nil] build]];
    PopupManager *PWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
    PWindow.anchorPoint = ccp(0, 0);
    [self addChild:PWindow z:15 tag:kPayWindowTAG];
    [PWindow setUp:kWindowPayTable someValue:0];
 
    
    
////////////////////// WHEEL GAME ////////////////////////////////
//    WheelGame *WGame = [[[WheelGame alloc] init] autorelease];
//    WGame.anchorPoint = ccp(0, 0);
//    [self addChild:WGame z:12 tag:kWheelGameTAG];
  
    
    
////////////////////// CARD GAME /////////////////////////////////
//    if ([self getChildByTag:kCardGameTAG] != nil) {
//        return;
//    }
//    CardGame *WGame = [[[CardGame alloc] init] autorelease];
//    WGame.anchorPoint = ccp(0, 0);
//    [self addChild:WGame z:12 tag:kCardGameTAG];
    
    
    
///////////////////// WIN WINDOW /////////////////////////////////
//    PopupManager *PWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
//    PWindow.anchorPoint = ccp(0, 0);
//    [self addChild:PWindow z:10 tag:kWinWindowTAG];
//    [PWindow setUp:kWindowWin someValue:2700];
    
    
    
///////////////////// NEW LEVEL WINDOW ///////////////////////////  
//    PopupManager *PWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
//    PWindow.anchorPoint = ccp(0, 0);
//    //PWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
//    [self addChild:PWindow z:10 tag:kNewWindowTAG];
//    [PWindow setUp:kWindowWin someValue:2002];
    
}

-(void) openBuyWindow_withNR:(NSNumber *)nr_
{
    switch (nr_.intValue)
    {
        case 1: BWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
            BWindow.anchorPoint = ccp(0, 0);
            if (![self getChildByTag:kBuyWindowTAG]) {
                [self addChild:BWindow z:15 tag:kBuyWindowTAG];
                [BWindow setUp:kWindowBuyCoins someValue:0];
            }
        
        break;
        case 2: BWindow = [[[PopupManager alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen)] autorelease];
            BWindow.anchorPoint = ccp(0, 0);
            if (![self getChildByTag:kBuyWindowTAG]) {
                [self addChild:BWindow z:15 tag:kBuyWindowTAG];
                [BWindow setUp:kWindowBuyBoosts someValue:0];
            }
            break;
        default: break;
    }
}

-(void) closeWindowSet
{
    [self removeChild:[self getChildByTag:kSetWindowTAG] cleanup:YES];
}

-(void) closeWindowPay
{
    [self removeChild:[self getChildByTag:kPayWindowTAG] cleanup:YES];
}
-(void) closeFreeCoinsWindow
{
    [self removeChild:[self getChildByTag:kFreeCoinsWindowTag] cleanup:YES];
}


-(void) closeWindowBuy
{
    [self removeChild:[self getChildByTag:kBuyWindowTAG] cleanup:YES];
}

-(void) closeWheelGame
{
    [self removeChild:[self getChildByTag:kWheelGameTAG] cleanup:YES];
}

-(void) closeCardGame
{
    [self removeChild:[self getChildByTag:kCardGameTAG] cleanup:YES];
}

-(void) closeWindowWin
{
    [self removeChild:[self getChildByTag:kWinWindowTAG] cleanup:YES];
}

-(void) closeWindowLvl
{
    [self removeChild:[self getChildByTag:kNewWindowTAG] cleanup:YES];
}

@end
