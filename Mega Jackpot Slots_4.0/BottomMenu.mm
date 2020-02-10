#import "BottomMenu.h"
#import "cfg.h"
#import "Constants.h"
#import "Bet.h"
#import "SlotMachine.h"
#import "Reels.h"
#import "Menu.h"
#define kReelsTag_   5

#import <Chartboost/Chartboost.h>
#import "IDsToReplace.h"

@implementation BottomMenu

-(NSString*)prefix
{
    if (IS_IPAD)return @"";return @"_iPhone";
}

//-(id)initWithRect:(CGRect)rect type:(int)type_
-(id)initWithRect:(CGRect)rect type:(int)TYPE lines:(int)LINES maxLines:(int)MAXLINES Bet:(float)BET
{
    if((self = [super init]))
    {
        self.position       = rect.origin;
        self.contentSize    = rect.size;
        
        numberBoostCounter = 0;
        
        BOTTOM_MENU_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_bottom_menu.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_bottom_menu.plist"]];
        [self addChild:BOTTOM_MENU_];
        
        if (IS_IPHONE && ![Combinations isRetina]) { iPhone3 = true; }
        
        
        spinPress_Active          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_spin_active.png"]];
        stopPress_Active          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_stop_active.png"]];
        linesPress_Active         = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_lines_active.png"]];
        betPress_Active           = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_bet_active.png"]];
        maxbetPress_Active        = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_maxbet_active.png"]];
        boostsPress_Active        = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_boosts_active.png"]];
        closePress_Active         = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_close_active.png"]];
        
        spinPress_notActive       = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_spin.png"]];
        stopPress_notActive       = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_stop.png"]];
        linesPress_notActive      = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_lines.png"]];
        betPress_notActive        = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_bet.png"]];
        maxbetPress_notActive     = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_maxbet.png"]];
        boostsPress_notActive     = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_boosts.png"]];
        closePress_notActive      = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_close.png"]];
        
        x2Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x2_active.png"]];
        x3Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x3_active.png"]];
        x4Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x4_active.png"]];
        x5Btn_Active                = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x5_active.png"]];
        buyMoreBtn_Active           = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_buymore_active.png"]];
        closeBtn_Active             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_close_active.png"]];
        
        x2Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x2.png"]];
        x3Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x3.png"]];
        x4Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x4.png"]];
        x5Btn_notActive             = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_x5.png"]];
        buyMoreBtn_notActive        = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_buymore.png"]];
        closeBtn_notActive          = [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"btn_close.png"]];

        
        // Check if menu type is for gameplay or for menu //
        if      (TYPE == 1)  { gamePlay = true;  }
        else if (TYPE == 2)  { gamePlay = false; }
        
        // Set labels font sizes //
        if (IS_IPAD)    { fSize = 16; lHeight = 6.5f;}
        else            { fSize = 10; lHeight = 8.0f;}
        
        lines_    = LINES;
        maxLines_ = MAXLINES;
        bet_      = BET;
        
        [self addBMenuLine];
        [self addButtons];
        [self addLinesLabel];
        [self addBetLabel];
        [self addMaxbetLabel];
        
        //[self setMaxLines:maxLines_];
        [self setLines:lines_];
        [self setBet:bet_];
        [self countTotalBet];
        
        [self addBoostsBtns];
        
        [self addAutospinLabel];
        
        [self addBoostsIndicators];
        [self buttonActive:YES];
        
    }
    
    return self;
}
-(int)getCurrentLine
{
    return lines_;
}

-(int)getCurrentMaxLine
{
    return maxLines_;
}

-(void)addBMenuLine
{
    menu_line = [CCSprite spriteWithSpriteFrameName:@"Bottom_panel.png"];
    menu_line.anchorPoint = ccp(0.5f, 0.5f);
    menu_line.position = ccp(kWidthScreen / 2, menu_line.contentSize.height/2);
    [BOTTOM_MENU_ addChild:menu_line z:5];
}

-(void)addButtons
{
    btnAligment = 1.8f; // change value for change distance between buttons.
    
    // --------------------------------------------------------------------------------------------------------------------------
    lines_button                = [CCSprite spriteWithSpriteFrameName:@"btn_lines.png"];
    lines_button.anchorPoint    = ccp(0.5f, 0.89f);
    lines_button.position       = ccp(menu_line.position.x - (menu_line.boundingBox.size.width/2) + lines_button.boundingBox.size.width/btnAligment, menu_line.position.y);
    [BOTTOM_MENU_ addChild:lines_button z:10];
    
    lines_field                 = [CCSprite spriteWithSpriteFrameName:@"lines_field.png"];
    lines_field.anchorPoint     = ccp(0.5f, 0.5f);
    lines_field.position        = ccp(lines_button.position.x, lines_button.position.y + (lines_button.boundingBox.size.width * 0.11f));
    [BOTTOM_MENU_ addChild:lines_field z:9];
    // --------------------------------------------------------------------------------------------------------------------------
    bet_button                  = [CCSprite spriteWithSpriteFrameName:@"btn_bet.png"];
    bet_button.anchorPoint      = ccp(0.5f, 0.89f);
    bet_button.position         = ccp(lines_button.position.x + (lines_button.boundingBox.size.width/2) + bet_button.boundingBox.size.width/btnAligment, menu_line.position.y);
    [BOTTOM_MENU_ addChild:bet_button z:10];
    
    bet_field                 = [CCSprite spriteWithSpriteFrameName:@"lines_field.png"];
    bet_field.anchorPoint     = ccp(0.5f, 0.5f);
    bet_field.position        = ccp(bet_button.position.x, lines_button.position.y + (bet_button.boundingBox.size.width * 0.11f));
    [BOTTOM_MENU_ addChild:bet_field z:9];
    // --------------------------------------------------------------------------------------------------------------------------
    maxbet_button               = [CCSprite spriteWithSpriteFrameName:@"btn_maxbet.png"];
    maxbet_button.anchorPoint   = ccp(0.5f, 0.89f);
    maxbet_button.position      = ccp(bet_button.position.x + (bet_button.boundingBox.size.width/2) + maxbet_button.boundingBox.size.width/btnAligment*0.99, menu_line.position.y);
    [BOTTOM_MENU_ addChild:maxbet_button z:10];
    
    maxbet_field                 = [CCSprite spriteWithSpriteFrameName:@"maxbet_field.png"];
    maxbet_field.anchorPoint     = ccp(0.5f, 0.5f);
    maxbet_field.position        = ccp(maxbet_button.position.x, lines_button.position.y + (maxbet_button.boundingBox.size.width * 0.09f));
    [BOTTOM_MENU_ addChild:maxbet_field z:9];
    // --------------------------------------------------------------------------------------------------------------------------
    boost_button                = [CCSprite spriteWithSpriteFrameName:@"btn_boosts.png"];
    boost_button.anchorPoint    = ccp(0.5f, 0.5f);
    boost_button.position       = ccp(maxbet_button.position.x + (maxbet_button.boundingBox.size.width/2) + boost_button.boundingBox.size.width/1.72, menu_line.position.y);
    [BOTTOM_MENU_ addChild:boost_button z:10];
    // --------------------------------------------------------------------------------------------------------------------------
    spin_button                 = [CCSprite spriteWithSpriteFrameName:@"btn_spin.png"];
    spin_button.anchorPoint     = ccp(0.5f, 0.5f);
    spin_button.position        = ccp(boost_button.position.x + (boost_button.boundingBox.size.width/2) + spin_button.boundingBox.size.width/btnAligment, menu_line.position.y);
    [BOTTOM_MENU_ addChild:spin_button z:10];
    // --------------------------------------------------------------------------------------------------------------------------

    // --------------------------------------------------------------------------------------------------------------------------
}

-(void) addBoostsBtns
{
    boost2xBtn                   = [CCSprite spriteWithSpriteFrameName:@"btn_x2.png"];
    boost2xBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boost2xBtn.position          = ccp(menu_line.position.x - menu_line.boundingBox.size.width/2 + boost2xBtn.boundingBox.size.width/2 + kWidthScreen*0.01f, kHeightScreen - kHeightScreen*1.2f);
    [BOTTOM_MENU_ addChild:boost2xBtn z:13];
    
    boost2xCounter                   = [CCSprite spriteWithSpriteFrameName:@"boost_counter.png"];
    //boost2xCounter.opacity           = 0;
    boost2xCounter.anchorPoint       = ccp(0.5f, 0.5f);
    boost2xCounter.position          = ccp(boost2xBtn.boundingBox.size.width*0.80f, boost2xBtn.boundingBox.size.height*0.95f);
    [boost2xBtn addChild:boost2xCounter z:9];
    /////////////////////////////////////////
    boost3xBtn                   = [CCSprite spriteWithSpriteFrameName:@"btn_x3.png"];
    boost3xBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boost3xBtn.position          = ccp(boost2xBtn.position.x + boost2xBtn.boundingBox.size.width/2 + boost3xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f);
    [BOTTOM_MENU_ addChild:boost3xBtn z:12];
    
    boost3xCounter                   = [CCSprite spriteWithSpriteFrameName:@"boost_counter.png"];
   // boost3xCounter.opacity           = 0;
    boost3xCounter.anchorPoint       = ccp(0.5f, 0.5f);
    boost3xCounter.position          = ccp(boost3xBtn.boundingBox.size.width*0.80f, boost3xBtn.boundingBox.size.height*0.95f);
    [boost3xBtn addChild:boost3xCounter z:9];
    /////////////////////////////////////////
    boost4xBtn                   = [CCSprite spriteWithSpriteFrameName:@"btn_x4.png"];
    boost4xBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boost4xBtn.position          = ccp(boost3xBtn.position.x + boost3xBtn.boundingBox.size.width/2 + boost4xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f);
    [BOTTOM_MENU_ addChild:boost4xBtn z:11];
    
    boost4xCounter                   = [CCSprite spriteWithSpriteFrameName:@"boost_counter.png"];
    //boost4xCounter.opacity           = 0;
    boost4xCounter.anchorPoint       = ccp(0.5f, 0.5f);
    boost4xCounter.position          = ccp(boost4xBtn.boundingBox.size.width*0.80f, boost4xBtn.boundingBox.size.height*0.95f);
    [boost4xBtn addChild:boost4xCounter z:9];
    /////////////////////////////////////////
    boost5xBtn                   = [CCSprite spriteWithSpriteFrameName:@"btn_x5.png"];
    boost5xBtn.anchorPoint       = ccp(0.5f, 0.5f);
    boost5xBtn.position          = ccp(boost4xBtn.position.x + boost4xBtn.boundingBox.size.width/2 + boost5xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f);
    [BOTTOM_MENU_ addChild:boost5xBtn z:10];
    
    boost5xCounter                   = [CCSprite spriteWithSpriteFrameName:@"boost_counter.png"];
    //boost5xCounter.opacity           = 0;
    boost5xCounter.anchorPoint       = ccp(0.5f, 0.5f);
    boost5xCounter.position          = ccp(boost5xBtn.boundingBox.size.width*0.80f, boost5xBtn.boundingBox.size.height*0.95f);
    [boost5xBtn addChild:boost5xCounter z:9];
    /////////////////////////////////////////
    buyMoreBtn                   = [CCSprite spriteWithSpriteFrameName:@"btn_buymore.png"];
    buyMoreBtn.anchorPoint       = ccp(0.5f, 0.5f);
    buyMoreBtn.position          = ccp(boost5xBtn.position.x + boost5xBtn.boundingBox.size.width/2 + buyMoreBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f);
    [BOTTOM_MENU_ addChild:buyMoreBtn z:9];
    
    
    [self addBoostCountLabels];
}

-(void) addBoostCountLabels
{
    count2xLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    count2xLabel.position = ccp(boost2xBtn.position.x + boost2xBtn.boundingBox.size.height*0.42f, menu_line.position.y + menu_line.boundingBox.size.height*0.36f);
    count2xLabel.color    = ccWHITE;
    count2xLabel.opacity  = 0;
    if (iPhone3) { count2xLabel.scale = 0.40f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        count2xLabel.scale = 1.6;
    }
    [self addChild:count2xLabel z:15];
    
    count3xLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    count3xLabel.position = ccp(boost3xBtn.position.x + boost3xBtn.boundingBox.size.height*0.42f, menu_line.position.y + menu_line.boundingBox.size.height*0.35f);
    count3xLabel.color    = ccWHITE;
    count3xLabel.opacity  = 0;
    if (iPhone3) { count3xLabel.scale = 0.40f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        count3xLabel.scale = 1.6;
    }
    [self addChild:count3xLabel z:15];
    
    count4xLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    count4xLabel.position = ccp(boost4xBtn.position.x + boost4xBtn.boundingBox.size.height*0.42f, menu_line.position.y + menu_line.boundingBox.size.height*0.36f);
    count4xLabel.color    = ccWHITE;
    count4xLabel.opacity  = 0;
    if (iPhone3) { count4xLabel.scale = 0.40f; }
    [self addChild:count4xLabel z:15];
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        count4xLabel.scale = 1.6;
    }
    
    count5xLabel          = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    count5xLabel.position = ccp(boost5xBtn.position.x + boost5xBtn.boundingBox.size.height*0.42f, menu_line.position.y + menu_line.boundingBox.size.height*0.36f);
    count5xLabel.color    = ccWHITE;
    count5xLabel.opacity  = 0;
    if (iPhone3) { count5xLabel.scale = 0.40f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        count5xLabel.scale = 1.6;
    }
    [self addChild:count5xLabel z:15];
}
-(void) updateBoostLabels
{
    [self checkAllBoostButton];
    
    int b2x = [DB_ getValueBy:d_Boost2x table:d_DB_Table];
    int b3x = [DB_ getValueBy:d_Boost3x table:d_DB_Table];
    int b4x = [DB_ getValueBy:d_Boost4x table:d_DB_Table];
    int b5x = [DB_ getValueBy:d_Boost5x table:d_DB_Table];
    [count2xLabel setString:[NSString stringWithFormat:@"%d", b2x]];
    [count3xLabel setString:[NSString stringWithFormat:@"%d", b3x]];
    [count4xLabel setString:[NSString stringWithFormat:@"%d", b4x]];
    [count5xLabel setString:[NSString stringWithFormat:@"%d", b5x]];

}

-(void) changeBoostsCounters_2xValue:(int)value2x_ _3xValue:(int)value3x_ _4xValue:(int)value4x_ _5xValue:(int)value5x_
{
    b2xVALUE = value2x_; b3xVALUE = value3x_; b4xVALUE = value4x_; b5xVALUE = value5x_;
    
    [count2xLabel setString:[NSString stringWithFormat:@"%d", value2x_]];
    [count3xLabel setString:[NSString stringWithFormat:@"%d", value3x_]];
    [count4xLabel setString:[NSString stringWithFormat:@"%d", value4x_]];
    [count5xLabel setString:[NSString stringWithFormat:@"%d", value5x_]];
    
    //int opac1 = 0;
    //int opac2 = 0;
    //int opac3 = 0;
    //int opac4 = 0;
    
    //if (value2x_ > 0) { opac1 = 255;}
    //if (value3x_ > 0) { opac2 = 255;}
    //if (value4x_ > 0) { opac3 = 255;}
    //if (value5x_ > 0) { opac4 = 255;}
    
    id delay1       = [CCDelayTime actionWithDuration:0.17f];
    id fadeIn1      = [CCFadeTo actionWithDuration:0.f opacity:255];
    id seq1         = [CCSequence actions:delay1, fadeIn1, nil];

    [count2xLabel runAction:seq1];
    [count3xLabel runAction:[seq1 copy]];
    [count4xLabel runAction:[seq1 copy]];
    [count5xLabel runAction:[seq1 copy]];
    
    //[boost2xCounter runAction:[seq1 copy]];
    //[boost3xCounter runAction:[seq1 copy]];
    //[boost4xCounter runAction:[seq1 copy]];
    //[boost5xCounter runAction:[seq1 copy]];
    
}

-(void) addBoostsIndicators
{
    b2xIndicator                   = [CCSprite spriteWithSpriteFrameName:@"spin_boost2x.png"];
    b2xIndicator.anchorPoint       = ccp(0.5f, 0.5f);
    b2xIndicator.position          = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f - kHeightScreen*0.50f);
    [BOTTOM_MENU_ addChild:b2xIndicator z:12];
    
    b3xIndicator                   = [CCSprite spriteWithSpriteFrameName:@"spin_boost3x.png"];
    b3xIndicator.anchorPoint       = ccp(0.5f, 0.5f);
    b3xIndicator.position          = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f - kHeightScreen*0.50f);
    [BOTTOM_MENU_ addChild:b3xIndicator z:12];
    
    b4xIndicator                   = [CCSprite spriteWithSpriteFrameName:@"spin_boost4x.png"];
    b4xIndicator.anchorPoint       = ccp(0.5f, 0.5f);
    b4xIndicator.position          = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f - kHeightScreen*0.50f);
    [BOTTOM_MENU_ addChild:b4xIndicator z:12];
    
    b5xIndicator                   = [CCSprite spriteWithSpriteFrameName:@"spin_boost5x.png"];
    b5xIndicator.anchorPoint       = ccp(0.5f, 0.5f);
    b5xIndicator.position          = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f - kHeightScreen*0.50f);
    [BOTTOM_MENU_ addChild:b5xIndicator z:12];
}

-(void) showBoostsIndicator:(int) indicator_
{
    indicatorNr = indicator_;
    
    [self hideBoostsIndicator];
    
    switch (indicator_)
    {
        case 2: b2xIndicator.position = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f); break;
        case 3: b3xIndicator.position = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f); break;
        case 4: b4xIndicator.position = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f); break;
        case 5: b5xIndicator.position = ccp(spin_button.position.x + spin_button.boundingBox.size.width*0.48f, spin_button.position.y + spin_button.boundingBox.size.height*0.40f); break;
            
        default:
            break;
    }
}

-(void) hideBoostsIndicator
{
    b2xIndicator.position = ccp(-100, -100);
    b3xIndicator.position = ccp(-100, -100);
    b4xIndicator.position = ccp(-100, -100);
    b5xIndicator.position = ccp(-100, -100);
}

-(void) update:(ccTime)delta
{
}

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)addLinesLabel
{
    
    linesLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    linesLabel.position = ccp(lines_field.position.x - lines_field.boundingBox.size.width/6, lines_field.position.y);
    linesLabel.color    = ccWHITE;
    if (iPhone3) { linesLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        linesLabel.scale = 1.6;
    }

    linesLab   = [CCLabelBMFont labelWithString:@"/" fntFile:kFONT_MENU];
    linesLab.position      = ccp(lines_field.position.x, lines_field.position.y);
    linesLab.color         = ccWHITE;
    if (iPhone3) { linesLab.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        linesLab.scale = 1.6;
    }
    
    MaxLinesLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    MaxLinesLabel.position  = ccp(lines_field.position.x + lines_field.boundingBox.size.width/6, lines_field.position.y);
    MaxLinesLabel.color     = ccWHITE;
    if (iPhone3) { MaxLinesLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        MaxLinesLabel.scale = 1.6;
    }
    
    [self addChild:linesLabel z:10];
    [self addChild:linesLab z:10];
    [self addChild:MaxLinesLabel z:10];
}

-(void)setLines:(int)linesValue
{
    lines_ = linesValue;
    [linesLabel setString:[NSString stringWithFormat:@"%d", lines_]];
}

-(void)setMaxLines:(int)MaxlinesValue
{
    maxLines_ = MaxlinesValue;
    [MaxLinesLabel setString:[NSString stringWithFormat:@"%d", maxLines_]];
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
-(void)countTotalBet
{
    maxbet_ = lines_ * bet_;
    [self setMaxbet:maxbet_];
}

-(void)addBetLabel
{
    betLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    betLabel.position = ccp(bet_field.position.x, bet_field.position.y);
    betLabel.color    = ccc3(233, 192, 0);
    if (iPhone3) { betLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        betLabel.scale = 1.6;
    }
    
    [self addChild:betLabel z:10];
}

-(float)getTotalBet
{
    return bet_ * lines_;
}

-(float)getCurrentBet
{
    return bet_;
}
-(float)getCurrentMaxBet
{
    return maxbet_;
}

-(void)setBet:(float)betValue
{
    bet_ = betValue;

    NSString *numberString;
    
    if (bet_ < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", bet_];
        [betLabel setString:numberString];
    }
    else
    {
        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
        NSString *stringFormated = [cfg formatTo3digitsValue:bet_];
        [betLabel setString:stringFormated];
    }
 
}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

-(void)addMaxbetLabel
{
    totalB  = [CCLabelBMFont labelWithString:@"Total:" fntFile:kFONT_MENU];
    totalB.position     = ccp((maxbet_field.position.x - maxbet_field.boundingBox.size.width*0.50f) + maxbet_field.boundingBox.size.width/4, maxbet_field.position.y);
    totalB.color        = ccc3(154, 154, 154);
    if (iPhone3) { totalB.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        totalB.scale = 1.6;
    }
    
    
    maxbetLabel = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_MENU];
    maxbetLabel.position = ccp(totalB.position.x + totalB.boundingBox.size.width*0.60f, maxbet_field.position.y);
    maxbetLabel.color    = ccc3(233, 192, 0);
    maxbetLabel.anchorPoint = ccp(0, 0.5f);
    if (iPhone3) { maxbetLabel.scale = 0.60f; }
    if (IS_STANDARD_IPHONE_6_PLUS||IS_IPAD) {
        maxbetLabel.scale = 1.6;
    }
    
    [self addChild:totalB z:10];
    [self addChild:maxbetLabel z:10];
}

-(void)setMaxbet:(float)maxbetValue
{
    maxbet_ = maxbetValue;
    
    NSString *numberString;
    
    if (maxbet_ < 10) {
        numberString = [NSString stringWithFormat:@"%.1f0", maxbet_];
        [maxbetLabel setString:numberString];
    }
    else
    {
        // numberString = [NSString stringWithFormat:@"%.0f", final_coins];
        NSString *stringFormated = [cfg formatTo3digitsValue:maxbet_];
        [maxbetLabel setString:stringFormated];
    }
    
}
-(void) openBoostsUse
{
    if ([boost2xBtn getActionByTag:1]) {
        return;
    }
    
    id moveUp_boostx2 = [CCMoveTo actionWithDuration:0.2f position:ccp(menu_line.position.x  - menu_line.boundingBox.size.width/2  + boost2xBtn.boundingBox.size.width/2 + kWidthScreen*0.01f,  menu_line.position.y)];
    id moveUp_boostx3 = [CCMoveTo actionWithDuration:0.2f position:ccp(boost2xBtn.position.x + boost2xBtn.boundingBox.size.width/2 + boost3xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, menu_line.position.y)];
    id moveUp_boostx4 = [CCMoveTo actionWithDuration:0.2f position:ccp(boost3xBtn.position.x + boost3xBtn.boundingBox.size.width/2 + boost4xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, menu_line.position.y)];
    id moveUp_boostx5 = [CCMoveTo actionWithDuration:0.2f position:ccp(boost4xBtn.position.x + boost4xBtn.boundingBox.size.width/2 + boost5xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, menu_line.position.y)];
    id moveUp_buymore = [CCMoveTo actionWithDuration:0.2f position:ccp(boost5xBtn.position.x + boost5xBtn.boundingBox.size.width/2 + buyMoreBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, menu_line.position.y)];
    
    [boost2xBtn runAction:moveUp_boostx2].tag = 1;
    [boost3xBtn runAction:moveUp_boostx3];
    [boost4xBtn runAction:moveUp_boostx4];
    [boost5xBtn runAction:moveUp_boostx5];
    [buyMoreBtn runAction:moveUp_buymore];
    
    useBoostsOPENED = true;
    
    /////////////////////////////
    
    id moveDown_linesButton    = [CCMoveTo actionWithDuration:0.2f position:ccp(menu_line.position.x - (menu_line.boundingBox.size.width/2) + lines_button.boundingBox.size.width/btnAligment,         kHeightScreen - kHeightScreen*1.2f)];
    id moveDown_betButton      = [CCMoveTo actionWithDuration:0.2f position:ccp(lines_button.position.x + (lines_button.boundingBox.size.width/2) + bet_button.boundingBox.size.width/btnAligment,     kHeightScreen - kHeightScreen*1.2f)];
    id moveDown_maxbetButton   = [CCMoveTo actionWithDuration:0.2f position:ccp(bet_button.position.x + (bet_button.boundingBox.size.width/2) + maxbet_button.boundingBox.size.width/btnAligment*0.99, kHeightScreen - kHeightScreen*1.2f)];
    
    [lines_button   runAction:moveDown_linesButton];
    [bet_button     runAction:moveDown_betButton];    
    [maxbet_button  runAction:moveDown_maxbetButton];
    
    int boost2x = [DB_ getValueBy:d_Boost2x table:d_DB_Table];
    int boost3x = [DB_ getValueBy:d_Boost3x table:d_DB_Table];
    int boost4x = [DB_ getValueBy:d_Boost4x table:d_DB_Table];
    int boost5x = [DB_ getValueBy:d_Boost5x table:d_DB_Table];
    
    [self changeBoostsCounters_2xValue:boost2x _3xValue:boost3x _4xValue:boost4x _5xValue:boost5x];
    
    lines_field.opacity     = 0;
    bet_field.opacity       = 0;
    maxbet_field.opacity    = 0;
    
    linesLab.opacity        = 0;
    linesLabel.opacity      = 0;
    MaxLinesLabel.opacity   = 0;
    betLabel.opacity        = 0;
    totalB.opacity          = 0;
    maxbetLabel.opacity     = 0;

}

-(void) closeBoostsUse
{
    if ([boost2xBtn getActionByTag:2]) {
        return;
    }
    
    id moveDown_boostx2 = [CCMoveTo actionWithDuration:0.2f position:ccp(menu_line.position.x  - menu_line.boundingBox.size.width/2  + boost2xBtn.boundingBox.size.width/2 + kWidthScreen*0.01f,  kHeightScreen - kHeightScreen*1.2f)];
    id moveDown_boostx3 = [CCMoveTo actionWithDuration:0.2f position:ccp(boost2xBtn.position.x + boost2xBtn.boundingBox.size.width/2 + boost3xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f)];
    id moveDown_boostx4 = [CCMoveTo actionWithDuration:0.2f position:ccp(boost3xBtn.position.x + boost3xBtn.boundingBox.size.width/2 + boost4xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f)];
    id moveDown_boostx5 = [CCMoveTo actionWithDuration:0.2f position:ccp(boost4xBtn.position.x + boost4xBtn.boundingBox.size.width/2 + boost5xBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f)];
    id moveDown_buymore = [CCMoveTo actionWithDuration:0.2f position:ccp(boost5xBtn.position.x + boost5xBtn.boundingBox.size.width/2 + buyMoreBtn.boundingBox.size.width/2 + kWidthScreen*0.003f, kHeightScreen - kHeightScreen*1.2f)];
    
    [boost2xBtn runAction:moveDown_boostx2].tag = 2;
    [boost3xBtn runAction:moveDown_boostx3];
    [boost4xBtn runAction:moveDown_boostx4];
    [boost5xBtn runAction:moveDown_boostx5];
    [buyMoreBtn runAction:moveDown_buymore];
    
    useBoostsOPENED = false;
    
    /////////////////////////////
    
    id moveUp_linesButton     = [CCMoveTo actionWithDuration:0.2f position:ccp(menu_line.position.x - (menu_line.boundingBox.size.width/2) + lines_button.boundingBox.size.width/btnAligment,           menu_line.position.y)];
    id moveUp_betButton       = [CCMoveTo actionWithDuration:0.2f position:ccp(lines_button.position.x + (lines_button.boundingBox.size.width/2) + bet_button.boundingBox.size.width/btnAligment,       menu_line.position.y)];
    id moveUp_maxbetButton    = [CCMoveTo actionWithDuration:0.2f position:ccp(bet_button.position.x + (bet_button.boundingBox.size.width/2) + maxbet_button.boundingBox.size.width/btnAligment*0.99,   menu_line.position.y)];
    
    [lines_button   runAction:moveUp_linesButton];
    [bet_button     runAction:moveUp_betButton];
    [maxbet_button  runAction:moveUp_maxbetButton];

    
    lines_field.opacity     = 255;
    bet_field.opacity       = 255;
    maxbet_field.opacity    = 255;
    
    linesLab.opacity        = 255;
    linesLabel.opacity      = 255;
    MaxLinesLabel.opacity   = 255;
    betLabel.opacity        = 255;
    totalB.opacity          = 255;
    maxbetLabel.opacity     = 255;
//    
//    boost2xCounter.opacity  = 0;
//    boost3xCounter.opacity  = 0;
//    boost4xCounter.opacity  = 0;
//    boost5xCounter.opacity  = 0;
    
    count2xLabel.opacity    = 0;
    count3xLabel.opacity    = 0;
    count4xLabel.opacity    = 0;
    count5xLabel.opacity    = 0;

}
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////


////////////////////////////////////////////////////////////////////////////////////////////

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

-(void)openBoostsMenu:(int)integ
{
    
}

-(BOOL) checkIfBoostActive:(int)number
{
    NSString *s;
    switch (number) {
        case 2:s = d_Boost2x;break;
        case 3:s = d_Boost3x;break;
        case 4:s = d_Boost4x;break;
        case 5:s = d_Boost5x;break;
        default:break;
    }
    int nBoost = [DB_ getValueBy:s table:d_DB_Table];
    
    if (nBoost <= 0) {
        return NO;
    }
    
    return YES;
}

-(void)boostButtonsActv:(CCSprite *)node_ frame:(CCSpriteFrame *)frame_ int_:(int)int__
{

    [(Reels *)[_parent getChildByTag:kReelsTag_] allBoostDeactivate];
    
    if (int__ == numberOfBoost) {
            
        [boost2xBtn setDisplayFrame:x2Btn_notActive];
        [boost3xBtn setDisplayFrame:x3Btn_notActive];
        [boost4xBtn setDisplayFrame:x4Btn_notActive];
        [boost5xBtn setDisplayFrame:x5Btn_notActive];
        
        [self hideBoostsIndicator];
        
        numberOfBoost = 0;
    
        return;
    }
    
    [boost2xBtn setDisplayFrame:x2Btn_notActive];
    [boost3xBtn setDisplayFrame:x3Btn_notActive];
    [boost4xBtn setDisplayFrame:x4Btn_notActive];
    [boost5xBtn setDisplayFrame:x5Btn_notActive];
    
    [node_ setDisplayFrame:frame_];
    [self showBoostsIndicator:int__];
    numberOfBoost = int__;
    
    [(SlotMachine *)_parent boostEnabled:int__];
    
}

-(void)checkAllBoostButton
{
    for (int i = 2; i<=5; i++) {
        
        if (![self checkIfBoostActive:i]) {
            switch (i) {
                case 2:[boost2xBtn runAction:[CCTintTo actionWithDuration:0 red:130 green:130 blue:130]];
                    [boost2xBtn setDisplayFrame:x2Btn_notActive]; break;
                case 3:[boost3xBtn runAction:[CCTintTo actionWithDuration:0 red:130 green:130 blue:130]];
                    [boost3xBtn setDisplayFrame:x3Btn_notActive]; break;
                case 4:[boost4xBtn runAction:[CCTintTo actionWithDuration:0 red:130 green:130 blue:130]];
                    [boost4xBtn setDisplayFrame:x4Btn_notActive];break;
                case 5:[boost5xBtn runAction:[CCTintTo actionWithDuration:0 red:130 green:130 blue:130]];
                    [boost5xBtn setDisplayFrame:x5Btn_notActive];break;
                default:break;
            }
        }
        else
        {
            switch (i) {
                case 2:[boost2xBtn runAction:[CCTintTo actionWithDuration:0 red:255 green:255 blue:255]];break;
                case 3:[boost3xBtn runAction:[CCTintTo actionWithDuration:0 red:255 green:255 blue:255]];  break;
                case 4:[boost4xBtn runAction:[CCTintTo actionWithDuration:0 red:255 green:255 blue:255]];  break;
                case 5:[boost5xBtn runAction:[CCTintTo actionWithDuration:0 red:255 green:255 blue:255]];  break;
                default:break;
            }

        }
    }
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];
    
    if ((CGRectContainsPoint(lines_button.boundingBox, touchPos)) && b_buttonsActive)
    {
        [lines_button setDisplayFrame:linesPress_Active];
        
        [AUDIO playEffect:s_click1];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Lines Button"
                                                               label:nil
                                                               value:nil] build]];

        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
            [(SlotMachine *)_parent lineUP];
            [self countTotalBet];
        }], nil]];
        
    }
    else if ((CGRectContainsPoint(bet_button.boundingBox, touchPos)) && b_buttonsActive)
    {
       id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Bet Button"
                                                               label:nil
                                                               value:nil] build]];
        [bet_button setDisplayFrame:betPress_Active];
        
        [AUDIO playEffect:s_click1];
        
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
            [(SlotMachine *)_parent betUp];
            [self countTotalBet];
        }], nil]];
        
    }
    else if ((CGRectContainsPoint(maxbet_button.boundingBox, touchPos)) && b_buttonsActive)
    {
        [maxbet_button setDisplayFrame:maxbetPress_Active];
        
        [AUDIO playEffect:s_click1];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked MaxBet Button"
                                                               label:nil
                                                               value:nil] build]];

        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
            [(SlotMachine *)_parent setMaxBet];
            [self countTotalBet];
            [(SlotMachine *)_parent spin];
        }], nil]];
       
    }
    else if ((CGRectContainsPoint(boost_button.boundingBox, touchPos)) && b_buttonsActive && (![boost2xBtn getActionByTag:2]) && (![boost2xBtn getActionByTag:1]))
    {
        [AUDIO playEffect:s_click1];
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Boost Button"
                                                               label:nil
                                                               value:nil] build]];

        [self checkAllBoostButton];
        
            if (useBoostsOPENED)
            {
                [boost_button setDisplayFrame:closePress_Active];
                [self closeBoostsUse];
            }
            else
            {
                [boost_button setDisplayFrame:boostsPress_Active];
                [self openBoostsUse];
            }
        
    }
    else if (CGRectContainsPoint(spin_button.boundingBox, touchPos))
    {
        
        if (b_buttonsActive)
        {
           id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                                  action:@"Clicked Spin Button"
                                                                   label:nil
                                                                   value:nil] build]];
            [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"SpinsFromLaunch"]+1 forKey:@"SpinsFromLaunch"];
            [[NSUserDefaults standardUserDefaults] synchronize];

            [spin_button setDisplayFrame:spinPress_Active];
            
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
                [(SlotMachine *)_parent spin];
                // [AUDIO playEffect:s_click1];
               // [(SlotMachine *)_parent coinDropAnimation];
            }], nil]];
        }
        else
        {
            id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
            
            [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                                  action:@"Clicked Stop Button"
                                                                   label:nil
                                                                   value:nil] build]];

            [spin_button setDisplayFrame:stopPress_Active];//STOP BUTTON
            
            [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
                [(SlotMachine *)_parent stopSpinning];
            }], nil]];
        }
        
    }
    
    
    // [boost2xBtn setDisplayFrame:x2Btn_notActive];
    // [boost3xBtn setDisplayFrame:x3Btn_notActive];
    // [boost4xBtn setDisplayFrame:x4Btn_notActive];
    // [boost5xBtn setDisplayFrame:x5Btn_notActive];
    
    if ((CGRectContainsPoint(boost2xBtn.boundingBox, touchPos)) && b_buttonsActive)
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Boost2x Button"
                                                               label:nil
                                                               value:nil] build]];

        if ([self checkIfBoostActive:2]) {
                [AUDIO playEffect:s_click1];
                [self boostButtonsActv:boost2xBtn frame:x2Btn_Active int_:2];
           
        }
    }
    
    if ((CGRectContainsPoint(boost3xBtn.boundingBox, touchPos)) && b_buttonsActive)
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Boost3x Button"
                                                               label:nil
                                                               value:nil] build]];
        if ([self checkIfBoostActive:3]) {
                [AUDIO playEffect:s_click1];
                [self boostButtonsActv:boost3xBtn frame:x3Btn_Active int_:3];
            
        }
    }
    
    if ((CGRectContainsPoint(boost4xBtn.boundingBox, touchPos)) && b_buttonsActive)
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Boost4x Button"
                                                               label:nil
                                                               value:nil] build]];
        if ([self checkIfBoostActive:4]) {
                [AUDIO playEffect:s_click1];
                [self boostButtonsActv:boost4xBtn frame:x4Btn_Active int_:4];
            
        }
        
    }
    
    if ((CGRectContainsPoint(boost5xBtn.boundingBox, touchPos)) && b_buttonsActive)
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked Boost5x Button"
                                                               label:nil
                                                               value:nil] build]];
        if ([self checkIfBoostActive:5]) {
                [AUDIO playEffect:s_click1];
                [self boostButtonsActv:boost5xBtn frame:x5Btn_Active int_:5];
            
        }
    }
    if ((CGRectContainsPoint(buyMoreBtn.boundingBox, touchPos)) && b_buttonsActive)
    {
        id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
        
        [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Game"
                                                              action:@"Clicked BuyMore Button"
                                                               label:nil
                                                               value:nil] build]];
        [buyMoreBtn setDisplayFrame:buyMoreBtn_Active];
        [AUDIO playEffect:s_click1];
        [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.05f],[CCCallBlock actionWithBlock:^{
            if (![(TopMenu *)[(SlotMachine *)_parent getChildByTag:kTopMenuTAG] getChildByTag:kBuyWindowTAG]){
                //[(TopMenu *)[(SlotMachine *)_parent getChildByTag:kTopMenuTAG] openBuyWindow];
            }
        }], nil]];
        
    }
    
    return YES;
}


-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [self convertTouchToNodeSpace:touch];


    //////////////////// LINES BUTTON TOUCH END /////////////////////
    if ((CGRectContainsPoint(lines_button.boundingBox, touchPos)) && b_buttonsActive)
    {
        
    }
    //////////////////// BET BUTTON TOUCH END ///////////////////////
    else if ((CGRectContainsPoint(bet_button.boundingBox, touchPos)) && b_buttonsActive)
    {
        
    }
    //////////////////// MAX BET BUTTON TOUCH END ////////////////////
    else if ((CGRectContainsPoint(maxbet_button.boundingBox, touchPos)) && b_buttonsActive)
    {
        
    }
    //////////////////// BOOSTS BUTTON TOUCH END /////////////////////
    else if ((CGRectContainsPoint(boost_button.boundingBox, touchPos)) && b_buttonsActive)
    {
            /*if (useBoostsOPENED)
            {
                            [self delay_ToBoost];
            }
            else
            {
                            [self delay_ToClose];
            }*/
        
    }
    //////////////////// SPIN BUTTON TOUCH END /////////////////////
    else if (CGRectContainsPoint(spin_button.boundingBox, touchPos))
    {

    }
    
    
    //////////////////// BOOST 2x BUTTON TOUCH END /////////////////
    if (CGRectContainsPoint(boost2xBtn.boundingBox, touchPos))
    {
        
    }
    //////////////////// BOOST 3x BUTTON TOUCH END /////////////////
    if (CGRectContainsPoint(boost3xBtn.boundingBox, touchPos))
    {
        
    }
    //////////////////// BOOST 4x BUTTON TOUCH END /////////////////
    if (CGRectContainsPoint(boost4xBtn.boundingBox, touchPos))
    {
      
    }
    //////////////////// BOOST 5x BUTTON TOUCH END /////////////////
    if (CGRectContainsPoint(boost5xBtn.boundingBox, touchPos))
    {
      
    }
    /////////////// BUY MORE BOOSTS BUTTON TOUCH END ///////////////
    if (CGRectContainsPoint(buyMoreBtn.boundingBox, touchPos))
    {
        [buyMoreBtn setDisplayFrame:buyMoreBtn_notActive];
        [self openBoostsWindow];
    }
    
    ///////////////// BACK ALL BUTTONS NORMAL STATE ////////////////
    [lines_button setDisplayFrame:linesPress_notActive];
    [bet_button setDisplayFrame:betPress_notActive];
    [maxbet_button setDisplayFrame:maxbetPress_notActive];
    if (b_buttonsActive)
    {
            [spin_button setDisplayFrame:spinPress_notActive];
    }
    else
    {
            [spin_button setDisplayFrame:stopPress_notActive];
    }
  
    
   // [boost2xBtn setDisplayFrame:x2Btn_notActive];
   // [boost3xBtn setDisplayFrame:x3Btn_notActive];
   // [boost4xBtn setDisplayFrame:x4Btn_notActive];
   // [boost5xBtn setDisplayFrame:x5Btn_notActive];
    
    [buyMoreBtn setDisplayFrame:buyMoreBtn_notActive];
    
    if (useBoostsOPENED) {
        [boost_button setDisplayFrame:closeBtn_notActive]; }
    else                 {
        [boost_button setDisplayFrame:boostsPress_notActive]; }

}
-(void) openBoostsWindow
{
    // Call method name "openBuyWindow" from TopMenu class
    [(TopMenu *)[_parent getChildByTag:kTopMenuTAG] openBuyWindow_withNR:[NSNumber numberWithInt:2]];
}
-(void)buttonActive:(bool)bool_
{
    b_buttonsActive = bool_;
    
    if (bool_) {
        
        [(TopMenu *)[(SlotMachine *)_parent getChildByTag:kTopMenuTAG] activeButtons:bool_];
        
        [spin_button setDisplayFrame:spinPress_notActive];
        
        id tintIn = [CCTintTo actionWithDuration:0.1f red:255 green:255 blue:255];
        
        [lines_button   runAction:tintIn];
        [bet_button     runAction:[tintIn copy]];
        [maxbet_button  runAction:[tintIn copy]];
        [boost_button   runAction:[tintIn copy]];
        //[boost2xBtn     runAction:[tintIn copy]];
        //[boost3xBtn     runAction:[tintIn copy]];
        //[boost4xBtn     runAction:[tintIn copy]];
        //[boost5xBtn     runAction:[tintIn copy]];
        [buyMoreBtn     runAction:[tintIn copy]];
        [boost2xCounter runAction:[tintIn copy]];
        [boost3xCounter runAction:[tintIn copy]];
        [boost4xCounter runAction:[tintIn copy]];
        [boost5xCounter runAction:[tintIn copy]];
        [count2xLabel   runAction:[tintIn copy]];
        [count3xLabel   runAction:[tintIn copy]];
        [count4xLabel   runAction:[tintIn copy]];
        [count5xLabel   runAction:[tintIn copy]];
        
        [self checkAllBoostButton];
        
    }
    else{
        
        [(TopMenu *)[(SlotMachine *)_parent getChildByTag:kTopMenuTAG] activeButtons:bool_];
        
        [spin_button setDisplayFrame:stopPress_notActive];
        
        id tintOut = [CCTintTo actionWithDuration:0.1f red:130 green:130 blue:130];
        
        [lines_button   runAction:tintOut];
        [bet_button     runAction:[tintOut copy]];
        [maxbet_button  runAction:[tintOut copy]];
        [boost_button   runAction:[tintOut copy]];
        [boost2xBtn     runAction:[tintOut copy]];
        [boost3xBtn     runAction:[tintOut copy]];
        [boost4xBtn     runAction:[tintOut copy]];
        [boost5xBtn     runAction:[tintOut copy]];
        [buyMoreBtn     runAction:[tintOut copy]];
        [boost2xCounter runAction:[tintOut copy]];
        [boost3xCounter runAction:[tintOut copy]];
        [boost4xCounter runAction:[tintOut copy]];
        [boost5xCounter runAction:[tintOut copy]];
        [count2xLabel   runAction:[tintOut copy]];
        [count3xLabel   runAction:[tintOut copy]];
        [count4xLabel   runAction:[tintOut copy]];
        [count5xLabel   runAction:[tintOut copy]];
    }
    
}

-(void) closeBUseWindowAnimation
{
    [[self getChildByTag:kBoUWindowTAG] runAction: [CCEaseInOut actionWithAction:[CCMoveTo actionWithDuration:0.2f position:ccp(0, -(kHeightScreen * 0.15f))] rate:2]];
}

-(void) closeBUseWindow
{
    [self closeBUseWindowAnimation];
    [self delay];
}

-(void) CloseAfterAnimation
{
    [self removeChild:[self getChildByTag:kBoUWindowTAG] cleanup:YES];
}

-(void)delay
{
    [self performSelector:@selector(CloseAfterAnimation) withObject:nil afterDelay:0.3f];
}


///////////////////////////////////////////////////////////////////////////////////////
////////////////////////////////// AUTO SPIN //////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////
-(void)runAutospin
{
    [self hideElementOnAutospin];
    
    CCAction *fadeIN1 = [CCFadeTo actionWithDuration:0.5f opacity:255.0];
    CCAction *fadeIN2 = [CCFadeTo actionWithDuration:0.5f opacity:255.0];
    [aSpinLabelTxt runAction:fadeIN1];
    [aSpinLabelNr runAction:fadeIN2];
}

-(void)exitAutospin
{
    [self showElementOnAutospin];
    
    CCAction *fadeOUT1 = [CCFadeTo actionWithDuration:0.01f opacity:0.0];
    CCAction *fadeOUT2 = [CCFadeTo actionWithDuration:0.01f opacity:0.0];
    [aSpinLabelTxt runAction:fadeOUT1];
    [aSpinLabelNr runAction:fadeOUT2];
}

-(void)addAutospinLabel
{
    aSpinLabelTxt               = [CCLabelBMFont labelWithString:@"SPINS LEFT: " fntFile:kFONT_FREE_SPIN];
    aSpinLabelTxt.position      = ccp(menu_line.position.x - menu_line.boundingBox.size.width*0.10f, menu_line.position.y);
    aSpinLabelTxt.color         = ccc3(233, 192, 0);
    aSpinLabelTxt.opacity       = 0;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        aSpinLabelTxt.scale = 1.5;
    }
    [self addChild:aSpinLabelTxt z:10];
    
    
    aSpinLabelNr                = [CCLabelBMFont labelWithString:@"" fntFile:kFONT_FREE_SPIN];
    aSpinLabelNr.anchorPoint    = ccp(0, 0.5f);
    aSpinLabelNr.position       = ccp(aSpinLabelTxt.position.x + aSpinLabelTxt.boundingBox.size.width*0.50f, aSpinLabelTxt.position.y);
    aSpinLabelNr.color          = ccc3(233, 192, 0);
    aSpinLabelNr.opacity       = 0;
    if (IS_STANDARD_IPHONE_6_PLUS) {
        aSpinLabelNr.scale = 1.5;
    }
    [self addChild:aSpinLabelNr z:10];
}

-(void)updateSpinLeft:(int)spinLeft_
{
    [aSpinLabelNr setString:[NSString stringWithFormat:@"%d", spinLeft_]];
    
}

-(void)hideElementOnAutospin
{
    lines_button.opacity    = 0;
    bet_button.opacity      = 0;
    maxbet_button.opacity   = 0;
    boost_button.opacity    = 0;
    
    lines_field.opacity     = 0;
    bet_field.opacity       = 0;
    maxbet_field.opacity    = 0;
    
    linesLab.opacity        = 0;
    linesLabel.opacity      = 0;
    MaxLinesLabel.opacity   = 0;
    betLabel.opacity        = 0;
    totalB.opacity          = 0;
    maxbetLabel.opacity     = 0;
    
    buyMoreBtn.opacity      = 0;
    boost2xBtn.opacity      = 0;
    boost3xBtn.opacity      = 0;
    boost4xBtn.opacity      = 0;
    boost5xBtn.opacity      = 0;
    
    boost2xCounter.opacity  = 0;
    boost3xCounter.opacity  = 0;
    boost4xCounter.opacity  = 0;
    boost5xCounter.opacity  = 0;
    
    count2xLabel.opacity    = 0;
    count3xLabel.opacity    = 0;
    count4xLabel.opacity    = 0;
    count5xLabel.opacity    = 0;
    
}

-(void) showElementOnAutospin
{
    if (useBoostsOPENED)
    {
        [self closeBoostsUse];
        [boost_button setDisplayFrame:boostsPress_notActive];
    }
    
    lines_button.opacity    = 255;
    bet_button.opacity      = 255;
    maxbet_button.opacity   = 255;
    boost_button.opacity    = 255;
    
    lines_field.opacity     = 255;
    bet_field.opacity       = 255;
    maxbet_field.opacity    = 255;
    
    linesLab.opacity        = 255;
    linesLabel.opacity      = 255;
    MaxLinesLabel.opacity   = 255;
    betLabel.opacity        = 255;
    totalB.opacity          = 255;
    maxbetLabel.opacity     = 255;
    
    boost2xCounter.opacity  = 255;
    boost3xCounter.opacity  = 255;
    boost4xCounter.opacity  = 255;
    boost5xCounter.opacity  = 255;
    
    buyMoreBtn.opacity      = 255;
    boost2xBtn.opacity      = 255;
    boost3xBtn.opacity      = 255;
    boost4xBtn.opacity      = 255;
    boost5xBtn.opacity      = 255;
}
///////////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////

-(void) closeWindowBuy2
{
    [self removeChild:[self getChildByTag:kBooWindowTAG] cleanup:YES];
}


@end

