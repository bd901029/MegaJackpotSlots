//
//  IDSTOREPLACE.h
//
//
//  Created by Outlandish Apps on 5/15/2015.
//  Copyright (c) 2016 Outlandish Apps LLC. All rights reserved.
//
#import "GAIDictionaryBuilder.h"
#import "GAI.h"
#import <Licenses/Licenses.h>
//Replace with your license key as this one will expire in 24 hours
// ---->
//If you did not copy your license key and save off the thank you page, please send me an email with your name and purchase date and I will send it to you.
#define NAME @"Todd Smith"

#define LICENSE @"ucH4H5maGxpdXl7vX1tW5BRiR6DYwxH4cojSnKvk"

#define chartBoostAppID @"56f344d2346b5226a82da46d"

#define chartBoostAppSignature @"0eb45397ef923df88ddd6b95b24498879ac5ce4f"

#define GoogleAnalyticsTrackingID @"UA-89147246-3"

//Facebook Notifiations enabled
#define FBNotifEnabled @NO


//APPLOVIN
//Turn off Applovin Ads by writing NO
#define ApplovinAddAtGameOverandMenu @NO


//Amout of spins durring gameplay before an ad shows
#define spinsToAdApplovin @10



//Chartboost
//Turn off Chartboost Ads by writing NO
#define ChartboostAddAtGameOverandMenu @NO

//Amout of spins durring gameplay before an ad shows
#define spinsToAdChartboost @10

//---

//Measure in seconds when the app first launches between the first and second welcome screen
//Welcome Screen #1 asks them to connect to Facebook. You can edit the amount below: #define rewardForFBLogin @1000
//Welcome Screen #2 gives them free bonus couns. You edit this amount below: #define rewardForFirstLaunch @5000
#define gapBetweenFirstAndSecondWelcomeScreenInSeconds 2.5


//Welcome Screen 1
//Amount of the user receives for logging in to facebook
#define rewardForFBLogin @10000

//Welcome Screen 2
//Amount of coins the user receives as there welcome bonus
#define rewardForFirstLaunch @5000



//Controls MINUTES between bottom bonus coins
#define minutesBetweenAds @240


//This is the bonus at the bottom they get every ___ minutes (see above)
#define FreeRewardBaseAmount @700


//Defines how much extra coins the users get's over the base amount. Multiplied by the user level.
//For example, on level one the user would receive 1000 coins (700 + 300) every 4 hours (240 min) or what ever you have the minutesBetweenAds

#define FreeRewardBonusAmountLVL @300


//Find these share options when you are in the main lobby and click on free coins button located on the bottom right. You must be logged into Facebook and Twitter to complete some of these options as a user




//IF you change this amount you must change the image: InviteFB_iphone
//Amount of coins you receive for inviting a Facebook Friend
#define rewardForFBInvite @1000


//IF you change this amount you must change the image: shareonfbbutton_iphone
//Amount of coins you receive for sharing the app on Facebook
#define rewardForFBShare @1000


//IF you change this amount you must change the image: shareontwitterbutton_iphone
//Amount of coins you receive for tweeting on Twitter about this app
#define rewardForTweet @1000


//IF you change this amount you must change the image: emailafriendforcounsbutton_iphone
//Amount of coins you receive for emailing someone about this app
#define rewardForEmail @1000


//IF you change this amount you must change the image: Watchavideoforcoinsbutton_iphone
//Amount of coins you receive for watching a Chartboost video ad
#define rewardForVideo @2500

//This is the message the appears after the time has run out on the bottom bonus coins
#define localNotificationText @"Your Free coins are ready to claim :)  You get them every 4 hours! Come play for free"

//Used with facebook invite
//This needs to be a link you generate on the facebook developers website. See tutorial: Facebook Setup / Step #19
//Make sure you already have your app setup on facebook. To do this go to: Facebook Setup #1 and go through all the steps.
#define AppLinkAppStore @"https://fb.me/959644667456167"

//FB Share information
//This link will be shared on FB
#define FBShareLink @"https://itunes.apple.com/us/app/mega-jackpot-slots/id1093283685?ls=1&mt=8"
#define FBShareText @"Want to play an awesome slots game?? Play Mega Jackpot Slots!"

//Twitter Share information:
//This link will apear in the tweet/ IT's a good idea to take your app link and put it into a link shortener for this link
#define twitterShareLink @"http://apple.co/1pznBs1"
#define TwitterShareText @"Looking for some fun? Try out Mega Jackpot Slots!"

//Email Share Information:
//This will be the details of the email
#define emailSubject @"Check out this new slots game!"
#define emailBody @"I'm playing Mega Jackpot Slots and it's paying out like crazy! Check it out: https://itunes.apple.com/us/app/mega-jackpot-slots/id1093283685?ls=1&mt=8"

//Email Support
#define FeedBackEmail @"outlandishappsllc@gmail.com"
#define FeedbackSubject @"Mega Jackpot Slots V1.0 Feedback"
#define FeedbackBody @"Your comments:"

//DailySpins info
//This is the daily notification that comes up and reminds you to come play the game.  The hour value is based on a 24 hour clock.
#define SpinNotificationText @"Come spin the bonus reel to get your free daily coins"
#define SpinNotificationHour @12
#define SpinNotificationMinute @15
#define DailySpinBaseAmount @100   //This amount will be multiplied, for each possible outcome


//1 = the arrow will appear, so the next page of slots will appear. 0 = it wont.
#define NextPageOfSlotsShouldAppear 0


//Control the level you need to reach to unlock each theme.
//Lucky Cowboy is Slot number 0 and is default set at 0 / This allows you to play right away. You have to play to unlock.

//mega food
#define LevelRequirementForSlotNumber1 3

//fishers luck
#define LevelRequirementForSlotNumber2 4

//Secret Chest
#define LevelRequirementForSlotNumber3 5

//muscle riches
#define LevelRequirementForSlotNumber4 6

//Happy Farm
#define LevelRequirementForSlotNumber5 7



//Win control

//Increase this to increase the chance of winning (0 = totally random. Increase it to get a higher chance.) No maximum. If you increase it by 1, the winning chance will go up around 8-10%. There is no maximum, so no 100%, but you can get around 95% when set to 100+. It's around 50% of win chance at 6-8
// 0 is base
//MJS 1.0
//#define ChanceOfWinning 0

#define ChanceOfWinning 9

//1 is base, 2 is double. etc...

//MJS 1.0
//#define WinningAmountMultiplyBy 1
#define WinningAmountMultiplyBy 1.0


//You can change this to adjust the xp required between levels. Default is 1.4f. (Please keep the format X.Yf) If you set it to 2.8, all required xps will be multiplied
#define RequiredXPMultiplier 1.4f

//Bigwin threshold is based on the total bet. The total bet will be multiplied by this number and that will be the threshold. Example: If we use the default value: 4.0 and the total bet is 45, every win above 4*45=180 will be a bigwin and the bigwin window will appear.
#define BigWinMultiplier 4.0f


//Increase this to decreese the amount the player gets for winning. It depends on the bet, however, you can decrese the whole win by increasing this number. Scale: 0.1-9.9. Use 0 for default. PLEASE DON'T SET 10 or higher, because that'll result in a negative or zero amount. 1 will reduce the reward by 10%, while 9.9 will reduce it by 99%. If you set lower than 1, but higher than 0, you'll incrase the reward.
//MJS 1.0
#define WinningAmountDividedBy 0




////////////// AD PLACEMENTS //////////////////

///Game launch placement


#define ShowThisPlacement1 @NO
// Actually, my algorithm for placement 2 became so good, so we'll use it here also :D. I'll give you even more option. Please check the notes for placement 2. Example @[@5] means it'll show ad at every 5th launch. But you can configure more complex workings here, check the commentary at placement 2. @[@1] means an ad will show at every launch
#define LaunchesToAd @[@1]

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON1 @YES
#define ApplovinON1 @YES
#define secondsbeforeFirstAd1 @2
#define secondsbeforeSecondAd1 @3

#define showChartboostFirst1 @YES
#define showApplovinFirst1 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement1 @{@"BackupAD" : ChartboostON1, @"show" : ShowThisPlacement1,@"BackupAD2" :ApplovinON1, @"sec1" : secondsbeforeFirstAd1, @"sec2" : secondsbeforeSecondAd1, @"ChartboostPriority" : showChartboostFirst1, @"ApplovinPriority" : showApplovinFirst1 }

///////////

///Game to lobby placements

#define ShowThisPlacement10 @YES

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON10 @YES
#define ApplovinON10 @YES
#define secondsbeforeFirstAd10 @2
#define secondsbeforeSecondAd10 @3

#define showChartboostFirst10 @YES
#define showApplovinFirst10 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement10 @{@"BackupAD" : ChartboostON10, @"show" : ShowThisPlacement10,@"BackupAD2" :ApplovinON10, @"sec1" : secondsbeforeFirstAd10, @"sec2" : secondsbeforeSecondAd10, @"ChartboostPriority" : showChartboostFirst10, @"ApplovinPriority" : showApplovinFirst10 }





///Spin placement

#define ShowThisPlacement2 @YES

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON2 @YES
#define ApplovinON2 @YES
#define secondsbeforeFirstAd2 @2
#define secondsbeforeSecondAd2 @3

#define showChartboostFirst2 @YES
#define showApplovinFirst2 @NO

/*This needs a little explanation: We'll define a Sequence here. If its @{@5}, than it will show ad, at every 5th spin.
 However, if its like 5,7,15, it will show an ad, at 5th, 7th and 15th spin, than it starts over.
 I hope this is clear, so this a "multi function" object :). I've wrote a quite cool algorithm to manage it :D. Please change the numbers and keep the syntax. You can add any number inside the @[], but please use '@' before the number and seperate them with commas. Like @[@1,@9,@53,@422]
 PS: @[@1] means, it will show every time
 */
#define spinsToShowAD @[@5,@7,@15]

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement2 @{@"BackupAD" : ChartboostON2, @"show" : ShowThisPlacement2,@"BackupAD2" :ApplovinON2, @"sec1" : secondsbeforeFirstAd2, @"sec2" : secondsbeforeSecondAd2, @"ChartboostPriority" : showChartboostFirst2, @"ApplovinPriority" : showApplovinFirst2 }


///To Settings From Menu

#define ShowThisPlacement3 @YES

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON3 @YES
#define ApplovinON3 @YES
#define secondsbeforeFirstAd3 @2
#define secondsbeforeSecondAd3 @3

#define showChartboostFirst3 @YES
#define showApplovinFirst3 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement3 @{@"BackupAD" : ChartboostON3, @"show" : ShowThisPlacement3,@"BackupAD2" :ApplovinON3, @"sec1" : secondsbeforeFirstAd3, @"sec2" : secondsbeforeSecondAd3, @"ChartboostPriority" : showChartboostFirst3, @"ApplovinPriority" : showApplovinFirst3 }




///From Settings To Menu

#define ShowThisPlacement4 @NO

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON4 @YES
#define ApplovinON4 @YES
#define secondsbeforeFirstAd4 @2
#define secondsbeforeSecondAd4 @3

#define showChartboostFirst4 @YES
#define showApplovinFirst4 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement4 @{@"BackupAD" : ChartboostON4, @"show" : ShowThisPlacement4,@"BackupAD2" :ApplovinON4, @"sec1" : secondsbeforeFirstAd4, @"sec2" : secondsbeforeSecondAd4, @"ChartboostPriority" : showChartboostFirst4, @"ApplovinPriority" : showApplovinFirst4 }




///To Settings From Game

#define ShowThisPlacement5 @YES

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON5 @YES
#define ApplovinON5 @YES
#define secondsbeforeFirstAd5 @2
#define secondsbeforeSecondAd5 @3

#define showChartboostFirst5 @YES
#define showApplovinFirst5 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement5 @{@"BackupAD" : ChartboostON5, @"show" : ShowThisPlacement5,@"BackupAD2" :ApplovinON5, @"sec1" : secondsbeforeFirstAd5, @"sec2" : secondsbeforeSecondAd5, @"ChartboostPriority" : showChartboostFirst5, @"ApplovinPriority" : showApplovinFirst5 }





///From Settings To Game

#define ShowThisPlacement6 @NO

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON6 @YES
#define ApplovinON6 @YES
#define secondsbeforeFirstAd6 @2
#define secondsbeforeSecondAd6 @3

#define showChartboostFirst6 @YES
#define showApplovinFirst6 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement6 @{@"BackupAD" : ChartboostON6, @"show" : ShowThisPlacement6,@"BackupAD2" :ApplovinON6, @"sec1" : secondsbeforeFirstAd6, @"sec2" : secondsbeforeSecondAd6, @"ChartboostPriority" : showChartboostFirst6, @"ApplovinPriority" : showApplovinFirst6 }




///Game to Paytables

#define ShowThisPlacement7 @NO

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON7 @YES
#define ApplovinON7 @YES
#define secondsbeforeFirstAd7 @2
#define secondsbeforeSecondAd7 @3

#define showChartboostFirst7 @YES
#define showApplovinFirst7 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement7 @{@"BackupAD" : ChartboostON7, @"show" : ShowThisPlacement7,@"BackupAD2" :ApplovinON7, @"sec1" : secondsbeforeFirstAd7, @"sec2" : secondsbeforeSecondAd7, @"ChartboostPriority" : showChartboostFirst7, @"ApplovinPriority" : showApplovinFirst7 }


///From Paytables to Game

#define ShowThisPlacement8 @NO

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON8 @YES
#define ApplovinON8 @YES
#define secondsbeforeFirstAd8 @2
#define secondsbeforeSecondAd8 @3

#define showChartboostFirst8 @YES
#define showApplovinFirst8 @NO

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement8 @{@"BackupAD" : ChartboostON8, @"show" : ShowThisPlacement8,@"BackupAD2" :ApplovinON8, @"sec1" : secondsbeforeFirstAd8, @"sec2" : secondsbeforeSecondAd8, @"ChartboostPriority" : showChartboostFirst8, @"ApplovinPriority" : showApplovinFirst8 }


///Level completed

#define ShowThisPlacement9 @YES

//Note: IF first is turned off, than the second won't show also. In order to show the second, the first must be turned on.
#define ChartboostON9 @YES
#define ApplovinON9 @YES
#define secondsbeforeFirstAd9 @2
#define secondsbeforeSecondAd9 @3

#define showChartboostFirst9 @YES
#define showApplovinFirst9 @NO

/* I reused again my little algprithm :D. Of course modyfing it a little bit. I think this is the easiest solution. You can simply add levels and remove them. :)
 */
#define ShowAdAtLevels @[@2,@3,@5,@7,@8,@10,@12,@14,@20,@22,@23,@24]

//Please don't edit this, this is just so I can make universal code for the placements
#define infoForPlacement9 @{@"BackupAD" : ChartboostON9, @"show" : ShowThisPlacement9,@"BackupAD2" :ApplovinON9, @"sec1" : secondsbeforeFirstAd9, @"sec2" : secondsbeforeSecondAd9, @"ChartboostPriority" : showChartboostFirst9, @"ApplovinPriority" : showApplovinFirst9 }








