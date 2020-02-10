//
//  CCMaskedSprite
//
//  Created by Rene van der kooi on 3/20/12.
//  renevdkooi@gmail.com
//
// Masked Sprite based on 2 images (mask and actual)


#import "CCMaskedSprite.h"
#import "Slots_Animation.h"

@implementation CCMaskedSprite
{
    CCProgressTimer *_progress;
    float x;
}


/****************************************
 *
 * Init Method
 *
 ****************************************/
- (id)initWithMaskFile:(CCSprite*)mask andSpriteFile:(CCSprite *)file parent:(CCNode *)par_
{
	if( (self=[super init]))
    {
        par___ = par_;
        x = 0;
        //CCSprite *sprite = [CCSprite spriteWithFile:file];
        //CCSprite *maskSprite = [CCSprite spriteWithFile:mask];
        CCSprite *spriteMasked = [self maskedSpriteWithSprite:file maskSprite:mask];
        
        spriteMasked.opacity = 180;
        //spriteMasked.rotation = -45;
        
        _progress = [CCProgressTimer progressWithSprite:spriteMasked];
        _progress.type = kCCProgressTimerTypeBar;
        _progress.barChangeRate = ccp(1,0);
        _progress.midpoint = ccp(0.0,0.0f);
        _progress.percentage = 0;
        _progress.rotation = 45;
        _progress.position = ccp(0, 0);
        _progress.anchorPoint = ccp(0.5f, 0.5f);
        //_progress.opacity = 0;
        
        //[_progress runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCTintTo actionWithDuration:0.f red:255 green:186 blue:0],[CCTintTo actionWithDuration:0.3f red:255 green:255 blue:255],[CCTintTo actionWithDuration:0.3f red:255 green:186 blue:0], nil]]];
        
        
        [self addChild:_progress z:99];
        

        [self runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCCallBlock actionWithBlock:^{
            [self schedule:@selector(iocnAnimation:)];
        }],[CCDelayTime actionWithDuration:1.f], nil]]];
        
        
        
        //[self addChild:spriteMasked];
        
    }
	return self;
}

-(void)changeMidPoint{
    
    _progress.midpoint = ccp(0.f, 0.f);
    
}

-(void)iocnAnimation:(ccTime *)dt
{
    if (x >= 1.f)
    {
        x = 0;
        [self unschedule:@selector(iocnAnimation:)];
    }

    
    _progress.midpoint = ccp(x, _progress.midpoint.y);
    
    x += 0.04f;
    float scale = 0.0f;
    
    if (x > 0 && x < 0.50f)
    {
        _progress.percentage = (x*100)/2;
        
        scale = ((_progress.midpoint.x*100)*0.1f)/100;
     
    }
    else if (x > 0.50f && x < 1.f)
    {
        _progress.percentage = (100-(x*100))/2;
        scale = ((100-_progress.midpoint.x*100)*0.1f)/100;
        
    }
    else if (x >=0.50f && x <=0.50f)
    {
        _progress.percentage = 25;
        scale = ((_progress.midpoint.x*100)*0.1f)/100;
     
    }
    
    [(Slots_Animation *)par___ scaleFirstIname:1 - scale];
    //_progress.scale = (1 - (scale *2));
    
   // [_progress updateProgress];
    
   // NSLog(@"_midpoint x %f",_progress.midpoint.x);
    
    //_progress.percentage = x;

}

- (CCSprite *)maskedSpriteWithSprite:(CCSprite *)textureSprite maskSprite:(CCSprite *)maskSprite {
    
    CCRenderTexture * rt = [CCRenderTexture renderTextureWithWidth:maskSprite.contentSize.width*1.5f height:maskSprite.contentSize.height*1.5f];
    
    textureSprite.rotation = -45;
    maskSprite.rotation = -45;
    
    maskSprite.position = ccp((maskSprite.contentSize.width *1.5f)/2, (maskSprite.contentSize.height *1.5f)/2);
    textureSprite.position = ccp((maskSprite.contentSize.width *1.5f)/2, (maskSprite.contentSize.height *1.5f)/2);
    
    [maskSprite setBlendFunc:(ccBlendFunc){GL_ONE, GL_ZERO}];
    [textureSprite setBlendFunc:(ccBlendFunc){GL_DST_ALPHA, GL_ZERO}];
    
    [rt begin];
    [maskSprite visit];
    [textureSprite visit];
    [rt end];
    
    CCSprite *retval = [CCSprite spriteWithTexture:rt.sprite.texture];
    retval.flipY = YES;
    return retval;
}

@end
