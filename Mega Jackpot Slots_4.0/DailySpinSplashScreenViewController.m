//
//  DailySpinSplashScreenViewController.m
//  Fun Vegas Slots
//
//  Created by Orban Balazs on 26/02/16.
//  Copyright © 2016 bsixlux. All rights reserved.
//

#import "DailySpinSplashScreenViewController.h"
#import "AppDelegate.h"

@interface DailySpinSplashScreenViewController ()

@end

@implementation DailySpinSplashScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)spin:(id)sender {
    [self dismissViewControllerAnimated:YES completion:^{
        [[(AppController *)[[UIApplication sharedApplication] delegate] getSpecialBonus] showWheelGame];
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

@end
