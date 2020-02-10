#import "BuyCoinsWindow.h"
#import "PopupManager.h"
#import "BuyBoostsWindow.h"
#import "IDSTOREPLACE.h"

#define kBoostsTAG  11

@implementation BuyCoinsWindow


-(id)init_WithNumber:(int) nr_
{
    if((self = [super init]))
    {

        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        //// SCALE EFFECT
        
        self.scale = 0.3f;
        id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
        id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
        
        id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
        id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
        
        id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
        id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
        
        [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
        
        BUY_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_buy_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_buy_menu.plist"]];
        [self addChild:BUY_MENU_];
        
        SETTINGS_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
        [self addChild:SETTINGS_MENU_];
        
        background             = [CCSprite spriteWithSpriteFrameName:@"buy_BG.png"];
        background.anchorPoint = ccp(0.5f, 0.5f);
        background.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        [BUY_MENU_ addChild:background z:10];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        [self addCoinsButton];
        [self addBoostButton];
        [self addCloseButton];
        [self addFields];
        [self addCoinsIcons];
        [self addBuyCoinsButtons];
        [self addCoins_value_for_line1:@"350,000" for_line2:@"150,000" for_line3:@"40,000" for_line4:@"15,000" for_line5:@"4,000" for_line6:@"1,000"];
        [self addCoins_prices];
        [self addBonusPercent1:75 percent2:45 percent3:30 percent4:15 percent5:10 percent6:5];
        [self addEquallitySymbol];
        [self addCoinsIcons2];
        [self count_Final_Coins_Amount];
        
        [self addRedArrow];
        
        if (nr_ == 2)
        {
            coinsBtn.visible = NO;
            boostBtn.visible = NO;
            closeBtn.visible = NO;
            [self openBoostsWindow];
        }
    }
    
    return self;
}
-(void)addRedArrow
{
    CCSprite *s = [CCSprite spriteWithSpriteFrameName:@"buy_arrow0.png"];
    s.anchorPoint = ccp(0.5f, 0);
    s.position = ccp(bonusPercent1.position.x, bonusPercent1.position.y + bonusPercent1.contentSize.height/2);
    [BUY_MENU_ addChild:s z:10];
    
    CCSprite *s2 = [CCSprite spriteWithSpriteFrameName:@"buy_arrow.png"];
    s2.anchorPoint = ccp(0.5f, 0.9f);
    s2.position = ccp(s.position.x, s.position.y + s2.contentSize.height*0.65f);
    [BUY_MENU_ addChild:s2 z:20];
    
    [s2 runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCRepeat actionWithAction:[CCSequence actions:[CCSpawn actions:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.08f scaleX:0.9f scaleY:1.2f] rate:1.5f],[CCMoveBy actionWithDuration:0.08f position:ccp(0, -s2.contentSize.height*0.15f)], nil],[CCSpawn actions:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.065f scaleX:1.1f scaleY:0.9f] rate:1.5f],[CCMoveBy actionWithDuration:0.065f position:ccp(0, s2.contentSize.height*0.2f)], nil],[CCSpawn actions:[CCEaseInOut actionWithAction:[CCScaleTo actionWithDuration:0.045f scaleX:1.0f scaleY:1.f] rate:1.5f],[CCMoveBy actionWithDuration:0.045f position:ccp(0, -s2.contentSize.height*0.05f)], nil], nil] times:2],[CCDelayTime actionWithDuration:2.f], nil]]];


}

-(void) addCoinsButton
{
    coinsBtn                   = [CCSprite spriteWithSpriteFrameName:@"tab_active.png"];
    coinsBtn.anchorPoint       = ccp(0.5f, 0.5f);
    coinsBtn.position          = ccp(background.position.x - background.boundingBox.size.width/2 + coinsBtn.boundingBox.size.width*0.55f, background.position.y + background.boundingBox.size.height/2 + coinsBtn.boundingBox.size.height*0.35f);
    [BUY_MENU_ addChild:coinsBtn z:9];

    coinsLabel           = [CCLabelBMFont labelWithString:@"COINS" fntFile:kFONT_BUY_TXT];
    coinsLabel.position  = ccp(coinsBtn.position.x, coinsBtn.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        coinsLabel.scale = 1.6;
    }
    [self addChild:coinsLabel z:10];
}

-(void) addBoostButton
{
    boostBtn                   = [CCSprite spriteWithSpriteFrameName:@"tab.png"];
    boostBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boostBtn.position          = ccp(coinsBtn.position.x + coinsBtn.boundingBox.size.width/2 + boostBtn.boundingBox.size.width*0.55f, background.position.y + background.boundingBox.size.height/2 + boostBtn.boundingBox.size.height*0.35f);
    [BUY_MENU_ addChild:boostBtn z:9];
    
    boostsLabel           = [CCLabelBMFont labelWithString:@"BOOSTS" fntFile:kFONT_BUY_TXT];
    boostsLabel.position  = ccp(boostBtn.position.x, boostBtn.position.y);
    boostsLabel.color    = ccc3(80, 65, 45);
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

-(void) addFields
{
    field1                   = [CCSprite spriteWithSpriteFrameName:@"field.png"];
    field1.anchorPoint       = ccp(0.5f, 0.5f);
    field1.position          = ccp(kWidthScreen/2, background.position.y - background.boundingBox.size.height/2 + field1.boundingBox.size.height/2 + field1.boundingBox.size.height*0.6f);
    [BUY_MENU_ addChild:field1 z:11];
    
    field2                   = [CCSprite spriteWithSpriteFrameName:@"field.png"];
    field2.anchorPoint       = ccp(0.5f, 0.5f);
    field2.position          = ccp(kWidthScreen/2, field1.position.y + field2.boundingBox.size.height*1.3f);
    [BUY_MENU_ addChild:field2 z:11];
    
    field3                   = [CCSprite spriteWithSpriteFrameName:@"field.png"];
    field3.anchorPoint       = ccp(0.5f, 0.5f);
    field3.position          = ccp(kWidthScreen/2, field2.position.y + field3.boundingBox.size.height*1.3f);
    [BUY_MENU_ addChild:field3 z:11];
    
    field4                   = [CCSprite spriteWithSpriteFrameName:@"field.png"];
    field4.anchorPoint       = ccp(0.5f, 0.5f);
    field4.position          = ccp(kWidthScreen/2, field3.position.y + field4.boundingBox.size.height*1.3f);
    [BUY_MENU_ addChild:field4 z:11];
    
    field5                   = [CCSprite spriteWithSpriteFrameName:@"field.png"];
    field5.anchorPoint       = ccp(0.5f, 0.5f);
    field5.position          = ccp(kWidthScreen/2, field4.position.y + field5.boundingBox.size.height*1.3f);
    [BUY_MENU_ addChild:field5 z:11];
    
    field6                   = [CCSprite spriteWithSpriteFrameName:@"field.png"];
    field6.anchorPoint       = ccp(0.5f, 0.5f);
    field6.position          = ccp(kWidthScreen/2, field5.position.y + field6.boundingBox.size.height*1.3f);
    [BUY_MENU_ addChild:field6 z:11];
}

-(void) addCoinsIcons
{
    coinIco1                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco1.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco1.position          = ccp(field1.position.x - field1.boundingBox.size.width*0.46f, field1.position.y);
    [BUY_MENU_ addChild:coinIco1 z:12];
    
    coinIco2                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco2.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco2.position          = ccp(field2.position.x - field2.boundingBox.size.width*0.46f, field2.position.y);
    [BUY_MENU_ addChild:coinIco2 z:12];
    
    coinIco3                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco3.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco3.position          = ccp(field3.position.x - field3.boundingBox.size.width*0.46f, field3.position.y);
    [BUY_MENU_ addChild:coinIco3 z:12];
    
    coinIco4                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco4.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco4.position          = ccp(field4.position.x - field4.boundingBox.size.width*0.46f, field4.position.y);
    [BUY_MENU_ addChild:coinIco4 z:12];
    
    coinIco5                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco5.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco5.position          = ccp(field5.position.x - field5.boundingBox.size.width*0.46f, field5.position.y);
    [BUY_MENU_ addChild:coinIco5 z:12];
    
    coinIco6                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco6.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco6.position          = ccp(field6.position.x - field6.boundingBox.size.width*0.46f, field6.position.y);
    [BUY_MENU_ addChild:coinIco6 z:12];
}

-(void) addBuyCoinsButtons
{
    buyBtn6                   = [CCSprite spriteWithSpriteFrameName:@"btn_buy.png"];
    buyBtn6.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn6.position          = ccp(field1.position.x + field1.boundingBox.size.width*0.495f, field1.position.y);
    [BUY_MENU_ addChild:buyBtn6 z:12];
    
    buyLabel1                 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MENU];
    buyLabel1.position        = ccp(buyBtn6.position.x - buyBtn6.boundingBox.size.width/2, buyBtn6.position.y);
    buyLabel1.color           = ccc3(61, 70, 42);
    buyLabel1.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel1.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel1.scale = 1.6;
    }
    [self addChild:buyLabel1 z:13];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn5                   = [CCSprite spriteWithSpriteFrameName:@"btn_buy.png"];
    buyBtn5.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn5.position          = ccp(field2.position.x + field2.boundingBox.size.width*0.495f, field2.position.y);
    [BUY_MENU_ addChild:buyBtn5 z:12];
    
    buyLabel2                 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MENU];
    buyLabel2.position        = ccp(buyBtn5.position.x - buyBtn5.boundingBox.size.width/2, buyBtn5.position.y);
    buyLabel2.color           = ccc3(61, 70, 42);
    buyLabel2.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel2.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel2.scale = 1.6;
    }
    [self addChild:buyLabel2 z:13];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn4                   = [CCSprite spriteWithSpriteFrameName:@"btn_buy.png"];
    buyBtn4.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn4.position          = ccp(field3.position.x + field3.boundingBox.size.width*0.495f, field3.position.y);
    [BUY_MENU_ addChild:buyBtn4 z:12];
    
    buyLabel3                 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MENU];
    buyLabel3.position        = ccp(buyBtn4.position.x - buyBtn4.boundingBox.size.width/2, buyBtn4.position.y);
    buyLabel3.color           = ccc3(61, 70, 42);
    buyLabel3.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel3.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel3.scale = 1.6;
    }
    [self addChild:buyLabel3 z:13];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn3                   = [CCSprite spriteWithSpriteFrameName:@"btn_buy.png"];
    buyBtn3.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn3.position          = ccp(field4.position.x + field4.boundingBox.size.width*0.495f, field4.position.y);
    [BUY_MENU_ addChild:buyBtn3 z:12];
    
    buyLabel4                 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MENU];
    buyLabel4.position        = ccp(buyBtn3.position.x - buyBtn3.boundingBox.size.width/2, buyBtn3.position.y);
    buyLabel4.color           = ccc3(61, 70, 42);
    buyLabel4.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel4.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel4.scale = 1.6;
    }
    [self addChild:buyLabel4 z:13];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn2                   = [CCSprite spriteWithSpriteFrameName:@"btn_buy.png"];
    buyBtn2.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn2.position          = ccp(field5.position.x + field5.boundingBox.size.width*0.495f, field5.position.y);
    [BUY_MENU_ addChild:buyBtn2 z:12];
    
    buyLabel5                 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MENU];
    buyLabel5.position        = ccp(buyBtn2.position.x - buyBtn2.boundingBox.size.width/2, buyBtn2.position.y);
    buyLabel5.color           = ccc3(61, 70, 42);
    buyLabel5.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel5.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel5.scale = 1.6;
    }
    [self addChild:buyLabel5 z:13];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
    buyBtn1                   = [CCSprite spriteWithSpriteFrameName:@"btn_buy.png"];
    buyBtn1.anchorPoint       = ccp(1.0f, 0.5f);
    buyBtn1.position          = ccp(field6.position.x + field6.boundingBox.size.width*0.495f, field6.position.y);
    
    [BUY_MENU_ addChild:buyBtn1 z:12];
    
    buyLabel6                 = [CCLabelBMFont labelWithString:@"BUY" fntFile:kFONT_MENU];
    buyLabel6.position        = ccp(buyBtn1.position.x - buyBtn1.boundingBox.size.width/2, buyBtn1.position.y);
    buyLabel6.color           = ccc3(61, 70, 42);
    buyLabel6.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { buyLabel6.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        buyLabel6.scale = 1.6;
    }
    [self addChild:buyLabel6 z:13];
    //////////////////////////////////////////////////////////////////////////////////////////////////////////////
}

-(void) addCoins_value_for_line1:(NSString *)l1_ for_line2:(NSString *)l2_ for_line3:(NSString *)l3_ for_line4:(NSString *)l4_ for_line5:(NSString *)l5_ for_line6:(NSString *)l6_
{
    coinsAmount1 = l1_.floatValue; coinsAmount2 = l2_.floatValue; coinsAmount3 = l3_.floatValue; coinsAmount4 = l4_.floatValue; coinsAmount5 = l5_.floatValue; coinsAmount6 = l6_.floatValue;
    
    lineLabel1 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l6_] fntFile:kFONT_BUY_TXT];
    lineLabel1.position        = ccp(coinIco1.position.x + coinIco1.contentSize.width *0.85f, coinIco1.position.y);
    lineLabel1.opacity         = 110;
    lineLabel1.color           = ccc3(233, 192, 0);
    lineLabel1.anchorPoint     = ccp(0.0f, 0.5f);
    lineLabel1.scale           = 0.8f;
    if (iPhone3) { lineLabel1.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel1.scale = 1.6;
    }
    [self addChild:lineLabel1 z:13];
    
    lineLabel2 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l5_] fntFile:kFONT_BUY_TXT];
    lineLabel2.position        = ccp(coinIco2.position.x + coinIco2.contentSize.width *0.85f, coinIco2.position.y);
    lineLabel2.opacity         = 145;
    lineLabel2.scale           = 0.8f;
    lineLabel2.color           = ccc3(233, 192, 0);
    lineLabel2.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { lineLabel2.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel2.scale = 1.6;
    }
    [self addChild:lineLabel2 z:13];
    
    lineLabel3 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l4_] fntFile:kFONT_BUY_TXT];
    lineLabel3.position        = ccp(coinIco3.position.x + coinIco3.contentSize.width *0.85f, coinIco3.position.y);
    lineLabel3.opacity         = 160;
    lineLabel3.scale           = 0.8f;
    lineLabel3.color           = ccc3(233, 192, 0);
    lineLabel3.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { lineLabel3.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel3.scale = 1.6;
    }
    [self addChild:lineLabel3 z:13];
    
    lineLabel4 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l3_] fntFile:kFONT_BUY_TXT];
    lineLabel4.position        = ccp(coinIco4.position.x + coinIco4.contentSize.width *0.85f, coinIco4.position.y);
    lineLabel4.opacity         = 185;
    lineLabel4.scale           = 0.8f;
    lineLabel4.color           = ccc3(233, 192, 0);
    lineLabel4.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { lineLabel4.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel4.scale = 1.6;
    }
    [self addChild:lineLabel4 z:13];
    
    lineLabel5 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l2_] fntFile:kFONT_BUY_TXT];
    lineLabel5.position        = ccp(coinIco5.position.x + coinIco5.contentSize.width *0.85f, coinIco5.position.y);
    lineLabel5.opacity         = 200;
    lineLabel5.scale           = 0.8f;
    lineLabel5.color           = ccc3(233, 192, 0);
    lineLabel5.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { lineLabel5.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel5.scale = 1.6;
    }
    [self addChild:lineLabel5 z:13];
    
    lineLabel6 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l1_] fntFile:kFONT_BUY_TXT];
    lineLabel6.position        = ccp(coinIco6.position.x + coinIco6.contentSize.width *0.85f, coinIco6.position.y);
    lineLabel6.opacity         = 255;
    lineLabel6.scale           = 0.8f;
    lineLabel6.color           = ccc3(233, 192, 0);
    lineLabel6.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { lineLabel6.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        lineLabel6.scale = 1.6;
    }
    [self addChild:lineLabel6 z:13];
}

-(void) addCoins_prices
{
    priceLabel1 = [CCLabelBMFont labelWithString:@"$99,99" fntFile:kFONT_BUY_TXT];
    priceLabel1.position        = ccp(buyBtn1.position.x - buyBtn1.boundingBox.size.width*1.2f, buyBtn1.position.y);
    priceLabel1.color           = ccWHITE;
    priceLabel1.anchorPoint     = ccp(1.0f, 0.5f);
    if (iPhone3) { priceLabel1.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel1.scale = 1.6;
    }
    [self addChild:priceLabel1 z:13];
    
    priceLabel2 = [CCLabelBMFont labelWithString:@"$49,99" fntFile:kFONT_BUY_TXT];
    priceLabel2.position        = ccp(buyBtn2.position.x - buyBtn2.boundingBox.size.width*1.2f, buyBtn2.position.y);
    priceLabel2.color           = ccWHITE;
    priceLabel2.anchorPoint     = ccp(1.0f, 0.5f);
    if (iPhone3) { priceLabel2.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel2.scale = 1.6;
    }
    [self addChild:priceLabel2 z:13];
    
    priceLabel3 = [CCLabelBMFont labelWithString:@"$19,99" fntFile:kFONT_BUY_TXT];
    priceLabel3.position        = ccp(buyBtn3.position.x - buyBtn3.boundingBox.size.width*1.2f, buyBtn3.position.y);
    priceLabel3.color           = ccWHITE;
    priceLabel3.anchorPoint     = ccp(1.0f, 0.5f);
    if (iPhone3) { priceLabel3.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel3.scale = 1.6;
    }
    [self addChild:priceLabel3 z:13];
    
    priceLabel4 = [CCLabelBMFont labelWithString:@"$9,99" fntFile:kFONT_BUY_TXT];
    priceLabel4.position        = ccp(buyBtn4.position.x - buyBtn4.boundingBox.size.width*1.2f, buyBtn4.position.y);
    priceLabel4.color           = ccWHITE;
    priceLabel4.anchorPoint     = ccp(1.0f, 0.5f);
    if (iPhone3) { priceLabel4.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel4.scale = 1.6;
    }
    [self addChild:priceLabel4 z:13];
    
    priceLabel5 = [CCLabelBMFont labelWithString:@"$4,99" fntFile:kFONT_BUY_TXT];
    priceLabel5.position        = ccp(buyBtn5.position.x - buyBtn5.boundingBox.size.width*1.2f, buyBtn5.position.y);
    priceLabel5.color           = ccWHITE;
    priceLabel5.anchorPoint     = ccp(1.0f, 0.5f);
    if (iPhone3) { priceLabel5.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel5.scale = 1.6;
    }
    [self addChild:priceLabel5 z:13];
    
    priceLabel6 = [CCLabelBMFont labelWithString:@"$1,99" fntFile:kFONT_BUY_TXT];
    priceLabel6.position        = ccp(buyBtn6.position.x - buyBtn6.boundingBox.size.width*1.2f, buyBtn6.position.y);
    priceLabel6.color           = ccWHITE;
    priceLabel6.anchorPoint     = ccp(1.0f, 0.5f);
    if (iPhone3) { priceLabel6.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        priceLabel6.scale = 1.6;
    }
    [self addChild:priceLabel6 z:13];
}

-(NSString*)percenetSign
{
    return @"%";
}

-(void) addBonusPercent1:(int)p1_ percent2:(int)p2_ percent3:(int)p3_ percent4:(int)p4_ percent5:(int)p5_ percent6:(int)p6_
{
    if (IS_IPAD) { dis_ = 3.0f; }
    else         { if (iPhone3) { dis_ = 3.5f; } else { dis_ = 3.0f; }}
    
    bonusP1 = p1_; bonusP2 = p2_; bonusP3 = p3_; bonusP4 = p4_; bonusP5 = p5_; bonusP6 = p6_;

    bonusPercent1               = [CCSprite spriteWithSpriteFrameName:@"discountBG.png"];
    bonusPercent1.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent1.position      = ccp(coinIco1.position.x + lineLabel1.boundingBox.size.width*dis_, field6.position.y);
    [BUY_MENU_ addChild:bonusPercent1 z:13];
    
    bonusLabel1 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"+%d%@", p1_,[self percenetSign]] fntFile:kFONT_BUY_TXT];
    bonusLabel1.position        = ccp(bonusPercent1.position.x, bonusPercent1.position.y);
    bonusLabel1.color           = ccBLACK;
    bonusLabel1.scale           = 0.85f;
    bonusLabel1.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { bonusLabel1.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel1.scale = 1.6;
    }
    [self addChild:bonusLabel1 z:13];
    
    
    bonusPercent2               = [CCSprite spriteWithSpriteFrameName:@"discountBG.png"];
    bonusPercent2.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent2.position      = ccp(coinIco2.position.x + lineLabel1.boundingBox.size.width*dis_, field5.position.y);
    [BUY_MENU_ addChild:bonusPercent2 z:13];
    
    bonusLabel2 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"+%d%@", p2_,[self percenetSign]] fntFile:kFONT_BUY_TXT];
    bonusLabel2.position        = ccp(bonusPercent2.position.x, bonusPercent2.position.y);
    bonusLabel2.color           = ccBLACK;
    bonusLabel2.scale           = 0.85f;
    bonusLabel2.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { bonusLabel2.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel2.scale = 1.6;
    }
    [self addChild:bonusLabel2 z:13];
    
    
    bonusPercent3               = [CCSprite spriteWithSpriteFrameName:@"discountBG.png"];
    bonusPercent3.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent3.position      = ccp(coinIco3.position.x + lineLabel1.boundingBox.size.width*dis_, field4.position.y);
    [BUY_MENU_ addChild:bonusPercent3 z:13];
    
    bonusLabel3 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"+%d%@", p3_,[self percenetSign]] fntFile:kFONT_BUY_TXT];
    bonusLabel3.position        = ccp(bonusPercent3.position.x, bonusPercent3.position.y);
    bonusLabel3.color           = ccBLACK;
    bonusLabel3.scale           = 0.85f;
    bonusLabel3.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { bonusLabel3.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel3.scale = 1.6;
    }
    [self addChild:bonusLabel3 z:13];
    
    
    bonusPercent4               = [CCSprite spriteWithSpriteFrameName:@"discountBG.png"];
    bonusPercent4.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent4.position      = ccp(coinIco4.position.x + lineLabel1.boundingBox.size.width*dis_, field3.position.y);
    [BUY_MENU_ addChild:bonusPercent4 z:13];
    
    bonusLabel4 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"+%d%@", p4_,[self percenetSign]] fntFile:kFONT_BUY_TXT];
    bonusLabel4.position        = ccp(bonusPercent4.position.x, bonusPercent4.position.y);
    bonusLabel4.color           = ccBLACK;
    bonusLabel4.scale           = 0.85f;
    bonusLabel4.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { bonusLabel4.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel4.scale = 1.6;
    }
    [self addChild:bonusLabel4 z:13];
    
    
    bonusPercent5               = [CCSprite spriteWithSpriteFrameName:@"discountBG.png"];
    bonusPercent5.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent5.position      = ccp(coinIco5.position.x + lineLabel1.boundingBox.size.width*dis_, field2.position.y);
    [BUY_MENU_ addChild:bonusPercent5 z:13];
    
    bonusLabel5 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"+%d%@", p5_,[self percenetSign]] fntFile:kFONT_BUY_TXT];
    bonusLabel5.position        = ccp(bonusPercent5.position.x, bonusPercent5.position.y);
    bonusLabel5.color           = ccBLACK;
    bonusLabel5.scale           = 0.85f;
    bonusLabel5.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { bonusLabel5.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel5.scale = 1.6;
    }
    [self addChild:bonusLabel5 z:13];
    
    
    bonusPercent6               = [CCSprite spriteWithSpriteFrameName:@"discountBG.png"];
    bonusPercent6.anchorPoint   = ccp(0.5f, 0.5f);
    bonusPercent6.position      = ccp(coinIco6.position.x + lineLabel1.boundingBox.size.width*dis_, field1.position.y);
    [BUY_MENU_ addChild:bonusPercent6 z:13];
    
    bonusLabel6 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"+%d%@", p6_,[self percenetSign]] fntFile:kFONT_BUY_TXT];
    bonusLabel6.position        = ccp(bonusPercent6.position.x, bonusPercent6.position.y);
    bonusLabel6.color           = ccBLACK;
    bonusLabel6.scale           = 0.85f;
    bonusLabel6.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { bonusLabel6.scale = 0.70f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        bonusLabel6.scale = 1.6;
    }
    [self addChild:bonusLabel6 z:13];
  
}

-(void) addEquallitySymbol
{
    equal1 = [CCLabelBMFont labelWithString:@"=" fntFile:kFONT_BUY_TXT];
    equal1.position        = ccp(bonusPercent1.position.x + bonusPercent1.boundingBox.size.width*0.7f, bonusPercent1.position.y);
    equal1.color           = ccc3(233, 192, 0);
    equal1.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { equal1.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal1.scale = 1.6;
    }
    [self addChild:equal1 z:13];
    
    equal2 = [CCLabelBMFont labelWithString:@"=" fntFile:kFONT_BUY_TXT];
    equal2.position        = ccp(bonusPercent2.position.x + bonusPercent2.boundingBox.size.width*0.7f, bonusPercent2.position.y);
    equal2.color           = ccc3(233, 192, 0);
    equal2.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { equal2.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal2.scale = 1.6;
    }
    [self addChild:equal2 z:13];
    
    equal3 = [CCLabelBMFont labelWithString:@"=" fntFile:kFONT_BUY_TXT];
    equal3.position        = ccp(bonusPercent3.position.x + bonusPercent3.boundingBox.size.width*0.7f, bonusPercent3.position.y);
    equal3.color           = ccc3(233, 192, 0);
    equal3.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { equal3.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal3.scale = 1.6;
    }
    [self addChild:equal3 z:13];
    
    equal4 = [CCLabelBMFont labelWithString:@"=" fntFile:kFONT_BUY_TXT];
    equal4.position        = ccp(bonusPercent4.position.x + bonusPercent4.boundingBox.size.width*0.7f, bonusPercent4.position.y);
    equal4.color           = ccc3(233, 192, 0);
    equal4.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { equal4.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal4.scale = 1.6;
    }
    [self addChild:equal4 z:13];
    
    equal5 = [CCLabelBMFont labelWithString:@"=" fntFile:kFONT_BUY_TXT];
    equal5.position        = ccp(bonusPercent5.position.x + bonusPercent5.boundingBox.size.width*0.7f, bonusPercent5.position.y);
    equal5.color           = ccc3(233, 192, 0);
    equal5.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { equal5.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal5.scale = 1.6;
    }
    [self addChild:equal5 z:13];
    
    equal6 = [CCLabelBMFont labelWithString:@"=" fntFile:kFONT_BUY_TXT];
    equal6.position        = ccp(bonusPercent6.position.x + bonusPercent6.boundingBox.size.width*0.7f, bonusPercent6.position.y);
    equal6.color           = ccc3(233, 192, 0);
    equal6.anchorPoint     = ccp(0.5f, 0.5f);
    if (iPhone3) { equal6.scale = 0.65f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        equal6.scale = 1.6;
    }
    [self addChild:equal6 z:13];
}

-(void) addCoinsIcons2
{
    coinIco11                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco11.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco11.position          = ccp(equal1.position.x + equal1.boundingBox.size.width*2.5f, equal1.position.y);
    [BUY_MENU_ addChild:coinIco11 z:12];
    
    coinIco22                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco22.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco22.position          = ccp(equal2.position.x + equal2.boundingBox.size.width*2.5f, equal2.position.y);
    [BUY_MENU_ addChild:coinIco22 z:12];
    
    coinIco33                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco33.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco33.position          = ccp(equal3.position.x + equal3.boundingBox.size.width*2.5f, equal3.position.y);
    [BUY_MENU_ addChild:coinIco33 z:12];
    
    coinIco44                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco44.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco44.position          = ccp(equal4.position.x + equal4.boundingBox.size.width*2.5f, equal4.position.y);
    [BUY_MENU_ addChild:coinIco44 z:12];
    
    coinIco55                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco55.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco55.position          = ccp(equal5.position.x + equal5.boundingBox.size.width*2.5f, equal5.position.y);
    [BUY_MENU_ addChild:coinIco55 z:12];
    
    coinIco66                   = [CCSprite spriteWithSpriteFrameName:@"coin.png"];
    coinIco66.anchorPoint       = ccp(0.5f, 0.5f);
    coinIco66.position          = ccp(equal6.position.x + equal6.boundingBox.size.width*2.5f, equal6.position.y);
    [BUY_MENU_ addChild:coinIco66 z:12];
}

-(void) count_Final_Coins_Amount
{
   // fCoinsAmount1 = ((coinsAmount1*bonusP1) / 100) + coinsAmount1;
   // fCoinsAmount2 = ((coinsAmount2*bonusP2) / 100) + coinsAmount2;
   // fCoinsAmount3 = ((coinsAmount3*bonusP3) / 100) + coinsAmount3;
   // fCoinsAmount4 = ((coinsAmount4*bonusP4) / 100) + coinsAmount4;
   // fCoinsAmount5 = ((coinsAmount5*bonusP5) / 100) + coinsAmount5;
   // fCoinsAmount6 = ((coinsAmount6*bonusP6) / 100) + coinsAmount6;
    
    //NSLog(@"_____coinsAmoint1 : %d, bonusP1 : %d, fCoinsAmount1 : %d_____", coinsAmount1, bonusP1, fCoinsAmount1);
    
    [self setFinalCoins_amount_for_line1:@"612,500" for_line2:@"217,500" for_line3:@"52,000" for_line4:@"17,250" for_line5:@"4,400" for_line6:@"1,050"];
}

-(void) setFinalCoins_amount_for_line1:(NSString *)l1_ for_line2:(NSString *)l2_ for_line3:(NSString *)l3_ for_line4:(NSString *)l4_ for_line5:(NSString *)l5_ for_line6:(NSString *)l6_
{
    finalAmountLabel1 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l1_] fntFile:kFONT_BUY_TXT];
    finalAmountLabel1.position        = ccp(coinIco11.position.x + coinIco11.boundingBox.size.width, coinIco11.position.y);
    finalAmountLabel1.opacity         = 255;
    finalAmountLabel1.scale           = 1.1;
    finalAmountLabel1.color           = ccc3(233, 192, 0);
    finalAmountLabel1.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { finalAmountLabel1.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel1.scale = 1.6;
    }
    [self addChild:finalAmountLabel1 z:13];
    
    finalAmountLabel2 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l2_] fntFile:kFONT_BUY_TXT];
    finalAmountLabel2.position        = ccp(coinIco22.position.x + coinIco22.boundingBox.size.width, coinIco22.position.y);
    finalAmountLabel2.opacity         = 200;
    finalAmountLabel2.scale           = 1.1;
    finalAmountLabel2.color           = ccc3(233, 192, 0);
    finalAmountLabel2.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { finalAmountLabel2.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel2.scale = 1.6;
    }
    [self addChild:finalAmountLabel2 z:13];
    
    finalAmountLabel3 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l3_] fntFile:kFONT_BUY_TXT];
    finalAmountLabel3.position        = ccp(coinIco33.position.x + coinIco33.boundingBox.size.width, coinIco33.position.y);
    finalAmountLabel3.opacity         = 185;
    finalAmountLabel3.scale           = 1.1;
    finalAmountLabel3.color           = ccc3(233, 192, 0);
    finalAmountLabel3.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { finalAmountLabel3.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel3.scale = 1.6;
    }
    [self addChild:finalAmountLabel3 z:13];
    
    finalAmountLabel4 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l4_] fntFile:kFONT_BUY_TXT];
    finalAmountLabel4.position        = ccp(coinIco44.position.x + coinIco44.boundingBox.size.width, coinIco44.position.y);
    finalAmountLabel4.opacity         = 160;
    finalAmountLabel4.scale           = 1.1;
    finalAmountLabel4.color           = ccc3(233, 192, 0);
    finalAmountLabel4.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { finalAmountLabel4.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel4.scale = 1.6;
    }
    [self addChild:finalAmountLabel4 z:13];
    
    finalAmountLabel5 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l5_] fntFile:kFONT_BUY_TXT];
    finalAmountLabel5.position        = ccp(coinIco55.position.x + coinIco55.boundingBox.size.width, coinIco55.position.y);
    finalAmountLabel5.opacity         = 145;
    finalAmountLabel5.scale           = 1.1;
    finalAmountLabel5.color           = ccc3(233, 192, 0);
    finalAmountLabel5.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { finalAmountLabel5.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel5.scale = 1.6;
    }
    [self addChild:finalAmountLabel5 z:13];
    
    finalAmountLabel6 = [CCLabelBMFont labelWithString:[NSString stringWithFormat:@"%@", l6_] fntFile:kFONT_BUY_TXT];
    finalAmountLabel6.position        = ccp(coinIco66.position.x + coinIco66.boundingBox.size.width, coinIco66.position.y);
    finalAmountLabel6.opacity         = 110;
    finalAmountLabel6.scale           = 1.1;
    finalAmountLabel6.color           = ccc3(233, 192, 0);
    finalAmountLabel6.anchorPoint     = ccp(0.0f, 0.5f);
    if (iPhone3) { finalAmountLabel6.scale = 0.75f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        finalAmountLabel6.scale = 1.6;
    }
    [self addChild:finalAmountLabel6 z:13];
}

-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    [super onEnter];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}



-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    framePressed    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_buy_active.png"]];
    closeFrame      = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close_active.png"]];
    
//    id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:0.9f];
//    id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
//    id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [closeBtn setDisplayFrame:closeFrame];
        
    }
    
    if (CGRectContainsPoint(boostBtn.boundingBox, touchPos))
    {

        [AUDIO playEffect:s_click1];
        [buyBtn1 setTexture:[[CCSprite spriteWithSpriteFrameName:@"btn_buy_active.png"]CCtexture]];
    }
    ///////////////////////////////////////////////////////////// BUY BUTTONS //////////////////////////
    if (CGRectContainsPoint(buyBtn1.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyBtn1 setDisplayFrame:framePressed];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_99_99 parent:self];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                              action:@"Clicked buy Coins for 99,99$"
                                                               label:nil
                                                               value:nil] build]];

    }
    
    if (CGRectContainsPoint(buyBtn2.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyBtn2 setDisplayFrame:framePressed];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_49_99 parent:self];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                              action:@"Clicked buy Coins for 49,99$"
                                                               label:nil
                                                               value:nil] build]];

    }
    
    if (CGRectContainsPoint(buyBtn3.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyBtn3 setDisplayFrame:framePressed];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_19_99 parent:self];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                              action:@"Clicked buy Coins for 19,99$"
                                                               label:nil
                                                               value:nil] build]];

    }
    
    if (CGRectContainsPoint(buyBtn4.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyBtn4 setDisplayFrame:framePressed];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_9_99 parent:self];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                              action:@"Clicked buy Coins for 9,99$"
                                                               label:nil
                                                               value:nil] build]];

    }
    
    if (CGRectContainsPoint(buyBtn5.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyBtn5 setDisplayFrame:framePressed];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_4_99 parent:self];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                              action:@"Clicked buy Coins for 4,99$"
                                                               label:nil
                                                               value:nil] build]];

    }
    if (CGRectContainsPoint(buyBtn6.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [buyBtn6 setDisplayFrame:framePressed];
        [IAP_ requestProductsWithIndetifier:kIAP_I_COINS_1_99 parent:self];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                              action:@"Clicked buy Coins for 1,99$"
                                                               label:nil
                                                               value:nil] build]];

    }
    ////////////////////////////////////////////////////////////////////////////////////////////////////
    
    
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    closeFrame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close.png"]];
    [closeBtn setDisplayFrame:closeFrame];
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [self closeWindow];
        // [AUDIO playEffect:s_click1];
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    if (CGRectContainsPoint(boostBtn.boundingBox, touchPos))
    {
        coinsBtn.visible = NO;
        boostBtn.visible = NO;
        closeBtn.visible = NO;
        [self openBoostsWindow];
        // [AUDIO playEffect:s_click1];
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    CCSpriteFrame *frame = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_buy.png"]];
    [buyBtn1 setDisplayFrame:frame];
    [buyBtn2 setDisplayFrame:frame];
    [buyBtn3 setDisplayFrame:frame];
    [buyBtn4 setDisplayFrame:frame];
    [buyBtn5 setDisplayFrame:frame];
    [buyBtn6 setDisplayFrame:frame];

}

-(void) openBoostsWindow
{
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Store"
                                                          action:@"Switched to Boosts window"
                                                           label:nil
                                                           value:nil] build]];

    BuyBoostsWindow *BWindow = [[[BuyBoostsWindow alloc] initWithBool:NO] autorelease];
    BWindow.anchorPoint = ccp(0, 0);
    [self addChild:BWindow z:15 tag:kBoostsTAG];
}

-(void) closeBoostsWindow
{
    coinsBtn.visible = YES;
    boostBtn.visible = YES;
    closeBtn.visible = YES;
    [self removeChild:[self getChildByTag:kBoostsTAG] cleanup:YES];
}


-(void) closeWindow
{
    
    id scale3       = [CCScaleTo actionWithDuration:0.2f scale:0.1f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    if ([_parent isKindOfClass:[PopupManager class]]) {
        [(PopupManager *)_parent removeBlackBG];
    }
    
    [self runAction:[CCSequence actions:easeScale3,[CCCallBlock actionWithBlock:^{
        if ([_parent isKindOfClass:[PopupManager class]])
        {
            [_parent performSelector:@selector(closeBuyWindow) withObject:nil];
        }
    }], nil]];
    
}
























@end
