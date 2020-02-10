//
//  coinFrame.h
//  Template
//
//  Created by macbook on 2013-10-28.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "cocos2d.h"
#import "coinsFA.h"

@interface coinFrame : CCSprite{
 
    CGPoint endPos;
    coinsFA *_par;
    
}



-(void)setEndPos:(CGPoint)p_;

-(void)setup_afterDelay:(float)delay_ par:(coinsFA*)p_;

@end
