#import <Foundation/Foundation.h>
//#import <sys/socket.h>
//#import <netinet/in.h>
//#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIDevice(machine).h"

#define kk 0

@interface Combinations : NSObject{
    
}



#pragma mark - elements

+(BOOL)isRetina;

+(void)checkFrameSizes:(UIViewController*)view_;

+(void)showAllFonts;

#pragma mark - alerts

+(BOOL) connectedToInternet;

+(void)noInternetConnectionAlert;

+(void)noInternetConnectionAlert:(NSString*)text1:(NSString*)text2:(NSString*)text;


+(BOOL)fileExtistsWithPath:(NSString*)path_;

#pragma mark - keyboard actions

+(void)registerKeyboardActions:(UIViewController*)view_;

+(void)unregisterKeyboardActions:(UIViewController*)view_;

+(void)endEditng:(UIViewController*)view_;


#pragma mark - string actions

+(int)count_words_in_string:(NSString*)str;


#pragma mark - font actions

+(UIFont*)getFont:(NSString*)fontName:(int)size;


#pragma mark - color actions

+(UIColor*)getColor:(float)R:(float)G:(float)B;


#pragma mark - system data actions

+(NSString*)whatsMyDeviceModel;

+(NSString*)WhatsMyiOSVersion;

+(NSString*)WHatsMyUDID;

+(NSString*)WhatsMyMachine;



#pragma mark - time actions

+(NSString*)giveDOCUMENTSPATH;

+(int)getTimeNow_in_unix;

+(NSString*)getTimeNow_in_unix_STRING;

+(int)ConvertTime_string_ToUnix:(NSString*)datestr;

#pragma mark - indikator views

+(void)add_activity_indikator:(UIViewController*)view_ addField:(BOOL)field_ Text:(NSString*)text BlockUserInteract:(BOOL)block_;

+(void)remove_activity_indikator:(UIViewController*)view_;

+(UILabel*)add_indicator_label:(NSString*)message: (float)w pos_Y:(float)y;

+(UIView*)add_indicator_field :(float)w height:(float)h;

+(void)async_gcd:(SEL)sel1 :(SEL)sel2 :(SEL)sel3:(UIViewController*)view_;

+(void)async_gcd_VIEW:(SEL)sel1 :(SEL)sel2 :(SEL)sel3:(UIView*)view_;

+(void)async_gcd_NSOBJECT:(SEL)sel1 :(SEL)sel2 :(SEL)sel3:(NSObject*)view_;

#pragma mark - View Screen actions

+(BOOL)is_orientation_portrait;

+(BOOL)is_orientation_landspace;

+(float)give_me_screen_height;

+(float)give_me_screen_width;

+(void)move_screen:(UIViewController*)view_ up:(BOOL)up_ move_pixels:(float)move_px;

+(void)move_screen_default:(UIViewController*)view_;

+(void)add_background:(UIViewController*)view_ picName:(NSString*)name;

+(float)get_image_width:(NSString*)name_;
+(float)get_image_height:(NSString*)name_;


#pragma mark - Viewcontroller actions

+(void)navControllerDescription:(UIViewController*)view_;

+(int)count_view_controllers:(UIViewController*)view_;

+(void)hide_navigation_controller:(UIViewController*)view_ hide:(BOOL)val;

+(void)remove_view_controller:(UIViewController*)view_ nr:(int)tag;

+(BOOL)check_if_controller_was_created:(UIViewController*)view_ view:(NSString*)view2;

+(void)back_to_view_nr:(UIViewController*)view_ tag_number:(int)nr;

+(BOOL) check_controller_by_string:(UIViewController*)view_ controllerName:(NSString*)str;

#pragma mark - Locations Services

//+(BOOL)LocationServicesEnabled;

#pragma mark - Images Actions

+(void)saveImage:(UIImage*)image:(NSString*)imageName;

+(UIImage*)loadGetImage:(NSString*)imageName;

+(void)removeImage:(NSString*)fileName;

+(UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize ;

#pragma mark - NSDEFAULTS

+(void)saveNSDEFAULTS_FLOAT:(float)val_ forKey:(NSString*)key;
+(float)getNSDEFAULTS_FLOAT_forKey:(NSString*)key;

+(void)saveNSDEFAULTS_String:(NSString*)str forKey:(NSString*)key;
+(NSString*)getNSDEFAULTS_String:(NSString*)forKey;
+(void)removeNSDEFAULTS_String:(NSString*)forKey;

+(void)saveNSDEFAULTS_Bool:(BOOL)bool_ forKey:(NSString *)key;
+(BOOL)checkNSDEFAULTS_Bool_ForKey:(NSString*)key;


+(void)saveNSDEFAULTS_INT:(int)val_ forKey:(NSString*)key;
+(int)getNSDEFAULTS_INT_forKey:(NSString*)key;
+(void)removeNSDEFAULTS_INT:(NSString*)forKey;

+(BOOL)isNumberEven:(int)num;

@end
