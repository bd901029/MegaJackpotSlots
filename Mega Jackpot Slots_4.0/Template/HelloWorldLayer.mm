//
//  HelloWorldLayer.mm
//  Template
//
//  Created by Slavian on 2013-08-17.
//  Copyright bsixlux 2013. All rights reserved.
//

// Import the interfaces
#import "HelloWorldLayer.h"

// Not included in "cocos2d.h"
#import "CCPhysicsSprite.h"

// Needed to obtain the Navigation Controller
#import "AppDelegate.h"

#import "Constants.h"
#import "cfg.h"

#import "Menu.h"
#import "b6luxLoadingView.h"
#import "TopMenu.h"

//#define PTM_RATIO_LH [LevelHelperLoader pointsToMeterRatio]

#define kTopMMenuTAG 10

enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@interface HelloWorldLayer()
-(void) initPhysics;
-(void) addNewSpriteAtPosition:(CGPoint)p;
-(void) createMenu;
@end

@implementation HelloWorldLayer{
    
    Menu *runMenu;
    
}

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer z:0 tag:999];
	return scene;
}

-(id) init
{
	if( (self=[super init]))
    {
        UIView *view__ = [[[b6luxLoadingView alloc]initWithFrame:CGRectMake(0, 0, 0, 0) loading:kLOADING_MACHINE]autorelease];
        view__.tag = kLOADINGTAG;
        
        if (![[[CCDirector sharedDirector] openGLView]viewWithTag:kLOADINGTAG]) {
            [[[CCDirector sharedDirector] openGLView]addSubview:view__];
        }

        
        [self setTouchEnabled:YES];
        

        BG_ = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"sp_background.pvr.ccz"]];
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"sp_background.plist"]];
        [self addChild:BG_];
        
        
 
        CCSprite *background = [CCSprite spriteWithSpriteFrameName:@"background.png"];
        background.position  = ccp(kWidthScreen / 2, kHeightScreen / 2);
        [BG_ addChild:background];
        
       
        
        [self runMenu];
    }
	return self;
}



-(void)UPDATE_SPECIAL_BONUS{
    
    SpecialBonus *SB = [runMenu GET_SPECIAL_BONUS];
    
    [SB UPDATE_ME];
    
}

-(void)runMenu
{
    runMenu = [[[Menu alloc] initWithRect:CGRectMake(0, 0, kWidthScreen, kHeightScreen) type:1 level:kLEVEL] autorelease];
    
    runMenu.anchorPoint = ccp(0, 0);
    runMenu.position    = ccp(0, 0);
    [self addChild:runMenu];
    
   
    
}


//
//-(void) draw
//{
    /*
	//
	// IMPORTANT:
	// This is only for debug purposes
	// It is recommend to disable it
	//
	[super draw];
	
	ccGLEnableVertexAttribs( kCCVertexAttribFlag_Position );
	
	kmGLPushMatrix();
	
	world->DrawDebugData();	
	
	kmGLPopMatrix();
    */
//}

//-(void) addNewSpriteAtPosition:(CGPoint)p
//{
//	CCLOG(@"Add sprite %0.2f x %02.f",p.x,p.y);
//	// Define the dynamic body.
//	//Set up a 1m squared box in the physics world
//	b2BodyDef bodyDef;
//	bodyDef.type = b2_dynamicBody;
//	bodyDef.position.Set(p.x/PTM_RATIO, p.y/PTM_RATIO);
//	b2Body *body = world->CreateBody(&bodyDef);
//	
//	// Define another box shape for our dynamic body.
//	b2PolygonShape dynamicBox;
//	dynamicBox.SetAsBox(.5f, .5f);//These are mid points for our 1m box
//	
//	// Define the dynamic body fixture.
//	b2FixtureDef fixtureDef;
//	fixtureDef.shape = &dynamicBox;	
//	fixtureDef.density = 1.0f;
//	fixtureDef.friction = 0.3f;
//	body->CreateFixture(&fixtureDef);
//	
//
//	CCNode *parent = [self getChildByTag:kTagParentNode];
//	
//	//We have a 64x64 sprite sheet with 4 different 32x32 images.  The following code is
//	//just randomly picking one of the images
//	int idx = (CCRANDOM_0_1() > .5 ? 0:1);
//	int idy = (CCRANDOM_0_1() > .5 ? 0:1);
//	CCPhysicsSprite *sprite = [CCPhysicsSprite spriteWithTexture:spriteTexture_ rect:CGRectMake(32 * idx,32 * idy,32,32)];
//	[parent addChild:sprite];
//	
//	[sprite setPTMRatio:PTM_RATIO];
//	[sprite setB2Body:body];
//	[sprite setPosition: ccp( p.x, p.y)];
//
//}

//- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    
    //Add a new body/atlas sprite at the touched location
//	for( UITouch *touch in touch ) {
//		CGPoint location = [touch locationInView: [touch view]];
//        
//		location = [[CCDirector sharedDirector] convertToGL: location];
//        
//	}
    
    return YES;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    
    //Add a new body/atlas sprite at the touched location
	for( UITouch *touch in touches ) {
		CGPoint location = [touch locationInView: [touch view]];
        
		location = [[CCDirector sharedDirector] convertToGL: location];
        
        if(skeleton){
            
            location.x -= 60;//i substract this so the snake head will not be hidden by the finger when testing on device
            
            [skeleton setPosition:location forBoneNamed:@"UntitledNode_3"];
        }
	}
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    
}


- (void)accelerometer:(UIAccelerometer*)accelerometer didAccelerate:(UIAcceleration*)acceleration
{
    
}


//-(void) tick: (ccTime) dt
//{
	
//	int32 velocityIterations = 8;
//	int32 positionIterations = 1;
//	
//	world->Step(dt, velocityIterations, positionIterations);
//    
//	
//	//Iterate over the bodies in the physics world
//	for (b2Body* b = world->GetBodyList(); b; b = b->GetNext())
//	{
//		if (b->GetUserData() != NULL) {
//			//Synchronize the AtlasSprites position and rotation with the corresponding body
//			CCSprite *myActor = (CCSprite*)b->GetUserData();
//			myActor.position = CGPointMake( b->GetPosition().x * PTM_RATIO_LH, b->GetPosition().y * PTM_RATIO_LH);
//			myActor.rotation = -1 * CC_RADIANS_TO_DEGREES(b->GetAngle());
//		}
//	}
//}

-(void) onEnter
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
    [super onEnter];
}

-(void) dealloc
{
	delete world;
	world = NULL;
	
	delete m_debugDraw;
	m_debugDraw = NULL;
	
	[super dealloc];
}


@end
