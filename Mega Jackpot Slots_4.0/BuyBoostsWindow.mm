#import "BuyBoostsWindow.h"
#import "PopupManager.h"
#import "BuyCoinsWindow.h"
#import "IDSTOREPLACE.h"

@implementation BuyBoostsWindow



-(id)initWithBool:(bool)bool_
{
    if((self = [super init]))
    {
        
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        
        //// SCALE EFFECT
        if (bool_) {
            self.scale = 0.3f;
            id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
            id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
            
            id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
            id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
            
            id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
            id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
            
            [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
        }
        
        BUY_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_buy_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_buy_menu.plist"]];
        [self addChild:BUY_MENU_ z:10];
        
        SETTINGS_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
        [self addChild:SETTINGS_MENU_ z:10];
        
        background             = [CCSprite spriteWithSpriteFrameName:@"buy_BG.png"];
        background.anchorPoint = ccp(0.5f, 0.5f);
        background.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [BUY_MENU_ addChild:background z:10];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }

        [self addCoinsButton];
        [self addBoostButton];
        [self addCloseButton];
        
        [self addBoostBlackBG];
        [self addBoostBuyButtons];
        [self addBoostSelectButtons];
        [self addSelectedBG];

        [self loadFrames];
        
        BOOSTx2 = true;
        [self changeSelectedBGposition];
        
        [self addBoostLabels];
        
        coinsBtn.visible = YES;
        boostBtn.visible = YES;
        
        [self addBoostPrices];
        
        [self changeBoostsPrices];
    }
    
    return self;
}
-(void) loadFrames
{
    selectedBoost2x    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_2x_active.png"]];
    selectedBoost3x    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_3xactive.png"]];
    selectedBoost4x    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_4x_active.png"]];
    selectedBoost5x    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_5x_active.png"]];
    
    NOTselectedBoost2x = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_2x.png"]];
    NOTselectedBoost3x = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_3x.png"]];
    NOTselectedBoost4x = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_4x.png"]];
    NOTselectedBoost5x = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_5x.png"]];
}

-(void) addBoostBlackBG
{
    blackBG                   = [CCSprite spriteWithSpriteFrameName:@"boost_bigBG.png"];
    blackBG.anchorPoint       = ccp(0.5f, 0.0f);
    blackBG.position          = ccp(background.position.x, background.position.y - background.boundingBox.size.height/2 + kHeightScreen*0.05f);
    [BUY_MENU_ addChild:blackBG z:11];
    

    brownBG1                   = [CCSprite spriteWithSpriteFrameName:@"boost_oneBG.png"];
    brownBG1.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG1.position          = ccp(blackBG.position.x - blackBG.boundingBox.size.width/2 + brownBG1.boundingBox.size.width/2 + kWidthScreen*0.014f, blackBG.position.y + blackBG.boundingBox.size.height/2);
    [BUY_MENU_ addChild:brownBG1 z:12];
    
    brownBG2                   = [CCSprite spriteWithSpriteFrameName:@"boost_oneBG.png"];
    brownBG2.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG2.position          = ccp(brownBG1.position.x + brownBG1.boundingBox.size.width + kWidthScreen*0.02f, blackBG.position.y + blackBG.boundingBox.size.height/2);
    [BUY_MENU_ addChild:brownBG2 z:12];
    
    brownBG3                   = [CCSprite spriteWithSpriteFrameName:@"boost_oneBG.png"];
    brownBG3.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG3.position          = ccp(brownBG2.position.x + brownBG2.boundingBox.size.width + kWidthScreen*0.02f, blackBG.position.y + blackBG.boundingBox.size.height/2);
    [BUY_MENU_ addChild:brownBG3 z:12];
    
    brownBG4                   = [CCSprite spriteWithSpriteFrameName:@"boost_oneBG.png"];
    brownBG4.anchorPoint       = ccp(0.5f, 0.5f);
    brownBG4.position          = ccp(brownBG3.position.x + brownBG3.boundingBox.size.width + kWidthScreen*0.02f, blackBG.position.y + blackBG.boundingBox.size.height/2);
    [BUY_MENU_ addChild:brownBG4 z:12];

}

-(void) addBoostBuyButtons
{
    buyButton1                   = [CCSprite spriteWithSpriteFrameName:@"boost_buy.png"];
    buyButton1.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton1.position          = ccp(brownBG1.position.x, brownBG1.position.y - brownBG1.boundingBox.size.height/2 + buyButton1.boundingBox.size.height/2);
    [BUY_MENU_ addChild:buyButton1 z:13];
    
    
    buyButton2                   = [CCSprite spriteWithSpriteFrameName:@"boost_buy.png"];
    buyButton2.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton2.position          = ccp(brownBG2.position.x, brownBG2.position.y - brownBG2.boundingBox.size.height/2 + buyButton2.boundingBox.size.height/2);
    [BUY_MENU_ addChild:buyButton2 z:13];
    
    buyButton3                   = [CCSprite spriteWithSpriteFrameName:@"boost_buy.png"];
    buyButton3.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton3.position          = ccp(brownBG3.position.x, brownBG3.position.y - brownBG3.boundingBox.size.height/2 + buyButton3.boundingBox.size.height/2);
    [BUY_MENU_ addChild:buyButton3 z:13];
    
    buyButton4                   = [CCSprite spriteWithSpriteFrameName:@"boost_buy.png"];
    buyButton4.anchorPoint       = ccp(0.5f, 0.5f);
    buyButton4.position          = ccp(brownBG4.position.x, brownBG4.position.y - brownBG4.boundingBox.size.height/2 + buyButton4.boundingBox.size.height/2);
    [BUY_MENU_ addChild:buyButton4 z:13];
    
    
    buyLabel1 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MEDIUM];
    buyLabel1.position        = ccp(buyButton1.position.x, buyButton1.position.y);
    buyLabel1.color           = ccc3(61, 70, 42);
    buyLabel1.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel1.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel1.scale = 1.6;
    }
    [self addChild:buyLabel1 z:15];
    
    buyLabel2 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MEDIUM];
    buyLabel2.position        = ccp(buyButton2.position.x, buyButton2.position.y);
    buyLabel2.color           = ccc3(61, 70, 42);
    buyLabel2.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel2.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel2.scale = 1.6;
    }
    [self addChild:buyLabel2 z:15];
    
    buyLabel3 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MEDIUM];
    buyLabel3.position        = ccp(buyButton3.position.x, buyButton3.position.y);
    buyLabel3.color           = ccc3(61, 70, 42);
    buyLabel3.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel3.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel3.scale = 1.6;
    }
    [self addChild:buyLabel3 z:15];
    
    buyLabel4 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MEDIUM];
    buyLabel4.position        = ccp(buyButton4.position.x, buyButton4.position.y);
    buyLabel4.color           = ccc3(61, 70, 42);
    buyLabel4.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel4.scale = 0.50f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel4.scale = 1.6;
    }
    [self addChild:buyLabel4 z:15];
}

-(void) addBoostSelectButtons
{
    buyBSelect1                   = [CCSprite spriteWithSpriteFrameName:@"boost_2x.png"];
    buyBSelect1.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect1.position          = ccp(brownBG1.position.x, brownBG1.position.y + brownBG1.boundingBox.size.height/2 + buyBSelect1.boundingBox.size.height/2 + kHeightScreen*0.025f);
    [BUY_MENU_ addChild:buyBSelect1 z:14];
    
    buyBSelect2                   = [CCSprite spriteWithSpriteFrameName:@"boost_3x.png"];
    buyBSelect2.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect2.position          = ccp(brownBG2.position.x, brownBG2.position.y + brownBG2.boundingBox.size.height/2 + buyBSelect2.boundingBox.size.height/2 + kHeightScreen*0.025f);
    [BUY_MENU_ addChild:buyBSelect2 z:14];
    
    buyBSelect3                   = [CCSprite spriteWithSpriteFrameName:@"boost_4x.png"];
    buyBSelect3.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect3.position          = ccp(brownBG3.position.x, brownBG3.position.y + brownBG3.boundingBox.size.height/2 + buyBSelect3.boundingBox.size.height/2 + kHeightScreen*0.025f);
    [BUY_MENU_ addChild:buyBSelect3 z:14];
    
    buyBSelect4                   = [CCSprite spriteWithSpriteFrameName:@"boost_5x.png"];
    buyBSelect4.anchorPoint       = ccp(0.5f, 0.5f);
    buyBSelect4.position          = ccp(brownBG4.position.x, brownBG4.position.y + brownBG4.boundingBox.size.height/2 + buyBSelect4.boundingBox.size.height/2 + kHeightScreen*0.025f);
    [BUY_MENU_ addChild:buyBSelect4 z:14];
}

-(void) addSelectedBG
{
    selectedBG                   = [CCSprite spriteWithSpriteFrameName:@"boost_activeBG.png"];
    selectedBG.anchorPoint       = ccp(0.5f, 0.5f);
    selectedBG.position          = ccp(buyBSelect1.position.x, buyBSelect1.position.y);
    [BUY_MENU_ addChild:selectedBG z:13];
}

-(void) changeSelectedBGposition
{
    if      (BOOSTx2)
    {
        selectedBG.position = ccp(buyBSelect1.position.x, buyBSelect1.position.y);
        
        [buyBSelect1 setDisplayFrame:selectedBoost2x];
        [buyBSelect2 setDisplayFrame:NOTselectedBoost3x];
        [buyBSelect3 setDisplayFrame:NOTselectedBoost4x];
        [buyBSelect4 setDisplayFrame:NOTselectedBoost5x];
    }
    
    else if (BOOSTx3)
    {
        selectedBG.position = ccp(buyBSelect2.position.x, buyBSelect2.position.y);
        
        [buyBSelect1 setDisplayFrame:NOTselectedBoost2x];
        [buyBSelect2 setDisplayFrame:selectedBoost3x];
        [buyBSelect3 setDisplayFrame:NOTselectedBoost4x];
        [buyBSelect4 setDisplayFrame:NOTselectedBoost5x];
    }
    
    else if (BOOSTx4)
    {
        selectedBG.position = ccp(buyBSelect3.position.x, buyBSelect3.position.y);
        
        [buyBSelect1 setDisplayFrame:NOTselectedBoost2x];
        [buyBSelect2 setDisplayFrame:NOTselectedBoost3x];
        [buyBSelect3 setDisplayFrame:selectedBoost4x];
        [buyBSelect4 setDisplayFrame:NOTselectedBoost5x];
    }
    
    else if (BOOSTx5)
    {
        selectedBG.position = ccp(buyBSelect4.position.x, buyBSelect4.position.y);
        
        [buyBSelect1 setDisplayFrame:NOTselectedBoost2x];
        [buyBSelect2 setDisplayFrame:NOTselectedBoost3x];
        [buyBSelect3 setDisplayFrame:NOTselectedBoost4x];
        [buyBSelect4 setDisplayFrame:selectedBoost5x];
    }
}

-(void) addCoinsButton
{
    coinsBtn                   = [CCSprite spriteWithSpriteFrameName:@"tab.png"];
    coinsBtn.anchorPoint       = ccp(0.5f, 0.5f);
    coinsBtn.position          = ccp(background.position.x - background.boundingBox.size.width/2 + coinsBtn.boundingBox.size.width*0.55f, background.position.y + background.boundingBox.size.height/2 + coinsBtn.boundingBox.size.height*0.35f);
    [BUY_MENU_ addChild:coinsBtn z:9];
    
    coinsLabel                 = [CCLabelBMFont labelWithString:@"COINS" fntFile:kFONT_BUY_TXT];
    coinsLabel.position        = ccp(coinsBtn.position.x, coinsBtn.position.y);
    coinsLabel.color           = ccc3(80, 65, 45);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        coinsLabel.scale = 1.6;
    }
    [self addChild:coinsLabel z:10];
}

-(void) addBoostButton
{
    boostBtn                   = [CCSprite spriteWithSpriteFrameName:@"tab_active.png"];
    boostBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boostBtn.position          = ccp(coinsBtn.position.x + coinsBtn.boundingBox.size.width/2 + boostBtn.boundingBox.size.width*0.55f, background.position.y + background.boundingBox.size.height/2 + boostBtn.boundingBox.size.height*0.35f);
    
    [BUY_MENU_ addChild:boostBtn z:9];
    
    boostsLabel                = [CCLabelBMFont labelWithString:@"BOOSTS" fntFile:kFONT_BUY_TXT];
    boostsLabel.position       = ccp(boostBtn.position.x, boostBtn.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostsLabel.scale = 1.6;
    }
    [self addChild:boostsLabel z:10];
}

-(void) addCloseButton
{
    closeBtn                   = [CCSprite spriteWithSpriteFrameName:@"menuBTN_close.png"];
    closeBtn.anchorPoint       = ccp(0.5f, 0.5f);
    closeBtn.position          = ccp(background.position.x + background.boundingBox.size.width/2, background.position.y + background.boundingBox.size.height/2);
    [SETTINGS_MENU_ addChild:closeBtn z:11];
}
///////////////////////////////////////////////////////////////////////////////////
-(void) onEnter
{
    //int priority = kCCMenuTouchPriority - 2;
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    [super onEnter];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}
///////////////////////////////////////////////////////////////////////////////////

-(void) addBoostLabels
{
    //--------------------------------
    CCLabelBMFont *boostTxt1    = [[[CCLabelBMFont alloc] initWithString:@"BOOSTS" fntFile:kFONT_MENU]autorelease];
    boostTxt1.anchorPoint       = ccp(0.5f, 0.0f);
    boostTxt1.color             = ccc3(233, 192, 0);
    if (iPhone3) { boostTxt1.scale = 0.50f; }
    if (IS_IPAD) { boostTxt1.position = ccpAdd(brownBG1.position, ccp(boostTxt1.boundingBox.size.width*0.50f, brownBG1.boundingBox.size.height*0.30f)); }
    else         { boostTxt1.position = ccpAdd(brownBG1.position, ccp(boostTxt1.boundingBox.size.width*0.40f, brownBG1.boundingBox.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt1.scale = 1.0;
    }
    [self addChild:boostTxt1 z:15];
    //--------------------------------
    CCLabelBMFont *boostTxt2    = [[[CCLabelBMFont alloc] initWithString:@"BOOSTS" fntFile:kFONT_MENU]autorelease];
    boostTxt2.anchorPoint       = ccp(0.5f, 0.0f);
    boostTxt2.color             = ccc3(233, 192, 0);
    if (iPhone3) { boostTxt2.scale = 0.50f; }
    if (IS_IPAD) { boostTxt2.position = ccpAdd(brownBG2.position, ccp(boostTxt2.boundingBox.size.width*0.50f, brownBG2.boundingBox.size.height*0.30f)); }
    else         { boostTxt2.position = ccpAdd(brownBG2.position, ccp(boostTxt2.boundingBox.size.width*0.40f, brownBG2.boundingBox.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt2.scale = 1.0;
    }
    [self addChild:boostTxt2 z:15];
    //--------------------------------
    CCLabelBMFont *boostTxt3    = [[[CCLabelBMFont alloc] initWithString:@"BOOSTS" fntFile:kFONT_MENU]autorelease];
    boostTxt3.anchorPoint       = ccp(0.5f, 0.0f);
    boostTxt3.color             = ccc3(233, 192, 0);
    if (iPhone3) { boostTxt3.scale = 0.50f; }
    if (IS_IPAD) { boostTxt3.position = ccpAdd(brownBG3.position, ccp(boostTxt3.boundingBox.size.width*0.50f, brownBG3.boundingBox.size.height*0.30f)); }
    else         { boostTxt3.position = ccpAdd(brownBG3.position, ccp(boostTxt3.boundingBox.size.width*0.40f, brownBG3.boundingBox.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt3.scale = 1.0;
    }
    [self addChild:boostTxt3 z:15];
    //--------------------------------
    CCLabelBMFont *boostTxt4    = [[[CCLabelBMFont alloc] initWithString:@"BOOSTS" fntFile:kFONT_MENU]autorelease];
    boostTxt4.anchorPoint       = ccp(0.5f, 0.0f);
    boostTxt4.color             = ccc3(233, 192, 0);
    if (iPhone3) { boostTxt4.scale = 0.50f; }
    if (IS_IPAD) { boostTxt4.position = ccpAdd(brownBG4.position, ccp(boostTxt4.boundingBox.size.width*0.50f, brownBG4.boundingBox.size.height*0.30f)); }
    else         { boostTxt4.position = ccpAdd(brownBG4.position, ccp(boostTxt4.boundingBox.size.width*0.40f, brownBG4.boundingBox.size.height*0.30f)); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostTxt4.scale = 1.0;
    }
    [self addChild:boostTxt4 z:15];
    //--------------------------------
    
    /////// ADD BOOST AMOUNT //////
    
    //--------------------------------
    boostNumber  = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    boostNumber.anchorPoint     = ccp(1.0f, 0.0f);
    boostNumber.color           = ccc3(233, 192, 0);
    if (iPhone3) { boostNumber.scale = 0.70f; }
    if (IS_IPAD) { boostNumber.position = ccp(boostTxt1.position.x - boostTxt1.boundingBox.size.width*0.80f, boostTxt1.position.y - boostTxt1.boundingBox.size.height*0.4f); }
    else         { boostNumber.position = ccp(boostTxt1.position.x - boostTxt1.boundingBox.size.width*0.70f, boostTxt1.position.y - boostTxt1.boundingBox.size.height*0.1f); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostNumber.scale = 1.50;
    }
    [self addChild:boostNumber z:15];
    //--------------------------------
    boostNumber2 = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    boostNumber2.anchorPoint    = ccp(1.0f, 0.0f);
    boostNumber2.color          = ccc3(233, 192, 0);
    if (iPhone3) { boostNumber2.scale = 0.70f; }
    if (IS_IPAD) { boostNumber2.position = ccp(boostTxt2.position.x - boostTxt2.boundingBox.size.width*0.80f, boostTxt2.position.y - boostTxt1.boundingBox.size.height*0.4f); }
    else         { boostNumber2.position = ccp(boostTxt2.position.x - boostTxt2.boundingBox.size.width*0.70f, boostTxt2.position.y - boostTxt1.boundingBox.size.height*0.1f); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostNumber2.scale = 1.5;
    }
    [self addChild:boostNumber2 z:15];
    //--------------------------------
    boostNumber3 = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    boostNumber3.anchorPoint    = ccp(1.0f, 0.0f);
    boostNumber3.color          = ccc3(233, 192, 0);
    if (iPhone3) { boostNumber3.scale = 0.70f; }
    if (IS_IPAD) { boostNumber3.position = ccp(boostTxt3.position.x - boostTxt3.boundingBox.size.width*0.80f, boostTxt3.position.y - boostTxt1.boundingBox.size.height*0.4f); }
    else         { boostNumber3.position = ccp(boostTxt3.position.x - boostTxt3.boundingBox.size.width*0.70f, boostTxt3.position.y - boostTxt1.boundingBox.size.height*0.1f); }
    if (boostNumber3) {
        boostNumber3.scale = 1.5;
    }
    [self addChild:boostNumber3 z:15];
    //--------------------------------
    boostNumber4 = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    boostNumber4.anchorPoint    = ccp(1.0f, 0.0f);
    boostNumber4.color          = ccc3(233, 192, 0);
    if (iPhone3) { boostNumber4.scale = 0.70f; }
    if (IS_IPAD) { boostNumber4.position = ccp(boostTxt4.position.x - boostTxt4.boundingBox.size.width*0.80f, boostTxt4.position.y - boostTxt1.boundingBox.size.height*0.4f); }
    else         { boostNumber4.position = ccp(boostTxt4.position.x - boostTxt4.boundingBox.size.width*0.70f, boostTxt4.position.y - boostTxt1.boundingBox.size.height*0.1f); }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        boostNumber4.scale = 1.5;
    }
    [self addChild:boostNumber4 z:15];
    //--------------------------------
}

-(void) addBoostPrices
{
    priceLabel1  = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    priceLabel1.anchorPoint     = ccp(0.5f, 0.5f);
    priceLabel1.color           = ccc3(255, 255, 255);
    if (iPhone3) { priceLabel1.scale = 0.80f; }
    priceLabel1.position        = ccp(buyButton1.position.x, brownBG1.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel1.scale = 1.5;
    }
    [self addChild:priceLabel1 z:15];
    
    priceLabel2  = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    priceLabel2.anchorPoint     = ccp(0.5f, 0.5f);
    priceLabel2.color           = ccc3(255, 255, 255);
    if (iPhone3) { priceLabel2.scale = 0.80f; }
    priceLabel2.position        = ccp(buyButton2.position.x, brownBG2.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel2.scale = 1.5;
    }
    [self addChild:priceLabel2 z:15];
    
    priceLabel3  = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    priceLabel3.anchorPoint     = ccp(0.5f, 0.5f);
    priceLabel3.color           = ccc3(255, 255, 255);
    if (iPhone3) { priceLabel3.scale = 0.80f; }
    priceLabel3.position        = ccp(buyButton3.position.x, brownBG3.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel3.scale = 1.5;
    }
    [self addChild:priceLabel3 z:15];
    
    priceLabel4  = [[[CCLabelBMFont alloc] initWithString:@"" fntFile:kFONT_BUY_TXT]autorelease];
    priceLabel4.anchorPoint     = ccp(0.5f, 0.5f);
    priceLabel4.color           = ccc3(255, 255, 255);
    if (iPhone3) { priceLabel4.scale = 0.80f; }
    priceLabel4.position        = ccp(buyButton4.position.x, brownBG4.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel4.scale = 1.5;
    }
    [self addChild:priceLabel4 z:15];
}

-(void) changeBoostsPrices
{
    ////////////////////////// CHANGE PRICES //////////////////////////
    if      (BOOSTx2) { [priceLabel1 setString:@"$1.99"];  [priceLabel2 setString:@"$2.99"];  [priceLabel3 setString:@"$3.99"];   [priceLabel4 setString:@"$4.99"];  }
    else if (BOOSTx3) { [priceLabel1 setString:@"$2.99"];  [priceLabel2 setString:@"$4.99"];  [priceLabel3 setString:@"$6.99"];   [priceLabel4 setString:@"$8.99"];  }
    else if (BOOSTx4) { [priceLabel1 setString:@"$6.99"];  [priceLabel2 setString:@"$8.99"];  [priceLabel3 setString:@"$14.99"];  [priceLabel4 setString:@"$19.99"]; }
    else if (BOOSTx5) { [priceLabel1 setString:@"$14.99"]; [priceLabel2 setString:@"$24.99"]; [priceLabel3 setString:@"$34.99"];  [priceLabel4 setString:@"$49.99"]; }
    
    ////////////////////////// CHANGE AMOUNT //////////////////////////
    if      (BOOSTx2) { [boostNumber setString:@"20"];  [boostNumber2 setString:@"40"];  [boostNumber3 setString:@"60"];   [boostNumber4 setString:@"80"];  }
    else if (BOOSTx3) { [boostNumber setString:@"20"];  [boostNumber2 setString:@"40"];  [boostNumber3 setString:@"80"];   [boostNumber4 setString:@"100"]; }
    else if (BOOSTx4) { [boostNumber setString:@"40"];  [boostNumber2 setString:@"80"];  [boostNumber3 setString:@"100"];  [boostNumber4 setString:@"120"]; }
    else if (BOOSTx5) { [boostNumber setString:@"80"];  [boostNumber2 setString:@"100"]; [boostNumber3 setString:@"150"];  [boostNumber4 setString:@"250"]; }
}

///////////////////////////////////////////////////////////////////////////////////


-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    framePressed    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_buy_active.png"]];
    closeFrame      = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close_active.png"]];
    
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [closeBtn setDisplayFrame:closeFrame];
    }
    
    else if (CGRectContainsPoint(coinsBtn.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if (CGRectContainsPoint(boostBtn.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
    }
    /////////////////////////////////////////////////////////////////
    else if (CGRectContainsPoint(buyBSelect1.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if (CGRectContainsPoint(buyBSelect2.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if (CGRectContainsPoint(buyBSelect3.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
    }
    
    else if (CGRectContainsPoint(buyBSelect4.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
    }
    /////////////////////////////////////////////////////////////////
    else if (CGRectContainsPoint(buyButton1.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyButton1 setDisplayFrame:framePressed];
        [self purchase:1];
    }
    
    else if (CGRectContainsPoint(buyButton2.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyButton2 setDisplayFrame:framePressed];
        [self purchase:2];
    }
    
    else if (CGRectContainsPoint(buyButton3.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyButton3 setDisplayFrame:framePressed];
        [self purchase:3];
    }
    
    else if (CGRectContainsPoint(buyButton4.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyButton4 setDisplayFrame:framePressed];
        [self purchase:4];
    }
    
    
    return YES;
}

-(void)purchase:(int)boostNR
{
    NSString* text = @"";
    if (BOOSTx2) {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_1_99 parent:self]; text = @"Clicked buy Boost2x for 1,99$";}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_2_99 parent:self]; text = @"Clicked buy Boost2x for 2,99$";}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_3_99 parent:self]; text = @"Clicked buy Boost2x for 3,99$";}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST2X_4_99 parent:self]; text = @"Clicked buy Boost2x for 4,99$";}
    }
    else if (BOOSTx3)
    {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_2_99 parent:self]; text = @"Clicked buy Boost3x for 2,99$";}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_4_99 parent:self]; text = @"Clicked buy Boost3x for 4,99$";}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_6_99 parent:self];text = @"Clicked buy Boost3x for 6,99$";}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST3X_8_99 parent:self];text = @"Clicked buy Boost3x for 8,99$";}
    }
    else if (BOOSTx4)
    {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_6_99 parent:self];text = @"Clicked buy Boost4x for 6,99$";}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_8_99 parent:self];text = @"Clicked buy Boost4x for 8,99$";}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_14_99 parent:self];text = @"Clicked buy Boost4x for 14,99$";}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST4X_19_99 parent:self];text = @"Clicked buy Boost4x for 19,99$";}
    }
    else if (BOOSTx5)
    {
        if(boostNR == 1)        {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_14_99 parent:self];text = @"Clicked buy Boost5x for 14,99$";}
        else if (boostNR == 2)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_24_99 parent:self];text = @"Clicked buy Boost5x for 24,99$";}
        else if (boostNR == 3)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_34_99 parent:self];text = @"Clicked buy Boost5x for 34,99$";}
        else if (boostNR == 4)  {[IAP_ requestProductsWithIndetifier:kIAP_I_BOOST5X_49_99 parent:self];text = @"Clicked buy Boost5x for 49,99$";}
    }
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                          action:text
                                                           label:nil
                                                           value:nil] build]];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    closeFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close.png"]];
    [closeBtn setDisplayFrame:closeFrame];
    
    frameNotPressed    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"boost_buy.png"]];
    [buyButton1 setDisplayFrame:frameNotPressed];
    [buyButton2 setDisplayFrame:frameNotPressed];
    [buyButton3 setDisplayFrame:frameNotPressed];
    [buyButton4 setDisplayFrame:frameNotPressed];
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [self closeWindow];
         //[AUDIO playEffect:s_click1];
       // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    else if (CGRectContainsPoint(coinsBtn.boundingBox, touchPos))
    {
       //  [AUDIO playEffect:s_click1];
     //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        boostBtn.visible = NO;
        coinsBtn.visible = NO;
        [self changeWindow];
    }
    
    else if (CGRectContainsPoint(boostBtn.boundingBox, touchPos))
    {
        
    }
    
    else if (CGRectContainsPoint(buyBSelect1.boundingBox, touchPos))
    { 
        BOOSTx2 = true; BOOSTx3 = false; BOOSTx4 = false; BOOSTx5 = false;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
        
    }
    
    else if (CGRectContainsPoint(buyBSelect2.boundingBox, touchPos))
    {
        BOOSTx2 = false; BOOSTx3 = true; BOOSTx4 = false; BOOSTx5 = false;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
    }
    
    else if (CGRectContainsPoint(buyBSelect3.boundingBox, touchPos))
    {
        BOOSTx2 = false; BOOSTx3 = false; BOOSTx4 = true; BOOSTx5 = false;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
    }
    
    else if (CGRectContainsPoint(buyBSelect4.boundingBox, touchPos))
    {
        BOOSTx2 = false; BOOSTx3 = false; BOOSTx4 = false; BOOSTx5 = true;
        [self changeSelectedBGposition];
        [self changeBoostsPrices];
    }
    
}


-(void) changeWindow
{
    
    
    if ([_parent isKindOfClass:[BuyCoinsWindow class]])
    {
        [_parent performSelector:@selector(closeBoostsWindow) withObject:nil];
    }
}

-(void) closeWindow
{
    id scale3       = [CCScaleTo actionWithDuration:0.2f scale:0.1f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    if ([_parent isKindOfClass:[PopupManager class]]) {
        [(PopupManager *)_parent removeBlackBG];
    }
    else if ([_parent isKindOfClass:[BuyCoinsWindow class]]) {
        [(BuyCoinsWindow *)_parent closeWindow];
    }
    
    [self runAction:[CCSequence actions:easeScale3,[CCCallBlock actionWithBlock:^{
        [self removeFromParentAndCleanup:YES];
    }], nil]];
}



@end
