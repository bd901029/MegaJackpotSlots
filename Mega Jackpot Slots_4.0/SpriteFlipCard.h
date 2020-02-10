//FlipCardExample

//Copyright 2013 Adam Jacaruso

//Licensed under the Apache License, Version 2.0 (the "License");
//you may not use this file except in compliance with the License.
//You may obtain a copy of the License at

//http://www.apache.org/licenses/LICENSE-2.0

//Unless required by applicable law or agreed to in writing, software
//distributed under the License is distributed on an "AS IS" BASIS,
//WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//See the License for the specific language governing permissions and
//limitations under the License.

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SpriteFlipCard : CCSprite {
    BOOL isOriginalFace;
    CCTexture2D *textureOne;
    CCTexture2D *textureTwo;
}

@property (nonatomic, assign) BOOL isOriginalFace;
@property (nonatomic, retain) CCTexture2D *textureOne;
@property (nonatomic, retain) CCTexture2D *textureTwo;

- (SpriteFlipCard *)initSpriteFlipCardWithImageOne:(NSString *)SideOneImage andImageTwo:(NSString *)SideTwoImage;
- (void)flipSpriteVertical:(float)duration;
- (void)flipSpriteHorizontal:(float)duration;
- (void)displayNewSide;
- (void)setIsOriginalFace:(BOOL)newOriginalFace;
- (bool)getIsOriginalFace;

@end
