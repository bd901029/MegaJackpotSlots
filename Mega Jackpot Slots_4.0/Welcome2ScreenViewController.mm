//
//  Welcome2ScreenViewController.m
//  Fun Vegas Slots
//
//  Created by Orban Balazs on 20/02/16.
//  Copyright © 2016 bsixlux. All rights reserved.
//

#import "Welcome2ScreenViewController.h"
#import "SpecialBonus.h"
#import "cfg.h"
#import "TopMenu.h"
#import "Menu.h"
#import "Combinations.h"
#import <Chartboost/Chartboost.h>
#import "IDSTOREPLACE.h"
#import "AppDelegate.h"
#import "Welcome2ScreenViewController.h"

@interface Welcome2ScreenViewController ()
@property (retain, nonatomic) IBOutlet UILabel *coinsAmount;

@end

@implementation Welcome2ScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.coinsAmount.text = [NSString stringWithFormat:@"%i",rewardForFirstLaunch.integerValue];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)Play:(id)sender {
    [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForFirstLaunch.integerValue];
    [self dismissViewControllerAnimated:YES completion:^{
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"overFirstStart"];
            [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"LaunchToInHouse"]+1 forKey:@"LaunchToInHouse"];
            [[NSUserDefaults standardUserDefaults] synchronize];
            
            if ([[NSUserDefaults standardUserDefaults] integerForKey:@"LaunchToInHouse"] > ((NSNumber*)[LaunchesToAd lastObject]).integerValue) {
                [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"LaunchToInHouse"];
            }
            //NSLog(@"Act Spins: %i. Spins needed to show ad:%i",[[NSUserDefaults standardUserDefaults] integerForKey:@"spinToAdd"],spinsToAd.integerValue);
            NSLog(@"********* Actual Launches: %li....", (long)[[NSUserDefaults standardUserDefaults] integerForKey:@"LaunchToInHouse"]);
            if ([LaunchesToAd containsObject:[NSNumber numberWithInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"LaunchToInHouse"]]]) {
                
                [[NSUserDefaults standardUserDefaults] setInteger:[[NSUserDefaults standardUserDefaults] integerForKey:@"showedAdsInCycleLaunch"]+1 forKey:@"showedAdsInCycleLaunch"];
                [[NSUserDefaults standardUserDefaults] synchronize];
                if ([[NSUserDefaults standardUserDefaults] integerForKey:@"showedAdsInCycleLaunch"] >= LaunchesToAd.count) {
                    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"LaunchToInHouse"];
                    [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"showedAdsInCycleLaunch"];
                }
                
                [((AppController*)[[UIApplication sharedApplication] delegate]) showInHouseAdWithID:1];
                
                
            }
        });
    }];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)dealloc {
    [_coinsAmount release];
    [super dealloc];
}
@end
