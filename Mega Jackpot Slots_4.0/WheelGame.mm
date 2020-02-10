#import "WheelGame.h"

#import "Combinations.h"
#import "cfg.h"

#import "TopMenu.h"
#import "SlotMachine.h"
#import "WinsWindow.h"

@implementation WheelGame


-(id)init_withYourBET:(float)bet_
{
    if((self = [super init]))
    {
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        //// SCALE EFFECT
        self.scale = 0.5f;
        id scale1       = [CCScaleTo actionWithDuration:0.1f scale:1.1f];
        id easeScale1   = [CCEaseInOut actionWithAction:scale1 rate:2.0f];
        
        id scale2       = [CCScaleTo actionWithDuration:0.07f scale:0.97f];
        id easeScale2   = [CCEaseInOut actionWithAction:scale2 rate:1.0f];
        
        id scale3       = [CCScaleTo actionWithDuration:0.1f scale:1.0f];
        id easeScale3   = [CCEaseInOut actionWithAction:scale3 rate:2.0f];
        
        [self runAction:[CCSequence actions:easeScale1,easeScale2,easeScale3, nil]];
        
        
        WHEEL_IMG = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_wheel.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_wheel.plist"]];
        [self addChild:WHEEL_IMG z:4];
        
        SET_IMG = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
        [self addChild:SET_IMG z:6];
        
        sButtonActive       = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"btn_spinactive1.png"];
        sButtonNotActive    = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"btn_spin1.png"];
        
//        CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"btn_spinactive1.png"];
//        [(CCSprite*)spinButton setTexture: tex];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        spinRotation    = 0.0f;
        times           = 0;
        finalWin        = 0;
        xTimes          = 0;
        animGo          = false;
        isSpinning      = false;
        gameOver        = false;
        
        if (bet_ <= 2) {BET = 2;}
        else{BET         = bet_;}
        
        spins_          = 3;
        scaleNR         = 1.0f;
        
        [self addWheel];
        [self addNumbersLabels:BET];
        [self addWinLabel];
        [self addGameOverLabel];
       // [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.16f],[CCCallFuncO actionWithTarget:self selector:@selector(blackScreen_with_Z_order:) object:0], nil]];
        [self blackScreen_with_Z_order:0];
        float dt = 1/60;
        [self schedule:@selector(update:) interval:dt];
        [self addCloseButton];
        
        //spinSound = 30;

    }
    
    return self;
}

///////////////////// UPDATE ////////////////////////////////////

-(void)update:(ccTime)delta
{    
    if (startSpinning)
    {
        if (rndGet == false)
        {
            rndGet      = true;
            rndSpeed    = (int)[cfg MyRandomIntegerBetween:5 :25];
            
            //NSLog(@"....randSpeed :%d", rndSpeed);
            
            if (rndSpeed == 19) { rndSpeed = 22; }
            if (rndSpeed ==  6) { rndSpeed = 35; }
        }
        

        
    
        
        if (times < 3)
        {
            //[spinButton setDisplayFrame:sButtonActive];
            CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"btn_spinactive1.png"];
            [(CCSprite*)spinButton setTexture: tex];
            
            v_ = rndSpeed;
            
            if (spinRotation >= 360)
            {
                v_ = v_ - ((spinRotation-360)/50);
                
                if (v_ <= 0.010f)
                {
                    isSpinning = false;
                    
                    if (rndSpeed != 18 && rndSpeed != 11 && rndSpeed != 12 && rndSpeed != 35 && rndSpeed != 23)
                    {
                        [self pulse];
                    }
                    
                    startSpinning = false;
                    rndGet        = false;
                    
                    //[spinButton setDisplayFrame:sButtonNotActive];
                    CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"btn_spin1.png"];
                    [(CCSprite*)spinButton setTexture: tex];
                    times += 1;
                    
    
                    
                    switch (rndSpeed)
                    {
                        case 5:  [self change_WinLabel_win: BET*3.5f];    break; //
                        case 6:  [self change_WinLabel_win: BET*4.5f];    break;
                        case 7:  [self change_WinLabel_win: BET*2.0f];    break; //
                        case 8:  [self change_WinLabel_win: BET*1.0f];    break; //
                        case 9:  [self change_WinLabel_win: BET*6.0f];    break; //
                        case 10: [self change_WinLabel_win: BET*5.5f];    break; //
                        case 11: [self change_WinLabel_win: BET*0.0f];    break; // 0
                        case 12: [self change_WinLabel_win:    22222];    break; // if 2x spin
                        case 13: [self change_WinLabel_win: BET*1.5f];    break; //
                        case 14: [self change_WinLabel_win: BET*2.0f];    break; //
                        case 15: [self change_WinLabel_win: BET*1.0f];    break; //
                        case 16: [self change_WinLabel_win: BET*6.0f];    break; //
                        case 17: [self change_WinLabel_win: BET*5.5f];    break; //
                        case 18: [self change_WinLabel_win: BET*0.0f];    break; // 0
                        case 35: [self change_WinLabel_win:    66666]; /* [self pulseGOver]; */ break; // GAME OVER
                        case 20: [self change_WinLabel_win: BET*1.5f];    break; //
                        case 21: [self change_WinLabel_win: BET*2.5f];    break; //
                        case 22: [self change_WinLabel_win: BET*3.0f];    break; //
                        case 23: [self change_WinLabel_win:    99999];    break; // BANKTRUPT
                        case 24: [self change_WinLabel_win: BET*4.0f];    break; //
                        case 25: [self change_WinLabel_win: BET*4.5f];    break; //
                        default:
                            break;
                    }
                }
            }
            spinRotation += v_;
        }
        
        
    }
    
    //speed calculate
    
    float sp = spinRotation - imgWheel.rotation;
    
   // NSLog(@"diff %f",sp);
    
    if (spinRotation >= spinSound && sp > 0.1f)
    {
        float speedmin = 3;
        float f = speedmin + sp*5;

        spinSound =spinRotation+f;
        [AUDIO playEffect:s_sound];
    }
    
    if (sp == 0) {
        spinSound = 0;
    }
    
    imgWheel.rotation = spinRotation;
    
    if (winValue.boundingBox.size.width >= spinButton.boundingBox.size.width*0.6f)
    {
        scaleNR -= 0.1f;
        winValue.scale = scaleNR;
    }
    
}


//////////////////////// TOUCHES /////////////////////////////////
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    if (gameOver == false)
    {
        if (times < 3 && isSpinning == false)
        {
            if (CGRectContainsPoint(spinButton.boundingBox, touchPos))
            {
                //[spinButton setDisplayFrame:sButtonActive];
//                times += 1;
                //NSLog(@"___time nr :%d ___", times);
                b1 = true;
            }
        }
    }
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        
    }


    return YES;
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    if (gameOver == false)
    {
        if (times <= 3  && isSpinning == false)
        {
            if (CGRectContainsPoint(spinButton.boundingBox, touchPos))
            {
                startSpinning = true;
                rndGet        = false;
                spinRotation  = 0;
                v_            = 0;
                
                isSpinning    = true;
                
                spins_ -= 1;
                if (spins_ == -1) { spins_ = 0; }
                [spinsLeft setString:[NSString stringWithFormat:@"SPINS LEFT: %d", spins_]];
                
                [self change_gOverLabel:1];
                
                if (times == 3) { times = 4; }
                
                if (animGo)
                {
                    if (rndSpeed != 11 && rndSpeed != 12 && rndSpeed != 18 && rndSpeed != 23)
                    {
                        [self stopAction:repeat];
                        [self stopAction:repeat2];
                        [self stopAction:repeat3];
                    }
                    
                    wheelLights.opacity     = 0;
                    pointerActive.opacity   = 0;
                    winText.opacity         = 0;
                    gOverLabel.opacity      = 0;
                }
            }
        }
    }
    
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [(SlotMachine *)_parent closeWheelGame];
    }
    
}

-(void) ccTouchCancelled:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (b1) { CCTexture2D* tex = [[CCTextureCache sharedTextureCache] addImage:@"btn_spin1.png"];
        [(CCSprite*)spinButton setTexture: tex]; }
}

/////////////////////// ADD SPRITES ///////////////////////////////
-(void) addWheel
{   
    background                  = [CCSprite spriteWithFile:@"background1.png"];
    background.anchorPoint      = ccp(0.5f, 0.5f);
    background.position         = ccp(kWidthScreen/2, kHeightScreen/2);
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        background.scale = 1.4;
//    }
    [self addChild:background z:1];
    
    imgWheel                    = [CCSprite spriteWithFile:@"wheel1.png"];
    imgWheel.anchorPoint        = ccp(0.5f, 0.5f);
    imgWheel.position           = ccp(background.position.x - background.boundingBox.size.width/2 + imgWheel.boundingBox.size.width*0.6f, kHeightScreen/2);
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        imgWheel.scale = 1.4;
//    }
    [self addChild:imgWheel z:3];
    
    wheelLights                 = [CCSprite spriteWithSpriteFrameName:@"wheel_win.png"];
    wheelLights.anchorPoint     = ccp(0.5f, 0.5f);
    wheelLights.position        = ccp(imgWheel.boundingBox.size.width/2, imgWheel.boundingBox.size.height/2);
    wheelLights.scale           = 0.97f;
    wheelLights.opacity         = 0;
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        wheelLights.scale = 1.4;
//    }
    [imgWheel addChild:wheelLights z:6];

    spinPointer                 = [CCSprite spriteWithSpriteFrameName:@"arrow_wheel.png"];
    spinPointer.anchorPoint     = ccp(0.5f, 0.5f);
    spinPointer.position        = ccp(imgWheel.position.x + spinPointer.boundingBox.size.width*0.37f, kHeightScreen/2 - spinPointer.boundingBox.size.height*0.05f);
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        spinPointer.scale = 1.4;
//    }
    [WHEEL_IMG addChild:spinPointer z:7];
    
    pointerActive               = [CCSprite spriteWithSpriteFrameName:@"arrow_active.png"];
    pointerActive.anchorPoint   = ccp(0.5f, 0.5f);
    pointerActive.opacity       = 0;
    pointerActive.position      = ccp(spinPointer.position.x, spinPointer.position.y);
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        pointerActive.scale = 1.4;
//    }
    [WHEEL_IMG addChild:pointerActive z:8];
    
    spinButton                  = [CCSprite spriteWithFile:@"btn_spin1.png"];
    spinButton.anchorPoint      = ccp(0.5f, 0.5f);
    spinButton.position         = ccp(background.position.x + spinButton.boundingBox.size.width*0.72f, background.position.y - spinButton.boundingBox.size.height*1.2f);
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        spinButton.scale = 1.4;
//    }
    [self addChild:spinButton z:2];
    
    winText                     = [CCSprite spriteWithSpriteFrameName:@"yourwin_text.png"];
    winText.anchorPoint         = ccp(0.5f, 0.5f);
    winText.opacity             = 0;
    winText.position            = ccp(background.position.x + spinButton.boundingBox.size.width*0.89f, background.position.y + spinButton.boundingBox.size.height*1.19f);
//    if (IS_STANDARD_IPHONE_6_PLUS) {
//        winText.scale = 1.4;
//    }
    [WHEEL_IMG addChild:winText z:3];

    
    
}

///////////////////////// WIN ANIMATION ////////////////////////////
- (void) pulse
{
    animGo  = true;
    
    [pointerActive setOpacity:255];
    
    id fade1 = [CCFadeTo actionWithDuration:1.0f opacity: 10];
    id fade2 = [CCFadeTo actionWithDuration:0.6f opacity:255];
    
    CCSequence *pulseSequence   = [CCSequence actionOne:fade1 two:fade2];
    repeat     = [CCRepeatForever actionWithAction:pulseSequence];
    [pointerActive runAction:repeat];
    
    
    [wheelLights setOpacity:255];
    
    id fade3 = [CCFadeTo actionWithDuration:0.1f opacity: 10];
    id fade4 = [CCFadeTo actionWithDuration:0.1f opacity:255];
    
    CCSequence *pulseSequence2   = [CCSequence actionOne:fade3 two:fade4];
    repeat2     = [CCRepeatForever actionWithAction:pulseSequence2];
    [wheelLights runAction:repeat2];
    
    
    [winText setOpacity:255];
    
    id fade5 = [CCFadeTo actionWithDuration:0.5f opacity: 10];
    id fade6 = [CCFadeTo actionWithDuration:0.5f opacity:255];
    
    CCSequence *pulseSequence3   = [CCSequence actionOne:fade5 two:fade6];
    repeat3     = [CCRepeatForever actionWithAction:pulseSequence3];
    [winText runAction:repeat3];
}

- (void) pulseGOver
{
    [winValue setString:[NSString stringWithFormat:@"0"]];
    
    gameOver = true;
    
    [self change_gOverLabel:0];
    [gOverLabel setOpacity:255];
    [self showRes:0];
    
    id fade1 = [CCFadeTo actionWithDuration:0.5f opacity: 10];
    id fade2 = [CCFadeTo actionWithDuration:0.5f opacity:255];
    
    CCSequence *pulseSequence   = [CCSequence actionOne:fade1 two:fade2];
    repeat4     = [CCRepeatForever actionWithAction:pulseSequence];
    [gOverLabel runAction:repeat4];
}

-(void)showRes:(int)int_
{

    WinsWindow *WWindow = [[[WinsWindow alloc] init_with_WIN:int_ type:1] autorelease];
    WWindow.anchorPoint = ccp(0.5f, 0.5f);
    WWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:WWindow z:15 tag:kWinWindowTAG];
}

//////////////////////////// WIN LABEL ////////////////////////////////
-(void) addWinLabel
{
    int win_ = 0;
    winValue                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"%d", win_] fntFile:kFONT_WHEEL2]autorelease];
    winValue.anchorPoint     = ccp(0.5f, 0.5f);
    winValue.scale           = scaleNR;
//    if (iPhone3) { winValue.scale = 0.7f;}
    winValue.color           = ccc3(233, 192, 0);
    winValue.position        = ccp(spinButton.position.x + spinButton.boundingBox.size.width*0.10f, kHeightScreen/2);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        winValue.scale = 1.8;
    }
    [self addChild:winValue z:2];
    
    
    spinsLeft                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"SPINS LEFT: %d", spins_] fntFile:kFONT_WHEEL]autorelease];
    spinsLeft.anchorPoint     = ccp(0.5f, 0.5f);
    spinsLeft.scale           = 0.9f;
    if (iPhone3) { spinsLeft.scale = 0.7f;}
    spinsLeft.color           = ccc3(255, 255, 255);
    spinsLeft.position        = ccp(winText.position.x, background.position.y + background.boundingBox.size.height*0.40f);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        spinsLeft.scale = 1.4;
    }
    [self addChild:spinsLeft z:2];
}

//////////////////////////// NUMBERS LABELS ////////////////////////////////
-(void) addNumbersLabels:(int)bet_
{

    Number1                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number1.anchorPoint     = ccp(1.0f, 0.5f);
    Number1.color           = ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number1.scale = 1.6;
    }
    [imgWheel addChild:Number1 z:2];
    
    Number2                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number2.anchorPoint     = ccp(1.0f, 0.5f);
    Number2.color           =ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number2.scale = 1.6;
    }
    [imgWheel addChild:Number2 z:2];
    
    Number3                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number3.anchorPoint     = ccp(1.0f, 0.5f);
    Number3.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number3.scale = 1.6;
    }
    [imgWheel addChild:Number3 z:2];
    
    Number4                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number4.anchorPoint     = ccp(1.0f, 0.5f);
    Number4.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number4.scale = 1.6;
    }
    [imgWheel addChild:Number4 z:2];
    
    Number5                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number5.anchorPoint     = ccp(1.0f, 0.5f);
    Number5.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number5.scale = 1.6;
    }
    [imgWheel addChild:Number5 z:2];
    
    Number6                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number6.anchorPoint     = ccp(1.0f, 0.5f);
    Number6.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number6.scale = 1.6;
    }
    [imgWheel addChild:Number6 z:2];
    
    Number7                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number7.anchorPoint     = ccp(1.0f, 0.5f);
    Number7.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number7.scale = 1.6;
    }
    [imgWheel addChild:Number7 z:2];
    
    Number8                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"2x"] fntFile:kFONT_WHEEL]autorelease];
    Number8.anchorPoint     = ccp(1.0f, 0.5f);
    Number8.color           = ccBLACK; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number8.scale = 1.6;
    }
    [imgWheel addChild:Number8 z:2];
    
    Number9                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number9.anchorPoint     = ccp(1.0f, 0.5f);
    Number9.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number9.scale = 1.6;
    }
    [imgWheel addChild:Number9 z:2];
    
    Number10                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number10.anchorPoint     = ccp(1.0f, 0.5f);
    Number10.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number10.scale = 1.6;
    }
    [imgWheel addChild:Number10 z:2];
    
    Number11                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number11.anchorPoint     = ccp(1.0f, 0.5f);
    Number11.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number11.scale = 1.6;
    }
    [imgWheel addChild:Number11 z:2];
    
    Number12                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@""] fntFile:kFONT_WHEEL]autorelease];
    Number12.anchorPoint     = ccp(1.0f, 0.5f);
    Number12.color           = ccWHITE; //ccc3(233, 192, 0);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        Number12.scale = 1.6;
    }
    [imgWheel addChild:Number12 z:2];
    
    
    
    int distance = imgWheel.boundingBox.size.width*0.40f;
    
    CGPoint destination  = ccp(0, 0);
    CGPoint centerPoint = ccp(imgWheel.boundingBox.size.width/2, imgWheel.boundingBox.size.height/2);
    
    /*
     ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(CHARACTER_GO.rotation))),
     distance*(sin(-CC_DEGREES_TO_RADIANS(CHARACTER_GO.rotation))));
     */
    
    float deg = 24;
    
    for (int n = 1; n < 16; n++)
    {
        float deqNew = -89.5f+((n*deg)-(deg*0.85f));
        float rotNew = -90.0f+((n*deg)-(deg*0.85f));
        
        switch (n)
        {
            case  1:
                [Number1 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 6.0f)]];
                Number1.position = centerPoint;      
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew)))); 
                Number1.position = ccpAdd(Number1.position, destination);
                Number1.rotation = rotNew;
            break;
                
            case  2: break;
                
            case  3:
                [Number2 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 1.0f)]];
                Number2.position = centerPoint; 
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));   
                Number2.position = ccpAdd(Number2.position, destination);  
                Number2.rotation = rotNew;
            break;
                
            case  4:
                [Number3 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 3.0f)]];
                Number3.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew)))); 
                Number3.position = ccpAdd(Number3.position, destination);
                Number3.rotation = rotNew;
            break;
                
            case  5:
                [Number4 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 2.0f)]];
                Number4.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number4.position = ccpAdd(Number4.position, destination);
                Number4.rotation = rotNew;
            break;
                
            case  6:
                [Number5 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 2.5f)]];
                Number5.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number5.position = ccpAdd(Number5.position, destination);
                Number5.rotation = rotNew;
            break;
                
            case  7: break;
                
            case  8:
                [Number6 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 1.5f)]];
                Number6.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number6.position = ccpAdd(Number6.position, destination);
                Number6.rotation = rotNew;
            break;
                
            case  9:
                [Number7 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 3.5f)]];
                Number7.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number7.position = ccpAdd(Number7.position, destination);
                Number7.rotation = rotNew;
                break;
                
            case 10:
                [Number8 setString:[NSString stringWithFormat:@"2x"]]; // , (int)(bet_ * 5.0f)]];
                Number8.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number8.position = ccpAdd(Number8.position, destination);
                Number8.rotation = rotNew;
            break;
                
            case 11:
                [Number9 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 0.5f)]];
                Number9.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number9.position = ccpAdd(Number9.position, destination);
                Number9.rotation = rotNew;
            break;
                
            case 12: break;
                
            case 13:
                [Number10 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 4.5f)]];
                Number10.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number10.position = ccpAdd(Number10.position, destination);
                Number10.rotation = rotNew;
            break;
                
            case 14:
                [Number11 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 5.5f)]];
                Number11.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number11.position = ccpAdd(Number11.position, destination);
                Number11.rotation = rotNew;
            break;
                
            case 15:
                [Number12 setString:[NSString stringWithFormat:@"%d" , (int)(bet_ * 4.0f)]];
                Number12.position = centerPoint;
                destination = ccp(distance*(cos(-CC_DEGREES_TO_RADIANS(deqNew))), distance*(sin(-CC_DEGREES_TO_RADIANS(deqNew))));
                Number12.position = ccpAdd(Number12.position, destination);
                Number12.rotation = rotNew;
            break;
                
            default:
                break;
        }
    }
}
/////////////////////////// WIN AND DOUBLE WIN ////////////////////////
-(void) change_WinLabel_win:(int)win_
{
    if (!gameOver)
    {
        if (win_ == 66666) ////// GAME OVER //////
        {
           // finalWin = 0;
            [winValue setString:[NSString stringWithFormat:@"%d", finalWin]];
            [self showRes:finalWin];
            //[self pulseGOver];
        }
        else
        {
            if (win_ != 99999) {
                [AUDIO playEffect:s_winicon2];
            }
            
            if (win_ == 99999) ////// BANKRUPT //////
            {
                finalWin = 0;
                win_     = 0;
            }
            else if (win_ == 22222) ////// 2x //////
            {
                finalWin = finalWin*2;
                win_     = 0;
            }
            
            
            finalWin = finalWin + win_;
            

            
        }
        
       // NSLog(@".... FINAL WIN : %d ....", finalWin);
        float fWin = finalWin;
        NSString *numberString;
        
        if (fWin < 10) {
            numberString = [NSString stringWithFormat:@"%.1f0", fWin];
            [winValue setString:numberString];
            
            if (fWin == 0) {
                [winValue setString:@"0"];
            }
        }
        else
        {
            // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
            NSString *stringFormated = [cfg formatTo3digitsValue:fWin];
            [winValue setString:stringFormated];
        }
        
        if (times > 2)
        {
            [self showRes:finalWin];
        }
    }
  
}

//////////////////////////// GAME OVER LABEL /////////////////////////
-(void) addGameOverLabel
{
    gOverLabel                 = [[[CCLabelBMFont alloc] initWithString:@"PRESS SPIN!" fntFile:kFONT_NLEVEL]autorelease];
    gOverLabel.anchorPoint     = ccp(0.5f, 0.5f);
    gOverLabel.color           = ccc3(255, 255, 255);
    gOverLabel.opacity         = 255;
    gOverLabel.scale           = 0.5f;
    gOverLabel.position        = ccp(background.position.x + spinButton.boundingBox.size.width*0.89f, background.position.y + spinButton.boundingBox.size.height*1.19f);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        gOverLabel.scale = 1.6;
    }
    [self addChild:gOverLabel z:2];
}

-(void) change_gOverLabel:(int)l_
{
    gOverLabel.scale           = 0.5f;
    
    if (l_ == 1)
    {
        [gOverLabel setString:@""];
    }
    if (l_ == 0)
    {
        [gOverLabel setString:@"GAME OVER!"];
    }
    
}
///////////////////// EXIT GAME /////////////////////////////////
-(void) addCloseButton
{
    closeBtn                   = [CCSprite spriteWithSpriteFrameName:@"menuBTN_close.png"];
    closeBtn.anchorPoint       = ccp(0.5f, 0.5f);
    closeBtn.position          = ccp(background.position.x + background.boundingBox.size.width/2, background.position.y + background.boundingBox.size.height/2);
    [SET_IMG addChild:closeBtn z:1];
}


-(void) exitGame
{
    [AUDIO playEffect:s_click1];
    [_parent performSelector:@selector(closeWheelGame) withObject:nil];
}

///////////////////// CREATE BLACK SCREEN ///////////////////////
-(void)blackScreen_with_Z_order:(int) Zorder_
{
    CCSprite *spr   = [CCSprite node];
    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
    spr.opacity     = 0;
    spr.scale       = 1.5f;
    spr.anchorPoint = ccp(0.5f, 0.5f);
    spr.position    = ccp(kWidthScreen/2, kHeightScreen/2);
    spr.color       = ccc3(255,255,255);
    [self addChild:spr z:Zorder_ tag:kBlackSreen_TAG];
    [spr runAction:[CCSpawn actions:[CCFadeTo actionWithDuration:0.1f opacity:200],[CCScaleTo actionWithDuration:0.3f scale:1.0f], nil]];
}
/////////////////////////////////////////////////////////////////
-(void) onEnter
{
    for (CCNode *c in self.parent.children) {
        
        if (c == self) {
            break;
        }
        else {
            c.visible = NO;
        }
        
    }
    
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    [super onEnter];
}

-(void) onExit
{
    for (CCNode *c in self.parent.children) {
        
        if (c == self) {
            break;
        }
        else {
            c.visible = YES;
        }
        
    }
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super onExit];
}


@end
