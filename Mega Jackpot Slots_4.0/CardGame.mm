#import "CardGame.h"

#import "Combinations.h"
#import "cfg.h"

#import "TopMenu.h"
#import "SlotMachine.h"
#import "WinsWindow.h"

@implementation CardGame{
    
    NSMutableArray *guessed;
    
}

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

//        CARD_IMG = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_cgame.pvr.ccz"]];
//        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_cgame.plist"]];
//        [self addChild:CARD_IMG z:1];
        
        SET_IMG = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_settings_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_settings_menu.plist"]];
        [self addChild:SET_IMG z:3];
        
        background_          = [CCSprite spriteWithFile:@"card_background.png"];
        background_.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addChild:background_ z:2];
        
        /////////////// SET RANDOM CARDS COLOR ////////////////
//        int randColor = (int)[cfg MyRandomIntegerBetween:1 :4];
//        
//        switch (randColor)
//        {
//            case 1: cColor_R = 220; cColor_G = 127; cColor_B = 142;      // RED COLOR
//                break;   
//            case 2: cColor_R = 127; cColor_G = 206; cColor_B = 220;      // BLUE COLOR
//                break;  
//            case 3: cColor_R = 128; cColor_G = 220; cColor_B = 127;      // GREEN COLOR
//                break;   
//            case 4: cColor_R = 220; cColor_G = 127; cColor_B = 220;      // PURPLE COLOR
//                break;
//            default:
//                break;
//        }
        if (bet_ <= 2) {BET = 2;}
        else{BET         = bet_;}
       
        gameON      = true;
        secondC     = 0;
        totalWin_   = 0;
        totalLives_ = 5;
        
        [self blackScreen_with_Z_order:0];
        [self setCards];
        [self addLabels_win_and_lives];
        [self addCloseButton];
        
        blocked_1 = 0;
        blocked_2 = 0;
        
        
        guessed= [[NSMutableArray alloc]init];
        
      //  [self schedule:@selector(update:) interval:0.5f];
        
        
    }
    
    return self;
}

-(void)update:(ccTime)delta{
    
    //NSLog(@"%i %i",blocked_1,blocked_2);
    
}

-(void)showRes:(int)int_
{
    WinsWindow *WWindow = [[[WinsWindow alloc] init_with_WIN:int_ type:1] autorelease];
    WWindow.anchorPoint = ccp(0.5f, 0.5f);
    WWindow.position = ccp(kWidthScreen/2, kHeightScreen/2);
    [self addChild:WWindow z:15 tag:kWinWindowTAG];
}

-(void)randomNumbers
{
    int length  = 17; // int length = [yourArray count];
    nr_     = 0;
    fNUMBER = 0;
    
    NSMutableArray *indexes = [[NSMutableArray alloc] initWithCapacity:length];
    for (int i=1; i<17; i++)
    {
        if (i == 1)  { nr_ = 0.5f * BET;}
        if (i == 2)  { nr_ = 1.0f * BET;}
        if (i == 3)  { nr_ = 1.5f * BET;}
        if (i == 4)  { nr_ = 2.0f * BET;}
        if (i == 5)  { nr_ = 2.5f * BET;}
        if (i == 6)  { nr_ = 3.0f * BET;}
        if (i == 7)  { nr_ = 3.5f * BET;}
        if (i == 8)  { nr_ = 4.0f * BET;}
        if (i == 9)  { nr_ = 0.5f * BET;}
        if (i == 10) { nr_ = 1.0f * BET;}
        if (i == 11) { nr_ = 1.5f * BET;}
        if (i == 12) { nr_ = 2.0f * BET;}
        if (i == 13) { nr_ = 2.5f * BET;}
        if (i == 14) { nr_ = 3.0f * BET;}
        if (i == 15) { nr_ = 3.5f * BET;}
        if (i == 16) { nr_ = 4.0f * BET;}
        
        [indexes addObject:[NSNumber numberWithInt:nr_]];
    }
        
    shuffle = [[NSMutableArray alloc] initWithCapacity:length];
    
    while ([indexes count])
    {
        int index = arc4random() % [indexes count];
        [shuffle addObject:[indexes objectAtIndex:index]];
        [indexes removeObjectAtIndex:index];
    }
    
    
    fNUMBER = 0;
   // NSString *s = @"";
    
    NSArray *a = [NSArray arrayWithArray:shuffle];
    
    [[a reverseObjectEnumerator]allObjects];
    
    for (int x= 1; x <= [a count]; x++) {
        fNUMBER+=[[a objectAtIndex:x-1]intValue];
        
        //s = [NSString stringWithFormat:@"%@,%@",s,[a objectAtIndex:x-1]];
        //if ([cfg isNumber:x devidableBy:4]) {
           // NSLog(@"%@",s);
            //s = @"";
      //  }
    }
    
   // NSLog(@"............NUMBERS: %@", [shuffle description]);
}


-(void) setCards
{
    int rowNr   = 0;       
    int x_      = 0;
    
    [self randomNumbers];
    
    for (int x = 0; x <16; x++)
    {
        

        if      (![Combinations isRetina] && IS_IPAD)   { cardSprite = [[SpriteFlipCard alloc] initSpriteFlipCardWithImageOne:@"card_ipad.png" andImageTwo:@"card2_ipad.png"]; }
        else if ([Combinations isRetina] && IS_IPAD)    { cardSprite = [[SpriteFlipCard alloc] initSpriteFlipCardWithImageOne:@"card_ipadhd.png" andImageTwo:@"card2_ipadhd.png"]; }
        else if (![Combinations isRetina] && IS_IPHONE) { cardSprite = [[SpriteFlipCard alloc] initSpriteFlipCardWithImageOne:@"card_iphone.png" andImageTwo:@"card2_iphone.png"]; }
        else if ([Combinations isRetina] && IS_IPHONE)  { cardSprite = [[SpriteFlipCard alloc] initSpriteFlipCardWithImageOne:@"card_iphonehd.png" andImageTwo:@"card2_iphonehd.png"]; }
        if (IS_STANDARD_IPHONE_6_PLUS) {
            cardSprite.scale = 2.0;
        }
        [self addChild:cardSprite z:5 tag:kCard_TAG + x];
        cardSprite.position = ccp(background_.position.x - background_.boundingBox.size.width*0.35 + cardSprite.boundingBox.size.width * x_ * 1.08f, background_.position.y - background_.boundingBox.size.height*0.35 + rowNr * cardSprite.boundingBox.size.height * 1.08f);
        x_++;
        
        //change cards color
        //[cardSprite runAction:[CCTintTo actio nWithDuration:0.0f red:cColor_R green:cColor_G blue:cColor_B]];
        
        /////////////////// SET CARDS NUMBERS //////////////////////
        p_ = [[shuffle objectAtIndex:0+x] integerValue];
        
        nLabel                     = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"%d", p_] fntFile:kFONT_CARD]autorelease];
        nLabel.color               = ccc3(82, 41, 92); //ccc3(233, 192, 0);
        nLabel.position            = ccp(cardSprite.boundingBox.size.width/2, cardSprite.boundingBox.size.height/2);
        if (IS_STANDARD_IPHONE_6_PLUS) {
            nLabel.position            = ccp(cardSprite.boundingBox.size.width/4, cardSprite.boundingBox.size.height/4);
        }
        [cardSprite addChild:nLabel z:6 tag:kCNumber_TAG];
        
        nLabel.opacity = 0;
        if (p_ > 9999)  { nLabel.scale = 0.80f; }
        if (p_ > 99999) { nLabel.scale = 0.60f; }
        
        
        if (x == 3 || x == 7 || x == 11 || x == 15)
        {
            x_ = 0;
            rowNr++;
        } 
    }

    
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        
    }
    
    if (BLOCK_TOUCH) {
        return YES;
    }
    
    if (gameON)
    {
        
        //NSLog(@"arr %@",guessed);
        
        for (int x = 0; x < 16; x++)
        {
            if (CGRectContainsPoint([self getChildByTag:kCard_TAG+x].boundingBox, touchPos))
            {
               
                for (int y = 0; y < [guessed count]; y++) {
                    int saved = [[guessed objectAtIndex:y]integerValue];
                    if (saved == x+1) {
                        return YES;
                    }
                }
                
                
                if (blocked_1 != 0 && x+1 == blocked_1) {
                    continue;
                }
                if (blocked_2 != 0 && x+1 == blocked_2) {
                    continue;
                }
                
                if (blocked_1 == 0)
                {
                    blocked_1 = x+1;
                }
                else if (blocked_1 != 0) blocked_2 = x+1;
                
                [self openCard_nr:x+1];
                
         
            }
        }
    }

         
    return YES;
}
-(void)exitGame
{
     [AUDIO playEffect:s_click1];
   [_parent performSelector:@selector(closeCardGame) withObject:nil];
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [self exitGame];
    }
}

//////////////////////////////////// CHECKING CARDS ///////////////////////////////////////////
-(void)openCard_nr:(int)number_
{
    
    for (int i = 1; i < 17; i++)
    {
        if (i == number_)
        {
            secondC++;
            if      (secondC == 1) { cNumber1 = number_; }
            else if (secondC == 2) { cNumber2 = number_; }
            
            
            [(SpriteFlipCard *)[self getChildByTag:kCard_TAG+(i-1)] flipSpriteHorizontal:0.2f];
               [AUDIO playEffect:s_cardOpen];
            
            if (secondC == 1)
            {
                CCLabelBMFont *lNumber_ = (CCLabelBMFont*)[[self getChildByTag:kCard_TAG+(i-1)] getChildByTag:kCNumber_TAG];
                guess1 = [lNumber_.string intValue];
                
                CCAction *fade = [CCFadeTo actionWithDuration:0.3 opacity:255.0];
                [[[self getChildByTag:kCard_TAG+(i-1)] getChildByTag:kCNumber_TAG] runAction:fade];
                
            }
            if (secondC == 2)
            {
                CCLabelBMFont *lNumber_2 = (CCLabelBMFont*)[[self getChildByTag:kCard_TAG+(i-1)] getChildByTag:kCNumber_TAG];
                guess2 = [lNumber_2.string intValue];
                
                CCAction *fade = [CCFadeTo actionWithDuration:0.3 opacity:255.0];
                [[[self getChildByTag:kCard_TAG+(i-1)] getChildByTag:kCNumber_TAG] runAction:fade];
                
            }
            
        }
    }
    
    if (secondC == 2)
    {     
        if (guess1 == guess2)
        {
            int winN_ = guess1;
            [self update_win:winN_];
            
            [guessed addObject:[NSNumber numberWithInt:blocked_1]];
            [guessed addObject:[NSNumber numberWithInt:blocked_2]];

            secondC = 0;
            
            blocked_1 = 0;
            blocked_2 = 0;
            
            [AUDIO playEffect:s_winicon2];
            
        }
        else
        {
            BLOCK_TOUCH = YES;
            
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:1.5f],[CCCallFunc actionWithTarget:self selector:@selector(closeCards)], nil]];
            
           // [self performSelector:@selector(closeCards) withObject:nil afterDelay:1.5];
        }
    }
}

-(void)closeCards
{
    
    [AUDIO playEffect:s_cardOpen];
    
    blocked_1 = 0;
    blocked_2 = 0;
    
    secondC = 0;
    totalLives_ = totalLives_ - 1;
    [self update_lives];
    
    if (totalLives_ == 0)
    {
        gameON = false;
        [self showRes:totalWin_];
    }

    for (int i = 1; i < 17; i++)
    {
        if (i == cNumber1)
        {
            [(SpriteFlipCard *)[self getChildByTag:kCard_TAG+(i-1)] flipSpriteHorizontal:0.3f];
            CCAction *fade = [CCFadeTo actionWithDuration:0.2 opacity:0.0];
            [[[self getChildByTag:kCard_TAG+(i-1)] getChildByTag:kCNumber_TAG] runAction:fade];
        }
        if (i == cNumber2)
        {
            [(SpriteFlipCard *)[self getChildByTag:kCard_TAG+(i-1)] flipSpriteHorizontal:0.3f];
            id fade = [CCFadeTo actionWithDuration:0.2 opacity:0.0];
            id s = [CCCallBlock actionWithBlock:^(void){BLOCK_TOUCH = NO;}];
            //   id s = [CCCallFuncN actionWithTarget:self selector:@selector(enaenbleAllTouchesble)];
            id seq = [CCSequence actions:fade,s, nil];
            [[[self getChildByTag:kCard_TAG+(i-1)] getChildByTag:kCNumber_TAG] runAction:seq];
        }
    }
    
}


-(void)enbleAllTouches
{
    BLOCK_TOUCH = NO;
}

/////////////////////////////////////////////////////////////////
-(void) addNumbersLabels
{
    
}

-(void) addLabels_win_and_lives
{

    winText                     = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"YOU WON: "] fntFile:kFONT_CARDSROCES]autorelease];
    winText.color               = ccc3(255, 255, 255);
    winText.position            = ccp(background_.position.x - background_.boundingBox.size.width*0.34f, background_.position.y + background_.boundingBox.size.height*0.43f);
    if(IS_STANDARD_IPHONE_6_PLUS){
        winText.scale = 2.0;
    }
    [self addChild:winText z:2];
    
    winNumber                   = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"0"] fntFile:kFONT_CARDSROCES]autorelease];
    winNumber.color             = ccc3(233, 192, 0);
    winNumber.anchorPoint       = ccp(0, 0.5f);
    winNumber.position          = ccp(winText.position.x + winText.boundingBox.size.width*0.52f, winText.position.y);
    if(IS_STANDARD_IPHONE_6_PLUS){
        winNumber.scale = 2.0;
    }
    [self addChild:winNumber z:2];
    
    livesText                   = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"LIVES LEFT: "] fntFile:kFONT_CARDSROCES]autorelease];
    livesText.color             = ccc3(255, 255, 255);
    livesText.position          = ccp(background_.position.x + background_.boundingBox.size.width*0.30f, background_.position.y + background_.boundingBox.size.height*0.43f);
    if(IS_STANDARD_IPHONE_6_PLUS){
        livesText.scale = 2.0;
    }
    [self addChild:livesText z:2];
    
    livesNumber                 = [[[CCLabelBMFont alloc] initWithString:[NSString stringWithFormat:@"%d", totalLives_] fntFile:kFONT_CARDSROCES]autorelease];
    livesNumber.color           = ccc3(233, 192, 0);
    livesNumber.anchorPoint     = ccp(0, 0.5f);
    livesNumber.position        = ccp(livesText.position.x + livesText.boundingBox.size.width*0.52f, livesText.position.y);
    if(IS_STANDARD_IPHONE_6_PLUS){
        livesNumber.scale = 2.0;
    }
    [self addChild:livesNumber z:2];
}

-(void) update_win:(int)win_
{
    totalWin_   = totalWin_ + win_;
    
    NSString *numberString;

    if (totalWin_ < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", totalWin_];
        [winNumber setString:numberString];
    }
    else
    {
        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
        NSString *stringFormated = [cfg formatTo3digitsValue:totalWin_];
        [winNumber setString:stringFormated];
    }

    
    if (totalWin_ == (fNUMBER/2))
    {
        [self showRes:totalWin_];
    }
}

-(void) update_lives
{
    [livesNumber setString:[NSString stringWithFormat:@"%d", totalLives_]];
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
    [spr runAction:[CCSpawn actions:[CCFadeTo actionWithDuration:0.1f opacity:220],[CCScaleTo actionWithDuration:0.3f scale:1.0f], nil]];
    
}
/////////////////////////////////////////////////////////////////

///////////////////// EXIT GAME /////////////////////////////////
-(void) addCloseButton
{
    closeBtn                   = [CCSprite spriteWithSpriteFrameName:@"menuBTN_close.png"];
    closeBtn.anchorPoint       = ccp(0.5f, 0.5f);
    closeBtn.position          = ccp(background_.position.x + background_.boundingBox.size.width/2, background_.position.y + background_.boundingBox.size.height/2);
    [SET_IMG addChild:closeBtn z:1];
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
