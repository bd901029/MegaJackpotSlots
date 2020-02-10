

#import "Slots_Animation.h"
#import "cfg.h"
#import "SCombinations.h"
#import "CCMaskedSprite.h"


#define k_TAG_SPRITESHEET 100
#define k_FIRST_IMAGE 200

#define kParticles 300
#define kTagMarkedSprite 500

#define kTagIconAnimation 800

@implementation Slots_Animation

- (id)initWithFrame:(CGRect)frame node:(CCNode *)par machineNr:(int)id_ iconNr:(int)nr_ elements:(NSArray *)el_
{
    self = [super init];
    if (self) {
        
        randomeElements = el_;
        
        machineNumber = id_;
        iconNumber = nr_;
        
        myParent = par;
        //[self loadSpriteSheetOfMachine];
        [self loadFirstMachine];
        
    }
    return self;
}
- (void)removeWinSquare
{
    if ([[self getChildByTag:1] getActionByTag:22]) {
        [[self getChildByTag:1] stopActionByTag:22];
    }
    if ([self getChildByTag:kParticles]) {
        [[self getChildByTag:kParticles]removeFromParent];
    }
    if ([self getChildByTag:kTagMarkedSprite]) {
        [[self getChildByTag:kTagMarkedSprite]removeFromParent];
    }
    for (int i = 0; i < 3; i++) {
        if ([self getChildByTag:i]) {
            [[self getChildByTag:i] removeFromParent];
        }
    }
}

- (void)addSquareToIcon
{
    if ([self getChildByTag:0]) {
        return;
    }
    
    NSString *ss = [NSString stringWithFormat:@"%@",[randomeElements objectAtIndex:iconNumber]];
    
    for (int i = 0; i<3; i++) {
        CCSprite *s = [CCSprite spriteWithSpriteFrameName:[NSString stringWithFormat:@"win_s%i.png",i]];
        s.anchorPoint = ccp(0.5f, 0.5f);
        s.position = ccp(0, 0);
        
        if (i == 0) {
            s.opacity = 200;
        }
        else if (i == 1)
        {
            s.opacity = 10;
            [s runAction:[CCFadeTo actionWithDuration:0.15 opacity:255]];
        }
        
        [self addChild:s z:i tag:i];
    }
    
    CCSprite *s = (CCSprite *)[self getChildByTag:2];
    
    CCParticleSystemQuad *effect = [CCParticleSystemQuad particleWithFile:[NSString stringWithFormat: @"win_particles.plist"]];
    effect.position = ccp(s.position.x - s.contentSize.width/2,s.position.y - s.contentSize.height/2);
    
    if (IS_IPHONE) {
        effect.startSize = 30;
    }

    
    if ((![ss isEqualToString:k10]) && (![ss isEqualToString:kK]) && (![ss isEqualToString:kA]) && (![ss isEqualToString:kJ]) && (![ss isEqualToString:kQ])) {
        
        if (([ss isEqualToString:kSCATER]) || ([ss isEqualToString:kBONUS]) || ([ss isEqualToString:kWILD]))
        {
            effect.startColor = ccc4f(1, 0.78, 0, 1);
            effect.endColor = ccc4f(1, 0, 0, 0);
        }
        else
        {
            effect.endColor = ccc4f(255, 186, 0, 255);
            effect.endColorVar = ccc4f(255, 186, 0, 255);
        }
        
        
    }
        
    [self addChild:effect z:4 tag:kParticles];
    
    effect.autoRemoveOnFinish = NO;
    

    id opacityOFF       =   [CCFadeTo actionWithDuration:0.1f opacity:70];
    
    id opacityON        =   [CCFadeTo actionWithDuration:0.1f opacity:255];
    
    id tintON           =   [CCTintTo actionWithDuration:0.1f red:24 green:145 blue:159];
    
    id tintON1          =   [CCTintTo actionWithDuration:0.1f red:159 green:24 blue:72];
    
    id tintON2          =   [CCTintTo actionWithDuration:0.1f red:123 green:159 blue:24];
    
    id tintOFF          =   [CCTintTo actionWithDuration:0.1f red:0 green:0 blue:0];
    
    id spawnOFF         =   [CCSpawn actions:opacityOFF,tintOFF, nil];
    
    id spawnON          =   [CCSpawn actions:opacityON,tintON, nil];
    
    id spawnON1         =   [CCSpawn actions:opacityON,tintON1, nil];
    
    id spawnON2         =   [CCSpawn actions:opacityON,tintON2, nil];
    
    id sequance         =   [CCSequence actions:spawnOFF,spawnON,spawnOFF,spawnON1,spawnOFF,spawnON2, nil];
    
    id repeatforever    =   [CCRepeatForever actionWithAction:sequance];
    
    [[self getChildByTag:1] runAction:repeatforever].tag = 22;
    
    [effect runAction:[CCRepeatForever actionWithAction:[CCSequence actions:
                                                         [CCMoveBy actionWithDuration:0.25f position:ccp(0, s.contentSize.height)],
                                                         [CCMoveBy actionWithDuration:0.25f position:ccp(s.contentSize.width, 0)],
                                                         [CCMoveBy actionWithDuration:0.25f position:ccp(0, -s.contentSize.height)],
                                                         [CCMoveBy actionWithDuration:0.25f position:ccp(-s.contentSize.width, 0)], nil] ]];
    
    animationInter = 0;
    
   
    
    if ((![ss isEqualToString:k10]) && (![ss isEqualToString:kK]) && (![ss isEqualToString:kA]) && (![ss isEqualToString:kJ]) && (![ss isEqualToString:kQ])) {
    
        CCSprite *blink = [CCSprite spriteWithFile:@"blink.png"];
        blink.anchorPoint = ccp(0.5f, 0.5f);
        blink.position = ccp(0, 0);
        NSString *name = [NSString stringWithFormat:@"%@.png",[randomeElements objectAtIndex:iconNumber]];
        
        CCSprite *iconMask = [CCSprite spriteWithSpriteFrameName:name];
        iconMask.anchorPoint = ccp(0.5f, 0.5f);
        iconMask.position = ccp(0, 0);
        
        CCMaskedSprite *ms = [[[CCMaskedSprite alloc]initWithMaskFile:iconMask andSpriteFile:blink parent:self]autorelease];
        
        //[[self getChildByTag:k_FIRST_IMAGE] runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.1f],[CCScaleTo actionWithDuration:0.4 scale:1.05f],[CCScaleTo actionWithDuration:0.4f scale:1.0f],[CCDelayTime actionWithDuration:0.1f], nil]]];
        
        [self addChild:ms z:99 tag:kTagMarkedSprite];
       
    }
  
}

-(void)scaleFirstIname:(float)float__
{
    CCSprite *s = (CCSprite *)[self getChildByTag:k_FIRST_IMAGE];
    s.scale = float__;
}

- (void)loadFirstMachine
{
    
    NSString *name = [NSString stringWithFormat:@"%@.png",[randomeElements objectAtIndex:iconNumber]];
    
    CCSprite *f = [CCSprite spriteWithSpriteFrameName:name];
    
    f.anchorPoint = ccp(0.5f, 0.5f);
    
    f.opacity = 255;
    
    f.position = ccp(0, 0);
    
    [self addChild:f z:5 tag:k_FIRST_IMAGE];
}

- (void)loadSpriteSheetOfMachine
{
    [CCTexture2D setDefaultAlphaPixelFormat:kCCTexture2DPixelFormat_RGBA4444];
    spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@%i_%i.pvr.ccz",kPath_of_Animation,machineNumber,iconNumber]];
  
    [self addChild:spriteSheet z:1 tag:k_TAG_SPRITESHEET];
    [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@%i_%i.plist",kPath_of_Animation,machineNumber,iconNumber]];
}

-(void)onEnter
{
    [super onEnter];
}

-(void)onExit
{
    [self removeAllChildrenWithCleanup:YES];
    [super onExit];
}

-(void)stopAnimationByTag:(int)tag__
{
    if ([[self getChildByTag:k_FIRST_IMAGE] getActionByTag:tag__])
    {
        [[self getChildByTag:k_FIRST_IMAGE] removeFromParentAndCleanup:YES];
        [self loadFirstMachine];
    }
}

- (void)playAnimarionByTag:(int)tag__ repeat:(int)times_
{
   // if ([self getChildByTag:k_FIRST_IMAGE]) {
        //[self removeChildByTag:k_FIRST_IMAGE];
   // }
    
    if (![[self getChildByTag:k_FIRST_IMAGE] getActionByTag:tag__]) {

        id animation        =       [CCAnimation animationWithSpriteFrames:allElements delay:1.0f/60];
        
        id animate          =       [CCAnimate actionWithAnimation:animation];
        
        id repeatF          =       [CCRepeat actionWithAction:animate times:times_];
        
        //id callFunc         =       [CCCallFuncO actionWithTarget:self selector:@selector(stopAnimationByTag:) object:nil];
        
        id sequence         =       [CCSequence actions:repeatF, nil];
        
        [[self getChildByTag:k_FIRST_IMAGE] runAction:sequence].tag = tag__;
    }

}

- (void)stopAllAnimation
{
    CCSprite *s = (CCSprite *)[self getChildByTag:k_FIRST_IMAGE];
    [s stopAllActions];
    s.scale = 1.0f;

}

- (void)iconsAnimation
{
    CCSprite *s = (CCSprite *)[self getChildByTag:k_FIRST_IMAGE];
    
   // if ([s getActionByTag:kTagIconAnimation]) {
   //     return;
   // }
    
    NSString *ss = [NSString stringWithFormat:@"%@",[randomeElements objectAtIndex:iconNumber]];
    
    if (([ss isEqualToString:k10]) || ([ss isEqualToString:kK]) || ([ss isEqualToString:kA]) || ([ss isEqualToString:kJ]) || ([ss isEqualToString:kQ])) {
        
        id scaleON = [CCScaleTo actionWithDuration:0.25f scaleX:-1.0 scaleY:1.0f];
        
        id easeON = [CCEaseInOut actionWithAction:scaleON rate:1.0f];
        
        id scaleOFF = [CCScaleTo actionWithDuration:0.25f scaleX:1.0f scaleY:1.0f];
        
        id easeOFF = [CCEaseInOut actionWithAction:scaleOFF rate:1.0f];
        
        id sequence = [CCSequence actions:easeON,easeOFF,[CCDelayTime actionWithDuration:0.5f],nil];
        
        id repeat = [CCRepeatForever actionWithAction:sequence];
        
        [s runAction:repeat].tag = kTagIconAnimation;
    }
}

- (void)setColorForIcon_red:(float)red green:(float)green blue:(float)blue
{
    CCSprite *s = (CCSprite *)[self getChildByTag:k_FIRST_IMAGE];
    
    [s runAction:[CCTintTo actionWithDuration:0.1f red:red green:green blue:blue]].tag = 1;
    
}

-(void)dealloc
{
    if (allElements!=nil) {
        [allElements release];
        allElements = nil;
    }
    
    [super dealloc];

}


@end
