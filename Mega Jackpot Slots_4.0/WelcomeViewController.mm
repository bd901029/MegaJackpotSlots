//
//  WelcomeViewController.m
//  Fun Vegas Slots
//
//  Created by Orban Balazs on 20/02/16.
//  Copyright © 2016 bsixlux. All rights reserved.
//

#import "WelcomeViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "SpecialBonus.h"
#import "cfg.h"
#import "TopMenu.h"
#import "Menu.h"
#import "Combinations.h"
#import <Chartboost/Chartboost.h>
#import "IDSTOREPLACE.h"
#import "AppDelegate.h"
#import "Welcome2ScreenViewController.h"


@interface WelcomeViewController ()

@end

@implementation WelcomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)faceLogin:(id)sender {
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
             
             [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Welcome Screen"
                                                                   action:@"Logged into Facebook"
                                                                    label:nil
                                                                    value:nil] build]];
               if ([result.grantedPermissions containsObject:@"email"]) {
             NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
             [parameters setValue:@"id,name,email" forKey:@"fields"];
             
             [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
              startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                           id result, NSError *error) {
                  NSLog(@"%@",result[@"email"]);
                  [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"Facebook"];
                  [[NSUserDefaults standardUserDefaults] synchronize];
                  [self dismissViewControllerAnimated:YES completion:^{
                      [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus]ReedemCoins:rewardForFBLogin.integerValue];
                      dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(gapBetweenFirstAndSecondWelcomeScreenInSeconds * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          Welcome2ScreenViewController* WVC2 = [[Welcome2ScreenViewController alloc] initWithNibName:@"welcome2ScreeniPhone" bundle:[NSBundle mainBundle]];
                          [((AppController*)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:WVC2 animated:YES completion:nil];
                      });
                  }];
              }];
               }
         }
     }];
}
- (IBAction)Later:(id)sender {
    id<GAITracker> tracker = [Authenticator sharedManager].Globaltracker;
    
    [tracker send:[[GAIDictionaryBuilder createEventWithCategory:@"Welcome Screen"
                                                          action:@"Clicked later"
                                                           label:nil
                                                           value:nil] build]];

    [self dismissViewControllerAnimated:YES completion:nil];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        Welcome2ScreenViewController* WVC2 = [[Welcome2ScreenViewController alloc] initWithNibName:@"welcome2ScreeniPhone" bundle:[NSBundle mainBundle]];
        if (IS_IPAD){
            WVC2 = [[Welcome2ScreenViewController alloc] initWithNibName:@"welcome2ScreeniPad" bundle:[NSBundle mainBundle]];
        }
        [((AppController*)[[UIApplication sharedApplication] delegate]).window.rootViewController presentViewController:WVC2 animated:YES completion:nil];
    });
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
