//
//  b6luxLoadingView.h
//  Zombie Joe
//
//  Created by Slavian on 2013-07-30.
//
//

#import <UIKit/UIKit.h>

@interface b6luxLoadingView : UIView <UIApplicationDelegate>
{
    
}
- (id)initWithFrame:(CGRect)frame loading:(int)loading;

-(UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;
-(void)loadingON;
@end
