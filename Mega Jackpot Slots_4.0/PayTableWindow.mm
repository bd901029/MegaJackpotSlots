#import "PayTableWindow.h"
#import "PopupManager.h"

@implementation PayTableWindow


-(id)init_withMachineNR:(int)mNumber_
{
    if((self = [super init]))
    {
        
        [self setContentSize:CGSizeMake(kWidthScreen, kHeightScreen)];
        
        
        
        switch (mNumber_)
        {
            case 1:     tableStr_1 = @"01_cowboy_paytable_1.png";       tableStr_2 = @"01_cowboy_paytable_2.png";
            break;
                
            case 2:     tableStr_1 = @"05_megafood_paytable_1.png";       tableStr_2 = @"05_megafood_paytable_2.png";
            break;
                
            case 3:     tableStr_1 = @"04_fisher_paytable_1.png";       tableStr_2 = @"04_fisher_paytable_2.png";
            break;
                
            case 4:     tableStr_1 = @"03_pirate_paytable_1.png";       tableStr_2 = @"03_pirate_paytable_2.png";
            break;
                
            case 5:     tableStr_1 = @"02_muscle_paytable_1.png";     tableStr_2 = @"02_muscle_paytable_2.png";
            break;
                
            case 6:     tableStr_1 = @"06_farm_paytable_1.png";       tableStr_2 = @"06_farm_paytable_2.png";
            break;
                
            default:
                break;
        }
        
        table1             = [CCSprite spriteWithFile:tableStr_1];
        table1.scale       = (IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX);  
        table1.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        if (IS_STANDARD_IPHONE_6_PLUS) {
            table1.scale = 0.45;
        }
        [self addChild:table1 z:1];
        
        table2             = [CCSprite spriteWithFile:tableStr_2];
        table2.scale       = (IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX);
        table2.position    = ccp(kWidthScreen/2, kHeightScreen/2);
        table2.opacity     = 0;
        if (IS_STANDARD_IPHONE_6_PLUS) {
            table2.scale = 0.45;
        }
        [self addChild:table2 z:1];
        
        btnOn   = false;
        
        [self blackScreen_with_Z_order:0];
        [self addButtons];
    }
    
    return self;
}

-(void) addButtons
{
    closeBtn                  = [CCSprite spriteWithFile:@"paytable_back.png"];
    closeBtn.scale            = (IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX);
    closeBtn.position         = ccp(table1.position.x, table1.position.y - table1.boundingBox.size.height*0.50f);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        closeBtn.scale = 0.45;
    }
    [self addChild:closeBtn z:9];
    
    nextBtn                   = [CCSprite spriteWithFile:@"paytable_arrow.png"];
    nextBtn.scale             = (IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX);
    nextBtn.position          = ccp(closeBtn.position.x + closeBtn.boundingBox.size.width*1.10f, closeBtn.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        nextBtn.scale = 0.45;
    }
    [self addChild:nextBtn z:9];
    
    backBtn                   = [CCSprite spriteWithFile:@"paytable_arrow.png"];
    backBtn.scale             = (IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX);
    backBtn.flipX             = YES;
    backBtn.opacity           = 100;
    backBtn.position          = ccp(closeBtn.position.x - closeBtn.boundingBox.size.width*1.10f, closeBtn.position.y);
    if (IS_STANDARD_IPHONE_6_PLUS) {
        backBtn.scale = 0.45;
    }
    [self addChild:backBtn z:9];
}

-(void) onEnter
{    
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:kTOUCH_PRIORITY_PopUp swallowsTouches:YES];
    [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:7];

    [super onEnter];
}

-(void) onExit
{
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:8];
    [super onExit];
}



-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchPos = [[CCDirector sharedDirector] convertToGL:[touch locationInView:[touch view]]];
    
    id buttonAnimation1 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 0.9f];
    id buttonAnimation2 = [CCScaleTo actionWithDuration:0.1f scale:(IS_IPAD) ? kSCALE_FACTOR_FIX : (kSCALEVALY)*(kSCALE_FACTOR_FIX) * 1.0f];
    id runAnimation     = [CCSequence actions:buttonAnimation1, buttonAnimation2, nil];
    
    if (CGRectContainsPoint(closeBtn.boundingBox, touchPos))
    {
        [AUDIO playEffect:s_click1];
        [closeBtn runAction:runAnimation];
        [self closeWindow];
    }
    
    if (CGRectContainsPoint(nextBtn.boundingBox, touchPos))
    {
        if (btnOn == false)
        {
            [AUDIO playEffect:s_click1];
            [nextBtn runAction:runAnimation];
            backBtn.opacity = 255;
            nextBtn.opacity = 100;
            table1.opacity  =   0;
            table2.opacity  = 255;
            btnOn           = true;
        }
    }
    
    if (CGRectContainsPoint(backBtn.boundingBox, touchPos))
    {
        if (btnOn)
        {
            [AUDIO playEffect:s_click1];
            [backBtn runAction:runAnimation];
            backBtn.opacity = 100;
            nextBtn.opacity = 255;
            table1.opacity  = 255;
            table2.opacity  =   0;
            btnOn           = false;
        }
    }
    
    
    
    return YES;
}


-(void) closeWindow
{
    if ([_parent isKindOfClass:[PopupManager class]])
    {
        [_parent performSelector:@selector(closePayTableWindow) withObject:nil];
    }else{
        [self.parent removeChild:self];
    }
}

///////////////////// CREATE BLACK SCREEN ///////////////////////
-(void)blackScreen_with_Z_order:(int) Zorder_
{
    CCSprite *spr   = [CCSprite node];
    spr.textureRect = CGRectMake(0,0,kWidthScreen,kHeightScreen);
    spr.opacity     = 200;
    spr.anchorPoint = ccp(0, 0);
    spr.color       = ccc3(255,255,255);
    [self addChild:spr z:Zorder_ tag:kBlackSreen_TAG];
    
}










@end
