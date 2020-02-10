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

#import "SpriteFlipCard.h"


@implementation SpriteFlipCard
@synthesize isOriginalFace, textureOne, textureTwo;

//Creating the sprite and setting the two images that are on each side of the card
- (SpriteFlipCard *)initSpriteFlipCardWithImageOne:(NSString *)SideOneImage andImageTwo:(NSString *)SideTwoImage{
    
    isOriginalFace = TRUE;
    textureOne = [[CCTextureCache sharedTextureCache] addImage:SideOneImage];
    textureTwo = [[CCTextureCache sharedTextureCache] addImage:SideTwoImage];
    
    self = [super initWithFile:SideOneImage rect:CGRectMake(0, 0, textureOne.contentSize.width, textureOne.contentSize.height)];
    
    return self;
}

//Sets the Vertical animation for the card flip. Breaks the animation into two parts so the image can be swaped during the transition.
- (void)flipSpriteVertical:(float)duration{
    CCOrbitCamera *Vertical1 = [CCOrbitCamera actionWithDuration:duration/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:90 deltaAngleX:0];
    CCOrbitCamera *Vertical2 = [CCOrbitCamera actionWithDuration:duration/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:90 deltaAngleX:0];
    [self runAction:[CCSequence actions: Vertical1, [CCCallFunc actionWithTarget:self selector:@selector(displayNewSide)], Vertical2, nil]];
}

//Sets the Horizontal animation for the card flip. Breaks the animation into two parts so the image can be swaped during the transition.
- (void)flipSpriteHorizontal:(float)duration{
    CCOrbitCamera *Horizontal1 = [CCOrbitCamera actionWithDuration:duration/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
    CCOrbitCamera *Horizontal2 = [CCOrbitCamera actionWithDuration:duration/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
    [self runAction:[CCSequence actions: Horizontal1, [CCCallFunc actionWithTarget:self selector:@selector(displayNewSide)], Horizontal2, nil]];
}

//Based on which image is current showing, change to the other image and set the face value.
- (void)displayNewSide{
    if([self getIsOriginalFace]){
        [self setTexture:textureTwo];
        [self setIsOriginalFace:FALSE];
    }else{
        [self setTexture:textureOne];
        [self setIsOriginalFace:TRUE];
    }
}

- (void)setIsOriginalFace:(BOOL)newOriginalFace{
    isOriginalFace = newOriginalFace;
}

- (bool)getIsOriginalFace{
    return isOriginalFace;
}

@end
