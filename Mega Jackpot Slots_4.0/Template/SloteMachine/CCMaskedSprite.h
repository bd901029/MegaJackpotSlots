//
//  CCMaskedSprite
//
//  Created by Rene van der kooi on 3/20/12.
//  renevdkooi@gmail.com
//
// Masked Sprite based on 2 images (mask and actual)

#import "cocos2d.h"

@interface CCMaskedSprite : CCSprite
{
    CCNode *par___;
}

- (id)initWithMaskFile:(CCSprite*)mask andSpriteFile:(CCSprite *)file parent:(CCNode *)par_;

@end