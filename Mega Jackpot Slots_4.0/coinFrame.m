//
//  coinFrame.m
//  Template
//
//  Created by macbook on 2013-10-28.
//  Copyright (c) 2013 bsixlux. All rights reserved.
//

#import "coinFrame.h"
#import "cfg.h"

@implementation coinFrame{
    
    float t_;
    int h_;
    int d_;
    
}

-(void)setEndPos:(CGPoint)p_{
    
    endPos = p_;
    
}

-(void)setup_afterDelay:(float)delay_ par:(coinsFA*)p_{
    
    _par = p_;
    
    [self runAction: [CCSequence actions:
                     [CCDelayTime actionWithDuration:delay_],
                     [CCCallFunc actionWithTarget:self selector:@selector(start)], nil]];
    
}

-(void)start{
    
    ccBezierConfig bezier;
    
    float MinY_ = 0;
    float maxY_ = 350*(kSCALEVALY);
    
//    if (self.position.y > kHeightScreen*0.35f && self.position.y < kHeightScreen * 0.75) {
//        MinY_ = -50;
//        maxY_ = 100;
//    }
    
    float sWidth = _par.power * (100*(kSCALEVALY));
    
    if (sWidth > kWidthScreen/2) {
        sWidth = kWidthScreen*0.65f;
    }
    
    
    float x_ = [cfg MyRandomIntegerBetween:-sWidth :sWidth];
    float y_ = [cfg MyRandomIntegerBetween:MinY_ :maxY_];
    
    int ra_ = [cfg MyRandomIntegerBetween:0 :1];
    int ra_2 = [cfg MyRandomIntegerBetween:0 :1];
    
    bezier.controlPoint_1 = ccp((ra_) ? x_ : x_,(ra_) ? y_ : y_);
    bezier.controlPoint_2 = ccp((ra_2) ? x_ : x_,(ra_2) ? y_ : y_);
    bezier.endPosition = ccp(endPos.x-self.position.x, endPos.y-self.position.y);
    
    
    id bezierForward = [CCBezierBy actionWithDuration:0.7f bezier:bezier];
    id seq = [CCSequence actions:bezierForward,[CCCallFunc actionWithTarget:self selector:@selector(selfRemove)], nil];
    [self runAction:seq];
    
    self.visible = YES;
    
    [self scheduleUpdate];
    
    return;
    
    h_ = (float)[cfg MyRandomIntegerBetween:39 :40]/10;    //4
    d_ = (float)[cfg MyRandomIntegerBetween:20 :20]/10;    //2
    

    [self scheduleUpdate];
    
}

-(void)selfRemove{
    
    [self removeFromParentAndCleanup:YES];
    
}

-(void)update:(ccTime)dt{
    
    if (ccpDistance(self.position, _par.endPosition) < kHeightScreen*0.5f) {
        self.scale-=dt;
    }
    if (self.position.y > kHeightScreen*0.825f) {
        self.opacity-=50;
    }
    
    return;
    
    t_+=dt*d_;
    
    float height = h_;//3.f;
    // 3
    float offset = pow(height, 2.5);
    
    // 4 multiply by sin since it gives us nice bending
    offset *= (sin(t_ * 2.0) * 0.2f);
    
   // NSLog(@"offset %f",offset);
    
    float step  = dt * 2;
    
    float distance = ccpDistance(self.position, endPos);
    
    float speed = distance;
    
    CGPoint dir;
    
    if (distance > step) {
        
        step = step * speed;
        dir = ccpSub(endPos, self.position);
        dir = ccpNormalize(dir);
        //NSLog(@"shoud normalized be %f %f",dir.x,dir.y);
        //self.position = ccpAdd(self.position, ccpMult(dir, step));
        
    }
    
    self.position = ccpAdd(self.position, ccp(offset, dt*(kWidthScreen/2)));
    
    

    

    
    if (ccpDistance(self.position, endPos) < 3)
    {
        [self removeFromParentAndCleanup:YES];
    }
    
    //must check distance normalized
    
    //self.position = ccpAdd(self.position, ccpAdd(0, ))
    
    
    
}

-(void)dealloc
{
    [super dealloc];
}

-(void) onEnter
{
    [super onEnter];
}

-(void)onExit
{
    [super onExit];
}

@end
