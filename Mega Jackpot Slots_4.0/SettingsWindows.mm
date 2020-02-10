#import "SettingsWindows.h"
#import "cfg.h"
#import "Constants.h"
#import "PopupManager.h"
#import "Reels.h"
#import "SlotMachine.h"
#import "IDSTOREPLACE.h"

@implementation SettingsWindows


-(NSString*)prefix
{
    if (IS_IPAD)return @"";return @"_iPhone";
}

-(id)init
{
    if((self = [super init]))
    {

    }
    
    return self;
}
-(void)setUp:(int)state
{
    [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
    
    state__ = state;
    //// SCALE EFFECT
    self.scale = 0.3f;
    id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.2f];
    id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
    
    id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
    id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
    
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
    
    
          SETTINGS_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
        [self addChild:SETTINGS_MENU_ z:12];

        
        background             = [CCSprite spriteWithSpriteFrameName:@"settingsMenuBG.png"];
        background.anchorPoint = ccp(0.5f, 0.5f);
        //background.scaleY      = 1.f;
        background.position    = ccp(kWidthScreen / 2, kHeightScreen / 2);
        [SETTINGS_MENU_ addChild:background];
        
        
        Btn_Active                 = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_active.png"]];
        Btn_notActive              = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN.png"]];
        Btn_Active2                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_active2.png"]];
        Btn_notActive2             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN2.png"]];
        closeBtn_Active            = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close_active.png"]];
        closeBtn_notActive         = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"menuBTN_close.png"]];
    
    if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
    

    
    
    /*
        // restore music button position
        if ([CDAudioManager sharedManager].backgroundMusic.volume == 1.0f)
        { B1on = true;}
        else if ([CDAudioManager sharedManager].backgroundMusic.volume == 0.0f)
        { B1on = false;}
        
        // restore sound fx button position
        if ([CDAudioManager sharedManager].soundEngine.masterGain == 1.0f)
        { B2on = true;}
        else if ([CDAudioManager sharedManager].soundEngine.masterGain == 0.0f)
        { B2on = false;}
   */
    
    
    //music on of settings
        
        [self addCloseButton];
    
        if (state == 1) {
            [self addButtonsBg];
        }
        else if (state == 2)
        {
            [self menuSett];
        }
    
    //    [self setOnOffLabelsOpacity];
    
    
    if (state == 2) {
        if ([_parent.parent.parent isKindOfClass:[SlotMachine class]]) {
            if(![(Reels *)[_parent.parent.parent getChildByTag:5] checkAutoSpin])
            {
                [autoSpinButton setDisplayFrame:Btn_notActive];
            }
            else
            {
                [autoSpinButton setDisplayFrame:Btn_Active];
            }
        }
    }
    
    
    
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
     //   NSLog(@"MUSIC MUST BE ON");
        [onLabel setString:@"ON"];
        onLabel.visible = YES;
        onLabel.opacity = 255;
        
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
      //  NSLog(@"MUSIC MUST BE OFF");
        [onLabel setString:@"OFF"];
    }
    
    if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
       // NSLog(@"sound MUST BE ON");
        [on2Label setString:@"ON"];
        on2Label.visible = YES;
        on2Label.opacity = 255;
    }
    else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
       // NSLog(@"sound MUST BE OFF");
        [on2Label setString:@"OFF"];
    }
    
    
}

-(void) addBlackBackground
{
    CCSprite *spr   = [CCSprite node];
    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
    spr.opacity     = 0;
    spr.anchorPoint = ccp(0, 0);
    spr.color       = ccc3(255,255,255);
    [self addChild:spr z:0 tag:kBlackBackgroundTAG];
}
-(void)menuSett
{
    show_LeaderBoardButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    show_LeaderBoardButton.anchorPoint  = ccp(0.5f, 0.5f);
    show_LeaderBoardButton.position     = ccp(kWidthScreen/2, background.position.y);
    [SETTINGS_MENU_ addChild:show_LeaderBoardButton z:10];
    
    show_AboutButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    show_AboutButton.anchorPoint  = ccp(0.5f, 0.5f);
    show_AboutButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y - show_LeaderBoardButton.contentSize.height*1.3f);
    [SETTINGS_MENU_ addChild:show_AboutButton z:10];
    
    button3              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    button3.anchorPoint  = ccp(0.5f, 0.5f);
    button3.position     = ccp(kWidthScreen/2, show_AboutButton.position.y - show_AboutButton.contentSize.height*1.3f);
    [SETTINGS_MENU_ addChild:button3 z:10];

    
    //    show_AchievementsButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    //    show_AchievementsButton.anchorPoint  = ccp(0.5f, 0.5f);
    //    show_AchievementsButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y + show_LeaderBoardButton.boundingBox.size.height/2 + kHeightScreen*0.07f);
    //    [SETTINGS_MENU_ addChild:show_AchievementsButton z:10];
    
    //    autoSpinButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    //    autoSpinButton.anchorPoint  = ccp(0.5f, 0.5f);
    //    autoSpinButton.position     = ccp(kWidthScreen/2, show_AchievementsButton.position.y + show_AchievementsButton.boundingBox.size.height/2 + kHeightScreen*0.07f);
    //    [SETTINGS_MENU_ addChild:autoSpinButton z:10];
    //
    
    // -----------------------------------------
    
    button1              = [CCSprite spriteWithSpriteFrameName:@"menuBTN2.png"];
    button1.anchorPoint  = ccp(0.0f, 0.5f);
    //button1.scaleX       = .5f;
    button1.position     = ccp(background.position.x - button1.contentSize.width*0.05f, background.position.y + background.boundingBox.size.height*0.25f);
    [SETTINGS_MENU_ addChild:button1 z:13];
    
    button2              = [CCSprite spriteWithSpriteFrameName:@"menuBTN2.png"];
    button2.anchorPoint  = ccp(0.0f, 0.5f);
    //button2.scaleX       = .5f;
    button2.position     = ccp(background.position.x - button1.contentSize.width*0.05f, background.position.y + background.boundingBox.size.height*0.14f);
    [SETTINGS_MENU_ addChild:button2 z:13];
    
    
    [self labels];

}
-(void)addButtonsBg
{
    
    autoSpinButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    autoSpinButton.anchorPoint  = ccp(0.5f, 0.5f);
    autoSpinButton.position     = ccp(kWidthScreen/2, background.position.y);
    [SETTINGS_MENU_ addChild:autoSpinButton z:10];
    
    show_LeaderBoardButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    show_LeaderBoardButton.anchorPoint  = ccp(0.5f, 0.5f);
    show_LeaderBoardButton.position     = ccp(kWidthScreen/2, autoSpinButton.position.y - autoSpinButton.contentSize.height*1.3f);
    [SETTINGS_MENU_ addChild:show_LeaderBoardButton z:10];
    
    show_AboutButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    show_AboutButton.anchorPoint  = ccp(0.5f, 0.5f);
    show_AboutButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y - show_LeaderBoardButton.contentSize.height*1.3f);
    [SETTINGS_MENU_ addChild:show_AboutButton z:10];
    
    
    button3              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    button3.anchorPoint  = ccp(0.5f, 0.5f);
    button3.position     = ccp(kWidthScreen/2, show_AboutButton.position.y - show_AboutButton.contentSize.height*1.3f);
    [SETTINGS_MENU_ addChild:button3 z:10];
    
    //    show_AchievementsButton              = [CCSprite spriteWithSpriteFrameName:@"menuBTN.png"];
    //    show_AchievementsButton.anchorPoint  = ccp(0.5f, 0.5f);
    //    show_AchievementsButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y + show_LeaderBoardButton.boundingBox.size.height/2 + kHeightScreen*0.07f);
    //    [SETTINGS_MENU_ addChild:show_AchievementsButton z:10];
    
        //
    
    // -----------------------------------------
    
    button1              = [CCSprite spriteWithSpriteFrameName:@"menuBTN2.png"];
    button1.anchorPoint  = ccp(0.0f, 0.5f);
    //button1.scaleX       = .5f;
    button1.position     = ccp(background.position.x - button1.contentSize.width*0.05f, background.position.y + background.boundingBox.size.height*0.25f);
    [SETTINGS_MENU_ addChild:button1 z:13];
    
    button2              = [CCSprite spriteWithSpriteFrameName:@"menuBTN2.png"];
    button2.anchorPoint  = ccp(0.0f, 0.5f);
    //button2.scaleX       = .5f;
    button2.position     = ccp(background.position.x - button1.contentSize.width*0.05f, background.position.y + background.boundingBox.size.height*0.14f);
    [SETTINGS_MENU_ addChild:button2 z:13];
    
    
    
    [self labels];
 
}
-(void)labels
{
    // ----------------LABELs-----------------------
    /////////////////////////////////////////////////////////////
    
    developedByLabel          = [CCLabelBMFont labelWithString:@"DEVELOPED BY" fntFile:kFONT_SETTINGS2];
    developedByLabel.position = ccp(kWidthScreen/2, background.position.y + background.boundingBox.size.height*0.35f);
    developedByLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    developedByLabel.opacity  = 0;
    if (iPhone3) { developedByLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        developedByLabel.scale = 1.15;
    }
    [self addChild:developedByLabel z:13];
    
    b6luxLabel          = [CCLabelBMFont labelWithString:@"Outlandish Apps LLC" fntFile:kFONT_SETTINGS];
    b6luxLabel.position = ccp(kWidthScreen/2, developedByLabel.position.y - background.boundingBox.size.height*0.07f);
    b6luxLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    b6luxLabel.opacity  = 0;
    if (iPhone3) { b6luxLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        b6luxLabel.scale = 1.15;
    }
    [self addChild:b6luxLabel z:13];
    
    
    
    /////////////////////////////////////////////////////////////
    
    codeLabel          = [CCLabelBMFont labelWithString:@"Updated By" fntFile:kFONT_SETTINGS2];
    codeLabel.position = ccp(kWidthScreen/2, b6luxLabel.position.y - background.boundingBox.size.height*0.10f);
    codeLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    codeLabel.opacity  = 0;
    if (iPhone3) { codeLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        codeLabel.scale = 1.15;
    }
    [self addChild:codeLabel z:13];
    
    eLabel          = [CCLabelBMFont labelWithString:@"Outlandish Apps LLC" fntFile:kFONT_SETTINGS];
    eLabel.position = ccp(kWidthScreen/2, codeLabel.position.y - background.boundingBox.size.height*0.07f);
    eLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    eLabel.opacity  = 0;
    if (iPhone3) { eLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        eLabel.scale = 1.15;
    }
    [self addChild:eLabel z:13];
    
    mLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_SETTINGS];
    mLabel.position = ccp(kWidthScreen/2, eLabel.position.y - background.boundingBox.size.height*0.05f);
    mLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    mLabel.opacity  = 0;
    if (iPhone3) { mLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        mLabel.scale = 1.3;
    }
    [self addChild:mLabel z:13];
    
    sLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_SETTINGS];
    sLabel.position = ccp(kWidthScreen/2, mLabel.position.y - background.boundingBox.size.height*0.05f);
    sLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    sLabel.opacity  = 0;
    if (iPhone3) { sLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        sLabel.scale = 1.3;
    }
    [self addChild:sLabel z:13];
    
    /////////////////////////////////////////////////////////////
    
    artLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_SETTINGS2];
    artLabel.position = ccp(kWidthScreen/2, sLabel.position.y - background.boundingBox.size.height*0.10f);
    artLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    artLabel.opacity  = 0;
    if (iPhone3) { artLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        artLabel.scale = 1.3;
    }
    [self addChild:artLabel z:13];
    
    jLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_SETTINGS];
    jLabel.position = ccp(kWidthScreen/2, artLabel.position.y - background.boundingBox.size.height*0.05f);
    jLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    jLabel.opacity  = 0;
    if (iPhone3) { jLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        jLabel.scale = 1.3;
    }
    [self addChild:jLabel z:13];
    
    /////////////////////////////////////////////////////////////
    
    NSString *musicInfo = @"";
    
    toolsLabel          = [CCLabelBMFont labelWithString:musicInfo fntFile:kFONT_SETTINGS];
    toolsLabel.position = ccp(kWidthScreen/2, jLabel.position.y - background.boundingBox.size.height*0.10f);
    toolsLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    toolsLabel.opacity  = 0;
    toolsLabel.alignment = kCCTextAlignmentCenter;
    if (iPhone3) { toolsLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        toolsLabel.scale = 1.2;
    }
    [self addChild:toolsLabel z:13];
    
    
    /*
    cocos2dLabel          = [CCLabelBMFont labelWithString:@"COCOS2D" fntFile:kFONT_SETTINGS];
    cocos2dLabel.position = ccp(kWidthScreen/2, toolsLabel.position.y - background.boundingBox.size.height*0.05f);
    cocos2dLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    cocos2dLabel.opacity  = 0;
    if (iPhone3) { cocos2dLabel.scale = 0.60f; }
    [self addChild:cocos2dLabel z:13];
    */
    /////////////////////////////////////////////////////////////
    
    musicLabel          = [CCLabelBMFont labelWithString:@"MUSIC" fntFile:kFONT_SETTINGS];
    musicLabel.position = ccp(background.position.x - background.boundingBox.size.width*0.2f, button1.position.y);
    musicLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { musicLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        musicLabel.scale = 1.6;
    }
    [self addChild:musicLabel z:13];
    
    
    soundLabel          = [CCLabelBMFont labelWithString:@"SOUND" fntFile:kFONT_SETTINGS];
    soundLabel.position = ccp(background.position.x - background.boundingBox.size.width*0.2f, button2.position.y);
    soundLabel.color    = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { soundLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        soundLabel.scale = 1.6;
    }
    [self addChild:soundLabel z:13];
    
    
    menuLabel           = [CCLabelBMFont labelWithString:@"MENU" fntFile:kFONT_SETTINGS2];
    menuLabel.position  = ccp(kWidthScreen/2, background.position.y + background.boundingBox.size.height/2 - kHeightScreen*0.05f);
    menuLabel.color     = ccWHITE; //ccc3(69, 42, 4);
    //                             stock = .60
    if (iPhone3) { menuLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        
    //                stock = 1.6
        menuLabel.scale = 1.4;
    }
    [self addChild:menuLabel z:13];
    
    //------------------------------------------
    onLabel           = [CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
    onLabel.position  = ccp(button1.position.x + button1.boundingBox.size.width/2, button1.position.y);
    onLabel.color     = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { onLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        onLabel.scale = 1.6;
    }
    [self addChild:onLabel z:12];
    
    //
    on2Label           = [CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
    on2Label.position  = ccp(button2.position.x + button2.boundingBox.size.width/2, button2.position.y);
    on2Label.color     = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { on2Label.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        on2Label.scale = 1.6;
    }
    [self addChild:on2Label z:12];
    
 /*
    offLabel           = [CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
//    offLabel.position  = ccp(button1.position.x + button1.boundingBox.size.width/2, button1.position.y);
//    offLabel.color     = ccWHITE; //ccc3(69, 42, 4);
//    if (iPhone3) { offLabel.scale = 0.60f; }
//    [self addChild:offLabel z:12];

    off2Label           = [CCLabelBMFont labelWithString:@"ON" fntFile:kFONT_SETTINGS];
//    off2Label.position  = ccp(button2.position.x + button2.boundingBox.size.width/2, button2.position.y);
//    off2Label.color     = ccWHITE; //ccc3(69, 42, 4);
//    if (iPhone3) { off2Label.scale = 0.60f; }
//    [self addChild:off2Label z:12];
   */
    
    showLBlabel             = [CCLabelBMFont labelWithString:@"LEADERBOARDS" fntFile:kFONT_SETTINGS];
    showLBlabel.anchorPoint = ccp(0.5f, 0.5f);
    showLBlabel.position    = ccp(show_LeaderBoardButton.position.x, show_LeaderBoardButton.position.y);
    showLBlabel.color       = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { showLBlabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        showLBlabel.scale = 1.6;
    }
    [self addChild:showLBlabel z:13];
    
    
    //    showAClabel             = [CCLabelBMFont labelWithString:@"ACHIEVEMENTS" fntFile:kFONT_SETTINGS];
    //    showAClabel.anchorPoint = ccp(0.5f, 0.5f);
    //    showAClabel.position    = ccp(show_AchievementsButton.position.x, show_AchievementsButton.position.y);
    //    showAClabel.color       = ccWHITE; //ccc3(69, 42, 4);
    //    if (iPhone3) { showAClabel.scale = 0.60f; }
    //    [self addChild:showAClabel z:13];
    //
    if (state__ == 1) {
        
        autoSpinLabel             = [CCLabelBMFont labelWithString:@"AUTOSPIN" fntFile:kFONT_SETTINGS];
        autoSpinLabel.anchorPoint = ccp(0.5f, 0.5f);
        autoSpinLabel.position    = ccp(autoSpinButton.position.x, autoSpinButton.position.y);
        autoSpinLabel.color       = ccWHITE; //ccc3(69, 42, 4);
        if (iPhone3) { autoSpinLabel.scale = 0.60f; }
        if (IS_STANDARD_IPHONE_6_PLUS) {
            autoSpinLabel.scale = 1.6;
        }
        [self addChild:autoSpinLabel z:13];
        

    }
    
    aboutButtonLabel             = [CCLabelBMFont labelWithString:@"ABOUT" fntFile:kFONT_SETTINGS];
    aboutButtonLabel.anchorPoint = ccp(0.5f, 0.5f);
    aboutButtonLabel.position    = ccp(show_AboutButton.position.x, show_AboutButton.position.y);
    aboutButtonLabel.color       = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { aboutButtonLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        aboutButtonLabel.scale = 1.6;
    }
    [self addChild:aboutButtonLabel z:13];
    
    ContactUs    = [CCLabelBMFont labelWithString:@"Email Support" fntFile:kFONT_SETTINGS];
    ContactUs.anchorPoint = ccp(0.5f, 0.5f);
    ContactUs.position    = ccp(button3.position.x, button3.position.y);
    ContactUs.color       = ccWHITE; //ccc3(69, 42, 4);
    if (iPhone3) { ContactUs.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS) {
        ContactUs.scale = 1.6;
    }
    [self addChild:ContactUs z:13];
    //------------------------------------


}
-(void) setOnOffLabelsOpacity
{
    if (B1on == true)   { onLabel.opacity = 0; offLabel.opacity = 255; }
    else                { onLabel.opacity = 255; offLabel.opacity = 0; }
    
    if (B2on == true)   { on2Label.opacity = 0; off2Label.opacity = 255; }
    else                { on2Label.opacity = 255; off2Label.opacity = 0; }
}

-(void) addCloseButton
{
    closeBtn                   = [CCSprite spriteWithSpriteFrameName:@"menuBTN_close.png"];
    closeBtn.anchorPoint       = ccp(0.5f, 0.5f);
    closeBtn.position          = ccp(background.position.x + background.boundingBox.size.width/2, background.position.y + background.boundingBox.size.height/2);
    [SETTINGS_MENU_ addChild:closeBtn z:9];
}

-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    if ([_parent.parent.parent isKindOfClass:[SlotMachine class]]) {
        [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:5];
    }else{
        [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:3];
    }

    [super onEnter];
}
- (void) mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    [((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController dismissViewControllerAnimated:YES completion:NULL];
}
-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    if ([_parent.parent.parent isKindOfClass:[SlotMachine class]]) {
        [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:6];
    }else{
        [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:4];
    }
    [super onExit];
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];

    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        b7 = true;
        
        [AUDIO playEffect:s_click1];
        [closeBtn setDisplayFrame:closeBtn_Active];
    }

    if (CGRectContainsPoint(button1.boundingBox, touchPos))
    {
        b1 = true;
        [button1 setDisplayFrame:Btn_Active2];
    }
    
    if (CGRectContainsPoint(button2.boundingBox, touchPos))
    {
        b2 = true;
        [button2 setDisplayFrame:Btn_Active2];
    }
    
    if (CGRectContainsPoint(autoSpinButton.boundingBox, touchPos))
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Autospin"
                                                               label:nil
                                                               value:nil] build]];

        b3 = true;
        if ([_parent.parent.parent isKindOfClass:[SlotMachine class]]) {
            //NSLog(@"PAR::   %@",_parent.parent.parent);
            
            if(![(Reels *)[_parent.parent.parent getChildByTag:5] checkAutoSpin])
            {
                float c = [DB_ getValueBy:d_Coins table:d_DB_Table];
                
                if (c > 0) {
                    [(Reels *)[_parent.parent.parent getChildByTag:5] setAutoSpin:YES];
                    [autoSpinButton setDisplayFrame:Btn_Active];
                    [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCCallFunc actionWithTarget:self  selector:@selector(closeSettingsWindow2)], nil]];
                }
                else
                {
                    [(TopMenu *)[_parent.parent.parent getChildByTag:kTopMenuTAG] openBuyWindow];
                }
            }
            else
            {
                [(Reels *)[_parent.parent.parent getChildByTag:5] setAutoSpin:NO];
                [autoSpinButton setDisplayFrame:Btn_notActive];
            }
        }
    }
    
    if (CGRectContainsPoint(show_LeaderBoardButton.boundingBox, touchPos))
    {
        b4 = true;
        [show_LeaderBoardButton setDisplayFrame:Btn_Active];
    }
    if (CGRectContainsPoint(button3.boundingBox, touchPos))
    {
        b15 = true;
        [button3 setDisplayFrame:Btn_Active];
    }
    if (CGRectContainsPoint(show_AchievementsButton.boundingBox, touchPos))
    {
        b5 = true;
        [show_AchievementsButton setDisplayFrame:Btn_Active];
    }
    if (CGRectContainsPoint(show_AboutButton.boundingBox, touchPos))
    {
        b6 = true;
        [show_AboutButton setDisplayFrame:Btn_Active];
    }
    
                      
    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        b7 = true;
        [closeBtn setDisplayFrame:closeBtn_notActive];
        [self closeSettingsWindow2];
    }
    
    if (CGRectContainsPoint(button1.boundingBox, touchPos))
    {
        //music
        
        if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
            [onLabel setString:@"OFF"];
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                                  action:@"Turned Music Off"
                                                                   label:nil
                                                                   value:nil] build]];
            AUDIO.backgroundMusicVolume = 0;
            [Combinations saveNSDEFAULTS_Bool:NO forKey:sound_music];
        }
        else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_music]) {
            [onLabel setString:@"ON"];
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                                  action:@"Turned Music ON"
                                                                   label:nil
                                                                   value:nil] build]];

            if ( [(AppController *)[[UIApplication sharedApplication] delegate]inMenu]) {
                 AUDIO.backgroundMusicVolume = 0.5f;
            }
            else AUDIO.backgroundMusicVolume = 0.35f;
           [Combinations saveNSDEFAULTS_Bool:YES forKey:sound_music];
        }
        
        /*
        if (B1on == false)
        {
            B1on = true;
            NSLog(@"...MUSIC OFF....");
            [AUDIO setBackgroundMusicVolume:1];
            [self setOnOffLabelsOpacity];
        }
        else
        {
            B1on = false;
            NSLog(@"...MUSIC ON...");
            [AUDIO setBackgroundMusicVolume:0.f];
            [self setOnOffLabelsOpacity];
        }
        b1 = false;
        [button1 setDisplayFrame:Btn_notActive2];
         [AUDIO playEffect:s_click1];
         */
    }
    
    if (CGRectContainsPoint(button2.boundingBox, touchPos))
    {
        
        if ([Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                                  action:@"Turned Sound Off"
                                                                   label:nil
                                                                   value:nil] build]];

            [on2Label setString:@"OFF"];
            AUDIO.effectsVolume = 0;
            [Combinations saveNSDEFAULTS_Bool:NO forKey:sound_fx];
        }
        else if (![Combinations checkNSDEFAULTS_Bool_ForKey:sound_fx]) {
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                                  action:@"Turned Sound On"
                                                                   label:nil
                                                                   value:nil] build]];

            [on2Label setString:@"ON"];
            AUDIO.effectsVolume = 1.f;
            [Combinations saveNSDEFAULTS_Bool:YES forKey:sound_fx];
        }
        
        /*
        if (B2on == false)
        {
            B2on = true;
            NSLog(@"...SOUND FX OFF....");
            [AUDIO setEffectsVolume:1];
            [self setOnOffLabelsOpacity];
        }
        else
        {
            B2on = false;
            NSLog(@"...SOUND FX ON...");
            [AUDIO setEffectsVolume:0];
            [self setOnOffLabelsOpacity];
        }
        b2 = false;
        [button2 setDisplayFrame:Btn_notActive2];
         [AUDIO playEffect:s_click1];
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
         */
    }
    
    if (CGRectContainsPoint(autoSpinButton.boundingBox, touchPos))
    {
        b3 = false;
        [AUDIO playEffect:s_click1];
     //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    }
    
    if (CGRectContainsPoint(show_LeaderBoardButton.boundingBox, touchPos))
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                              action:@"Clicked Leaderboards"
                                                               label:nil
                                                               value:nil] build]];

        b4 = false;
        [show_LeaderBoardButton setDisplayFrame:Btn_notActive];
     //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
         [AUDIO playEffect:s_click1];
        [self show_leader_board];
    }
    if (CGRectContainsPoint(button3.boundingBox, touchPos))
    {
        b15 = false;
        [button3 setDisplayFrame:Btn_notActive];
        //   [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        [AUDIO playEffect:s_click1];
        [self email];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                              action:@"Clicked Email Support"
                                                               label:nil
                                                               value:nil] build]];

    }
    if (CGRectContainsPoint(show_AchievementsButton.boundingBox, touchPos))
    {
        b5 = false;
        [show_AchievementsButton setDisplayFrame:Btn_notActive];
       // [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
         [AUDIO playEffect:s_click1];
    }
    if (CGRectContainsPoint(show_AboutButton.boundingBox, touchPos))
    {
        b6 = false;
        [show_AboutButton setDisplayFrame:Btn_notActive];
         [AUDIO playEffect:s_click1];
      //  [[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Settings"
                                                              action:@"Clicked About"
                                                               label:nil
                                                               value:nil] build]];

        if (onAbout == false)
        {
            onAbout = true;
            [self showAboutWindow];
        }
        else
        {
            onAbout = false;
            [self showNormalWindow];
        }
    }
    
    if (b1) { [button1 setDisplayFrame:Btn_notActive2]; }
    if (b2) { [button2 setDisplayFrame:Btn_notActive2]; }
    if (b3) { [autoSpinButton setDisplayFrame:Btn_notActive]; }
    if (b4) { [show_LeaderBoardButton setDisplayFrame:Btn_notActive]; }
    if (b5) { [show_AchievementsButton setDisplayFrame:Btn_notActive]; }
    if (b6) { [show_AboutButton setDisplayFrame:Btn_notActive]; }
    if (b7) { [closeBtn setDisplayFrame:closeBtn_notActive]; }
    if (b15) { [button3 setDisplayFrame:Btn_notActive]; }
}
-(void) email{
    // Email Subject
    NSString *emailTitle = FeedbackSubject;
    // Email Content
    NSString *messageBody = FeedbackBody;
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    mc.mailComposeDelegate = self;
    [mc setSubject:emailTitle];
    [mc setMessageBody:messageBody isHTML:NO];
    [mc setToRecipients:[NSArray arrayWithObject:FeedBackEmail]];
    
    // Present mail view controller on screen
    [((AppController*)[UIApplication sharedApplication].delegate).window.rootViewController presentViewController:mc animated:YES completion:NULL];
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (b1) { [button1 setDisplayFrame:Btn_notActive2]; }
    if (b2) { [button2 setDisplayFrame:Btn_notActive2]; }
    if (b3) { [autoSpinButton setDisplayFrame:Btn_notActive]; }
    if (b4) { [show_LeaderBoardButton setDisplayFrame:Btn_notActive]; }
    if (b5) { [show_AchievementsButton setDisplayFrame:Btn_notActive]; }
    if (b6) { [show_AboutButton setDisplayFrame:Btn_notActive]; }
    if (b7) { [closeBtn setDisplayFrame:closeBtn_notActive]; }
}

/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
-(void) show_leader_board
{
    [GC_ showLeaderboard:GC_LEADERBOARD];
}


-(void)closeSettingsWindow2
{
    // [AUDIO playEffect:s_click1];
    //[[SimpleAudioEngine sharedEngine] playEffect:@"btn2.mp3"];//play a sound
    
    id scale3       = [CCScaleTo actionWithDuration:0.1f scale:0.5f];
    id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
    
    [(PopupManager *)_parent removeBlackBG];
    
    [self runAction:[CCSequence actions:easeScale3,[CCCallBlock actionWithBlock:^{
        if ([_parent isKindOfClass:[PopupManager class]])
        {
            [_parent performSelector:@selector(closeSettingsWindow) withObject:nil];
        }
    }], nil]];
    

}


-(void)showAboutWindow
{
    if (state__ == 1) {
        show_LeaderBoardButton.position   = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        autoSpinButton.position           = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        button1.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        button2.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        show_AboutButton.position         = ccp(background.position.x, background.position.y - background.contentSize.height*0.4f);
    }
    else if (state__ == 2)
    {
        show_LeaderBoardButton.position   = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        button1.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        button2.position                  = ccp(kWidthScreen/2, kHeightScreen*1.5f);
        show_AboutButton.position         = ccp(background.position.x, background.position.y - background.contentSize.height*0.4f);
    }
    
    
    [aboutButtonLabel setString:@"BACK"];
    aboutButtonLabel.position = ccp(show_AboutButton.position.x, show_AboutButton.position.y);
    
    developedByLabel.opacity = 255;
    b6luxLabel.opacity      = 255;
    codeLabel.opacity       = 255;
    artLabel.opacity        = 255;
    toolsLabel.opacity      = 255;
    cocos2dLabel.opacity    = 255;
    eLabel.opacity          = 255;
    mLabel.opacity          = 255;
    sLabel.opacity          = 255;
    jLabel.opacity          = 255;
 
    onLabel.opacity         = 0;
    on2Label.opacity        = 0;
    offLabel.opacity        = 0;
    off2Label.opacity       = 0;
    soundLabel.opacity      = 0;
    musicLabel.opacity      = 0;
    menuLabel.opacity       = 0;
    showLBlabel.opacity     = 0;
    showAClabel.opacity     = 0;
    autoSpinLabel.opacity   = 0;
}

-(void)showNormalWindow
{
    if (state__ == 1) {
        autoSpinButton.position     = ccp(kWidthScreen/2, background.position.y);
        show_LeaderBoardButton.position     = ccp(kWidthScreen/2, autoSpinButton.position.y - autoSpinButton.contentSize.height*1.3f);
        show_AboutButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y - show_LeaderBoardButton.contentSize.height*1.3f);
    }
    else if (state__ == 2)
    {
        
        show_LeaderBoardButton.position     = ccp(kWidthScreen/2, background.position.y);
        show_AboutButton.position     = ccp(kWidthScreen/2, show_LeaderBoardButton.position.y - show_LeaderBoardButton.contentSize.height*1.3f);
    }
    

    
    developedByLabel.opacity = 0;
    b6luxLabel.opacity      = 0;
    codeLabel.opacity       = 0;
    artLabel.opacity        = 0;
    toolsLabel.opacity      = 0;
    cocos2dLabel.opacity    = 0;
    eLabel.opacity          = 0;
    mLabel.opacity          = 0;
    sLabel.opacity          = 0;
    jLabel.opacity          = 0;
    
    [self setOnOffLabelsOpacity];

    soundLabel.opacity      = 255;
    musicLabel.opacity      = 255;
    menuLabel.opacity       = 255;
    showLBlabel.opacity     = 255;
    showAClabel.opacity     = 255;
    autoSpinLabel.opacity   = 255;
    
    [aboutButtonLabel setString:@"ABOUT"];
    aboutButtonLabel.position = ccp(show_AboutButton.position.x, show_AboutButton.position.y);
    
//    autoSpinButton.position             = ccp(kWidthScreen/2, show_AchievementsButton.position.y + show_AchievementsButton.boundingBox.size.height/2 + kHeightScreen*0.07f);
    button1.position     = ccp(background.position.x - button1.contentSize.width*0.05f, background.position.y + background.boundingBox.size.height*0.25f);
    button2.position     = ccp(background.position.x - button1.contentSize.width*0.05f, background.position.y + background.boundingBox.size.height*0.14f);
    
}








@end
