//
//  b6luxLoadingView.m
//  Zombie Joe
//
//  Created by Slavian on 2013-07-30.
//
//

#import "b6luxLoadingView.h"
#import "cfg.h"
#import "Combinations.h"
#import "SConfig.h"
#import "SCombinations.h"
#import <QuartzCore/QuartzCore.h>

@implementation b6luxLoadingView

- (id)initWithFrame:(CGRect)frame loading:(int)loading
{
    self = [super initWithFrame:frame];
    if (self) {
        [[CCDirector sharedDirector] openGLView].userInteractionEnabled = NO;
        switch (loading) {
            case 1:[self imagesLoad];break;
            case 2:[self machineLoading];break;
                
            default:break;
        }
    }
    return self;
}
-(void)machineLoading
{
    CGRect rect = CGRectMake(0, 0, kWidthScreen, kHeightScreen);
    UIView *image = [[[UIImageView alloc]initWithFrame:rect]autorelease];
    image.backgroundColor = [UIColor colorWithRed:0.15686275f green:0.02745098f blue:0.08627451f alpha:1];
    image.center = ccp(kWidthScreen/2, kHeightScreen/2);
    //image.layer.opacity = 1.0f;
    [self addSubview:image];

    for (int i = 0; i<=3; i++) {
        UIImageView *imageView;
        switch (i) {
            case 0:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_element.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.5f, 0.5f);
                imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGX_2), (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGY_2));
                imageView.layer.position = ccp(kWidthScreen/2.05, kHeightScreen/2);
                //[self runSpinAnimationOnView:imageView duration:0.4f rotations:1 repeat:1e100 degree:2.0];
                break;
            case 1:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_0a.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.56f, 0.5f);
                imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGX), (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGY));
                imageView.layer.position = ccp(kWidthScreen/2, kHeightScreen/2);
                //[self runSpinAnimationOnView:imageView duration:0.4f rotations:1 repeat:1e100 degree:-2.0];
                break;
            case 2:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_1.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.5f, 1.f);
                imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGX), (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGY));
                imageView.layer.position = ccp(kWidthScreen/2, kHeightScreen/2);
                [self runSpinAnimationOnView:imageView duration:0.6f rotations:1 repeat:1e100 degree:0.5];
                break;
            case 3:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_2.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.6f, 1.f);
                imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGX), (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGY));
                imageView.layer.position = ccp(kWidthScreen/2, kHeightScreen/2);
                [self runSpinAnimationOnView:imageView duration:0.3f rotations:1 repeat:1e100 degree:2.0];
                break;
            default:break;
        }
        
        [self addSubview:imageView];
    }
    
}

-(void)imagesLoad
{
    CGRect rect;
    if (IS_IPAD) {rect = CGRectMake(0, 0, 300, 200);}else{rect = CGRectMake(0, 0, 150, 100);}
    UIView *image = [[[UIImageView alloc]initWithFrame:rect]autorelease];
    image.backgroundColor = [UIColor blackColor];
    image.center = ccp(kWidthScreen/2, kHeightScreen/2);
    image.layer.opacity = 0.9f;
    
    image.layer.cornerRadius = IS_IPAD ? 15 : 10;
    
   // image.layer.borderColor = [UIColor whiteColor].CGColor;
   //kada image.layer.borderWidth = 1.5f;
    
    [self addSubview:image];
    
    for (int i = 0; i<4; i++) {
        UIImageView *imageView;
        switch (i) {
            case 0:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_3.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.56f, 0.5f);
                //[self runSpinAnimationOnView:imageView duration:0.4f rotations:1 repeat:1e100 degree:2.0];
                break;
            case 1:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_0.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.56f, 0.5f);
                //[self runSpinAnimationOnView:imageView duration:0.4f rotations:1 repeat:1e100 degree:-2.0];
                break;
            case 2:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_1.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.5f, 1.f);
                [self runSpinAnimationOnView:imageView duration:0.6f rotations:1 repeat:1e100 degree:0.5];
                break;
            case 3:imageView = [[[UIImageView alloc]initWithImage:[UIImage imageNamed:@"loading_2.png"]] autorelease];
                imageView.layer.anchorPoint = CGPointMake(0.6f, 1.f);
                [self runSpinAnimationOnView:imageView duration:0.3f rotations:1 repeat:1e100 degree:2.0];
                break;
            default:break;
        }
        imageView.transform = CGAffineTransformScale(CGAffineTransformIdentity, (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGX), (kSCALELOADING_FACTOR_FIX)*(kSCALEVALLOADINGY));
        
        imageView.layer.position = ccp(kWidthScreen/2, kHeightScreen/2);
        [self addSubview:imageView];
    }
}

//- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
//    
//    
//    
//}
//
//- (void)animationDidStart:(CAAnimation *)theAnimation{
//    
//    
//    
//}


- (void) runSpinAnimationOnView:(UIView*)view duration:(CGFloat)duration rotations:(CGFloat)rotations repeat:(double)repeat degree:(float)degree_;
{
    CABasicAnimation* rotationAnimation;
    rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat: M_PI * degree_ /* full rotation*/ * rotations * duration ];
    rotationAnimation.duration = duration;
    rotationAnimation.cumulative = YES;
  //  rotationAnimation.delegate = self;
    rotationAnimation.repeatCount = repeat;
    
    
    [view.layer addAnimation:rotationAnimation forKey:@"rotationAnimation"];
    
//    [UIView setAnimationWillStartSelector:@selector(animationDidStart:)];
//    [UIView setAnimationDidStopSelector:@selector(animationDidStop:finished:)];
    
}

-(void)loadingON
{
}

-(void)dealloc
{
    [[CCDirector sharedDirector] openGLView].userInteractionEnabled = YES;
    
//    for (UIView *v in [[[CCDirector sharedDirector]openGLView]subviews]) {
//        NSLog(@"--[[SUBVIEW]]-- %@",v);
//    }
    [super dealloc];
}

@end
