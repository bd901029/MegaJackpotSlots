
//  Created by Slavian on 4/25/13.


#import <Foundation/Foundation.h>
#import "Constants.h"
#import "cocos2d.h"

@interface SCombinations : NSObject
+(NSString*)kDevice;
+(float)spriteWidth:(CCSprite*)spriteName;
+(float)spriteHeight:(CCSprite*)spriteName;
+(void)opacityEffectToSprite:(CCSprite *)sprite_ from:(float)from_ to:(float)to_ timeDuration:(float)time_
;
+(CCSprite*)spritename:(CCNode*)parent :(int)tag;
+(NSInteger)MyRandomIntegerBetween:(int)min :(int)max;
+(CCLayerColor *)boxWithColor:(ccColor4B)color pos:(CGPoint)pos size:(CGSize)size;
@end
