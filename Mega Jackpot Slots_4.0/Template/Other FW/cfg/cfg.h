#import <Foundation/Foundation.h>
#import "Constants.h"
#import "Combinations.h"
#import "AppDelegate.h"
#import "Singelton.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "B6luxIAPHelper.h"
#import "SimpleAudioEngine.h"
#import "B6luxGameKitHelper.h"
#import "DB.h"
#import "Exp.h"
#import "SoundManager.h"
#import "SimpleAudioEngine.h"

#define delegater        (AppDelegate *)[[UIApplication sharedApplication] delegate]

#define kWidthScreen    (ScreenSize.width)                  //*(RETINA_FIX))   //[Combinations give_me_screen_width]
#define kHeightScreen   (ScreenSize.height)                 //*(RETINA_FIX))  //[Combinations give_me_screen_height]

#define kSCALEVAL_IPHONE (IS_IPHONE_5) ? 0.625f : 0.46875f
#define kSCALEVALY (IS_IPAD) ? 1.f : 0.46875f
#define kSCALEVALX (IS_IPAD) ? 1.f : kSCALEVAL_IPHONE
#define kSCALE_FACTOR_FIX ([Combinations isRetina]) ? 1.f : 0.5f


#define kSCALEVALLOADINGY (IS_IPAD) ? 0.8f : 0.46875f
#define kSCALEVALLOADINGX (IS_IPAD) ? 0.8f : 0.46875f

#define kSCALEVALLOADINGX_2 (IS_IPAD) ? 1.f : 0.46875f
#define kSCALEVALLOADINGY_2 (IS_IPAD) ? 1.f : 0.46875f

#define kSCALELOADING_FACTOR_FIX ([Combinations isRetina]) ? 0.5f : 0.5f

#define kWindowSettings             1
#define kWindowPayTable             2
#define kWindowBuyCoins             3
#define kWindowBigWin               4
#define kWindowNewMachine           5
#define kWindowSpecialBonus         6
#define kWindowNotEnoughCoins       7
#define kWindowBuyBoosts            8
#define kWindowWin                  9
#define kWindowNewLevel            10

#define kLOADINGTAG         5551

#define kWinWindowTAG        99
#define kSetWindowTAG       100
#define kPayWindowTAG       101
#define kBuyWindowTAG       102
#define kBigWindowTAG       103
#define kNewWindowTAG       104
#define kSpeWindowTAG       105
#define kNotWindowTAG       106
#define kBooWindowTAG       107
#define kBoUWindowTAG       108
#define kBlackBackgroundTAG 109
#define kFreeCoinsWindowTag 951

#define kBottomMenuTAG      110
#define kTopMenuTAG         111


#define kBlackSreen_TAG     112


#define kLine_TAG           113

#define kCard_TAG           114
#define kCard_TAG2          115
#define kCNumber_TAG        1000



#define kWheelGameTAG       10001
#define kCardGameTAG        10002


#define kProgress1          1
#define kProgress2          2
#define kProgress3          3
#define kProgress4          4
#define kProgress5          5

//PRIORYTIES

#define kTOUCH_PRIORITY_Menu             0
#define kTOUCH_PRIORITY_Buttons         -10
#define kTOUCH_PRIORITY_PopUp           -20
#define kTOUCH_PRIORITY_MiniGames       -15
#define kTOUCH_PRIORITY_SloteMachine    -4
#define kTOUCH_PRIORITY_Reels           -5

#define SOUND_          [SoundManager sharedManager]
#define AUDIO [SimpleAudioEngine sharedEngine]

#define GC_LEADERBOARD @"LeaderBoardMega_Jackpot_Slots"

#define GC_ [B6luxGameKitHelper sharedB6luxGameKitHelper]



#define kCardGame_  @"CardGame"
#define kWheelGame_ @"WheelGame"
/// FONT ATLAS ///////////////////////////////////////////////

#define kFONT_SMALL         @"16.fnt"

#define kFONT_SMALL2        @"18.fnt"

#define kFONT_BIG_WIN       @"24.fnt"
#define kFONT_MEDIUM        @"32.fnt"
#define kFONT_BIG           @"64.fnt"
#define kFONT_BIG_55        @"55_S.fnt"
#define kFONT_VERY_BIG      @"128.fnt"
#define kFONT_LARGE         @"196.fnt"

#define kFONT_SMALL_str         @"16_S.fnt"

#define kFONT_SMALL2_str        @"18_S.fnt"

#define kFONT_BIG_WIN_str       @"24_S.fnt"
#define kFONT_MEDIUM_str        @"32_S.fnt"
#define kFONT_BIG_str           @"64_S.fnt"
#define kFONT_VERY_BIG_str      @"128_S.fnt"
#define kFONT_LARGE_str         @"196_S.fnt"


#define kFONT_FREESPIN__    ([Combinations isRetina]) ? kFONT_LARGE : kFONT_VERY_BIG

#define kFONT_MENU_PAD      ([Combinations isRetina]) ? kFONT_MEDIUM : kFONT_SMALL
#define kFONT_MENU          (IS_IPAD) ? kFONT_MENU_PAD  : kFONT_SMALL2
#define kFONT_CB_BUTTONS    (IS_IPAD) ? kFONT_BIG       : kFONT_MEDIUM

//#define kFONT_WHEEL         (IS_IPAD) ? kFONT_VERY_BIG  : kFONT_BIG

#define kFONT_kFONT_WHEEL_IPAD      ([Combinations isRetina]) ? kFONT_BIG    : kFONT_MEDIUM
#define kFONT_kFONT_WHEEL_IPHONE    ([Combinations isRetina]) ? kFONT_MEDIUM : kFONT_SMALL
#define kFONT_WHEEL                 (IS_IPAD) ? kFONT_kFONT_WHEEL_IPAD : kFONT_kFONT_WHEEL_IPHONE

#define kFONT_kFONT_WHEEL_IPAD2      ([Combinations isRetina]) ? kFONT_VERY_BIG : kFONT_BIG
#define kFONT_kFONT_WHEEL_IPHONE2    ([Combinations isRetina]) ? kFONT_BIG      : kFONT_MEDIUM
#define kFONT_WHEEL2                 (IS_IPAD) ? kFONT_kFONT_WHEEL_IPAD2 : kFONT_kFONT_WHEEL_IPHONE2
#define kFONT_BIGWIN        (IS_IPAD) ? ([Combinations isRetina]) ? kFONT_BIG : kFONT_BIG_55 : kFONT_BUY_IPHONE

#define kFONT_BUY_IPAD      ([Combinations isRetina]) ? kFONT_BIG    : kFONT_MEDIUM
#define kFONT_BUY_IPHONE    ([Combinations isRetina]) ? kFONT_MEDIUM : kFONT_SMALL
#define kFONT_BUY_TXT       (IS_IPAD) ? kFONT_BUY_IPAD : kFONT_BUY_IPHONE
#define kFONT_SETT          ([Combinations isRetina]) ? kFONT_MEDIUM : kFONT_SMALL
#define kFONT_SETTINGS      (IS_IPAD) ? kFONT_SETT    : kFONT_SMALL


////////////////////////////////////////////////////////////////////////////////////////
#define kFONT_FREE_SPIN_ipad      ([Combinations isRetina]) ? kFONT_VERY_BIG : kFONT_BIG
#define kFONT_FREE_SPIN_iphone    ([Combinations isRetina]) ? kFONT_BIG      : kFONT_MEDIUM
#define kFONT_FREE_SPIN           (IS_IPAD) ? kFONT_FREE_SPIN_ipad : kFONT_FREE_SPIN_iphone
////////////////////////////////////////////////////////////////////////////////////////


#define kFREESPIN_FNT       ([Combinations isRetina]) ?  kFONT_VERY_BIG   : kFONT_BIG
#define kFONT_IP            ([Combinations isRetina]) ? kFONT_BIG : kFONT_MEDIUM
#define kFONT_SETTINGS2     (IS_IPAD) ? kFONT_IP      : kFONT_MEDIUM
#define kCARD_IPHONE        ([Combinations isRetina]) ? kFONT_BIG : kFONT_MEDIUM
#define kCARD_IPAD          ([Combinations isRetina]) ? kFONT_VERY_BIG : kFONT_BIG
#define kFONT_CARD          (IS_IPAD) ? kCARD_IPAD    : kCARD_IPHONE

#define kSPEC_IPHONE        ([Combinations isRetina]) ? kFONT_MEDIUM : kFONT_SMALL
#define kSPEC_IPAD          ([Combinations isRetina]) ? kFONT_BIG : kFONT_MEDIUM
#define kFONT_SPEC          (IS_IPAD) ? kSPEC_IPAD    : kSPEC_IPHONE

#define kCARDG_IPHONE       ([Combinations isRetina]) ? kFONT_MEDIUM : kFONT_SMALL
#define kCARDG_IPAD         ([Combinations isRetina]) ? kFONT_BIG : kFONT_MEDIUM
#define kFONT_CARDSROCES    (IS_IPAD) ? kSPEC_IPAD    : kSPEC_IPHONE
//////////////////////////////////////////////////////////////
#define kFONT_NEWLVL1       ([Combinations isRetina]) ? kFONT_VERY_BIG  : kFONT_BIG
#define kFONT_NEWLVL2       ([Combinations isRetina]) ? kFONT_BIG       : kFONT_SMALL
#define kFONT_NLEVEL        (IS_IPAD) ? kFONT_NEWLVL1 : kFONT_NEWLVL2

#define kFONT_WIN1       ([Combinations isRetina]) ? kFONT_LARGE     : kFONT_BIG
#define kFONT_WIN2       ([Combinations isRetina]) ? kFONT_BIG       : kFONT_MEDIUM
#define kFONT_WIN        (IS_IPAD) ? kFONT_WIN1 : kFONT_WIN2
//////////////////////////////////////////////////////////////

#define kFONT_BUY_BOOST_LARGE  (IS_IPAD) ? 44 : 44*0.46875f
#define kFONT_BUY_BOOST_MEDIUM (IS_IPAD) ? 22 : 22*0.46875f

#define kFONT_BUY_BOOST_PRICES (IS_IPAD) ? 52 : 52*0.46875f

//#define fntPadLARGE   ([Combinations isRetina]) ? @"startlight_font72.fnt" : @"startlight_font32.fnt"
//#define fntPhoneLARGE ([Combinations isRetina]) ? @"startlight_font32.fnt" : @"startlight_font16.fnt"
//
//#define fntSUPERPadLARGE   (kSCALE_FACTOR_FIX) ? @"256.fnt" : @"128.fnt"
//#define fntPhoneSUPERLARGE (kSCALE_FACTOR_FIX) ? @"128.fnt" : @"48.fnt"
//
//#define kFONT_LARGE (IS_IPAD) ? fntPadLARGE : fntPhoneLARGE
//
//#define kFONT_SUPER_LARGEIPAD  ([Combinations isRetina]) ?   fntSUPERPadLARGE :  @"128.fnt"
//#define kFONT_SUPER_LARGE (IS_IPAD) ? kFONT_SUPER_LARGEIPAD : fntPhoneSUPERLARGE

#define kLOADING_PURCHASE   1
#define kLOADING_MACHINE    2

#define kPath_of_Animation @""

#define kA      @"A"
#define kK      @"K"
#define kQ      @"Q"
#define kJ      @"J"
#define k10     @"10"
#define kICON1  @"ICON1"
#define kICON2  @"ICON2"
#define kICON3  @"ICON3"
#define kICON4  @"ICON4"
#define kWILD   @"WILD"
#define kSCATER @"SCATER"
#define kBONUS @"BONUS"

#define DB_ [DB access]
#define d_DB_Table  @"PlayerData"
#define d_Coins     @"Coins"
#define d_Level     @"Level"
#define d_Exp       @"Exp"
#define d_Boost2x   @"Boost2x"
#define d_Boost3x   @"Boost3x"
#define d_Boost4x   @"Boost4x"
#define d_Boost5x   @"Boost5x"
#define d_LastWin   @"LastWin"
#define d_WinAllTime   @"WinAllTime"
#define d_LoseAllTime  @"LoseAllTime"

#define k_First_Cash 5000
#define k_First_2xBoost 5
#define k_First_3xBoost 5
#define k_First_4xBoost 5
#define k_First_5xBoost 5


/// PURCHASE INDETIFIERS ///
#define kIAP_I_COINS_1_99   @"coins_1_99_MEGA"
#define kIAP_I_COINS_4_99   @"coins_4_99_MEGA"
#define kIAP_I_COINS_9_99   @"coins_9_99_MEGA"
#define kIAP_I_COINS_19_99  @"coins_19_99_MEGA"
#define kIAP_I_COINS_49_99  @"coins_49_99_MEGA"
#define kIAP_I_COINS_99_99  @"coins_99_99_MEGA"

#define kIAP_I_BOOST2X_1_99   @"boost2x_1_99_MEGA"
#define kIAP_I_BOOST2X_2_99   @"boost2x_2_99_MEGA"
#define kIAP_I_BOOST2X_3_99   @"boost2x_3_99_MEGA"
#define kIAP_I_BOOST2X_4_99   @"boost2x_4_99_MEGA"

#define kIAP_I_BOOST3X_2_99   @"boost3x_2_99_MEGA"
#define kIAP_I_BOOST3X_4_99   @"boost3x_4_99_MEGA"
#define kIAP_I_BOOST3X_6_99   @"boost3x_6_99_MEGA"
#define kIAP_I_BOOST3X_8_99   @"boost3x_8_99_MEGA"

#define kIAP_I_BOOST4X_6_99     @"boost4x_6_99_MEGA"
#define kIAP_I_BOOST4X_8_99     @"boost4x_8_99_MEGA"
#define kIAP_I_BOOST4X_14_99    @"boost4x_14_99_MEGA"
#define kIAP_I_BOOST4X_19_99    @"boost4x_19_99_MEGA"

#define kIAP_I_BOOST5X_14_99   @"boost5x_14_99_MEGA"
#define kIAP_I_BOOST5X_24_99   @"boost5x_24_99_MEGA"
#define kIAP_I_BOOST5X_34_99   @"boost5x_34_99_MEGA"
#define kIAP_I_BOOST5X_49_99   @"boost5x_49_99_MEGA"

#define kUSER_UNIQE_IDE        @"kuuqid"

#define IAP_ [B6luxIAPHelper sharedInstance]

#define kLEVEL [Exp returnLevelByEXP:[DB_ getValueBy:d_Exp table:d_DB_Table]]

//SOUND NAMES
#define s_coinHit   @"coins2.mp3"
#define s_bigWin    @"bigwin.mp3"
#define s_bgmusic   @"music.mp3"
#define s_reelStop1 @"reel_stop1.mp3"
#define s_reelStop2 @"reel_stop2.mp3"
#define s_winicon1  @"winicon1.mp3"
#define s_crowd1    @"crowd1.mp3"
#define s_winicon2  @"iconwin2.mp3"
#define s_winicon3  @"iconwin3.mp3"
#define s_wingame   @"levelup2.mp3"

#define s_reelsSpin     @"wheelspin.mp3"
#define s_bigwinflyin   @"fly_1.wav"

#define s_cardOpen      @"cardstone.mp3"
#define s_click1        @"button_click.mp3"

#define s_music(__X__)  [NSString stringWithFormat:@"m_%i.mp3",(__X__)]

#define s_unlockedMachine   @"magicsound.mp3"
#define s_nocoinsLeft       @"coin-drop-4.wav"
#define s_lockedmachine     @"locked.mp3"

#define sound_music     @"smus"
#define sound_fx        @"soundfxs"
#define s_sound         @"s_9.wav"

@interface cfg : NSObject{
    

    
}

+(NSString*)formatTo3digitsValue:(float)value_;

+(BOOL)isNumber:(int)a_ devidableBy:(int)b_;

+(NSInteger)MyRandomIntegerBetween:(int)min :(int)max;

//custom

+(void)SS_purchase_player:(NSString*)player type:(NSString*)type_ state:(int)state_;

+(NSString*)GENERATE_ME_UNIQID;

+(BOOL)SS_TAKE_BONUS_FOR:(NSString*)userID_;

+(NSString*)SS_CHECK_BONUSTIMEFOR:(NSString*)userID_;


@end
