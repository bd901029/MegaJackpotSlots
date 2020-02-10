#import <Foundation/Foundation.h>
#import "cocos2d.h"


@interface BigWin : CCSprite <CCTouchOneByOneDelegate>
{
    float award_;
    float counter;

}
-(void)setUpWithAward:(float)award;
@end
