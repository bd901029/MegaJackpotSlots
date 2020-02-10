
//  Created by Slavian on 4/25/13.


#import "SCombinations.h"
#import <SystemConfiguration/SystemConfiguration.h>


@implementation SCombinations
+(NSString*)kDevice
{
    if (IS_IPAD)return @"";return @"_iPhone";
}
+(float)spriteWidth:(CCSprite*)spriteName
{
    return spriteName.contentSize.width;
}
+(float)spriteHeight:(CCSprite*)spriteName
{
    return spriteName.contentSize.height;
}

+(void)opacityEffectToSprite:(CCSprite *)sprite_ from:(float)from_ to:(float)to_ timeDuration:(float)time_
{
    sprite_.opacity = from_;
    [sprite_ runAction:[CCFadeTo actionWithDuration:time_ opacity:to_]];
}

+(CCSprite*)spritename:(CCNode*)parent :(int)tag
{
    return (CCSprite *)[parent getChildByTag:tag];
}
+(NSInteger)MyRandomIntegerBetween:(int)min :(int)max {
    return ( (arc4random() % (max-min+1)) + min );
}
+(CCLayerColor *)boxWithColor:(ccColor4B)color pos:(CGPoint)pos size:(CGSize)size
{
    CCLayerColor *box = [CCLayerColor layerWithColor:color];
    box.anchorPoint = ccp(0, 0);
    box.position = pos;
    box.contentSize = size;
    return box;
}
@end
