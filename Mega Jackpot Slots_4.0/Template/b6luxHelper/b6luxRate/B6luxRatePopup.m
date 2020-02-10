//
//  B6luxRatePopup.m
//  Zombie Joe
//
//  Created by Slavian on 2013-08-05.
//
//

#import "B6luxRatePopup.h"
#import "cfg.h"

@implementation B6luxRatePopup

- (id)init{
    
    if ((self = [super init])) {
        
    }
    return self;
}

- (void)ratePopUp
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Do you like this game?" message:@"Please rate it and help Joe to improve." delegate:self cancelButtonTitle:@"No, thanks" otherButtonTitles:@"Rate now",@"Ask me later", nil];//autorelease ];
    [alert show];
    [alert release];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)//No, thanks
    {
        //[Combinations saveNSDEFAULTS_INT:-10 forKey:C_GAME_RATED];
    }
    else if (buttonIndex == 1)//Rate now
    {
        //[db SS_rategame_player:[gc_ getLocalPlayerAlias]];
        //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:iTunesLink]];
        //[Combinations saveNSDEFAULTS_INT:-10 forKey:C_GAME_RATED];
    
    }
    else if (buttonIndex == 2)//Ask me later
    {
        //[Combinations saveNSDEFAULTS_INT:0 forKey:C_GAME_RATED];
    }
    
}
-(void) dealloc
{
    
    [super dealloc];
}

@end
