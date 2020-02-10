#import "Combinations.h"
#import <QuartzCore/QuartzCore.h>
#import <MapKit/MapKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "Connectivity.h"


#define kLoadingIndikator 4001
#define kLoadingIndikatorField 4002

@implementation Combinations

#pragma mark - alerts

+(BOOL)isRetina{
    
    return ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && [[UIScreen mainScreen] scale] == 2.0f);
    
}

+(void)checkFrameSizes:(UIViewController*)view_{
    
   // NSLog(@"Frame: %f, %f, %f, %f", view_.view.frame.origin.x, view_.view.frame.origin.y, view_.view.frame.size.width, view_.view.frame.size.height);
    
}

+(void)showAllFonts{
    
    NSArray *familyNames = [UIFont familyNames];
    for( NSString *familyName in familyNames ){
        printf( "Family: %s \n", [familyName UTF8String] );
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        for( NSString *fontName in fontNames ){
            printf( "\tFont: %s \n", [fontName UTF8String] );
        }
    }
    
}

+ (BOOL) connectedToInternet
{
//    NSString *URLString = [NSString stringWithContentsOfURL:[NSURL URLWithString:@"http://www.google.com"]];
//    return ( URLString != NULL ) ? YES : NO;
    if ([Connectivity hasConnectivity]) {
        return YES;
    }
    return NO;
}

+(void)noInternetConnectionAlert{
    //-----default aler
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Please check connection" 
                                                    message:@"" 
                                                   delegate:self 
                                          cancelButtonTitle:@"Dismiss" 
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}

+(void)noInternetConnectionAlert:(NSString*)text1:(NSString*)text2:(NSString*)text{
    //-----modified alert
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:text1
                                                    message:text
                                                   delegate:self 
                                          cancelButtonTitle:text2 
                                          otherButtonTitles:nil, nil];
    [alert show];
    
}

#pragma mark - keyboard actions

+(void)registerKeyboardActions:(UIViewController*)view_{
    //-----tracks actions when keyboard is opened. 
    
 if (kk)   NSLog(@"Comb : Register for keyboard notifications");

    [[NSNotificationCenter defaultCenter] addObserver:view_
                                             selector:@selector(keyboardWillShow)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:view_
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
    
    //-----     -(void)keyboardWillShow{    NSLog(@"keyboard is shown");    }       //method in view_
}

+(void)unregisterKeyboardActions:(UIViewController*)view_{
    //-----tracks actions when keyboard is closed. 
    
  if (kk)  NSLog(@"Comb : Unregister for keyboard notifications while not visible.");
    
    [[NSNotificationCenter defaultCenter] removeObserver:view_
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:view_
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];

    //-----     -(void)keyboardWillHide{    NSLog(@"keyboard will hide");   }       //method in view_
}

+(void)endEditng:(UIViewController*)view_{
    //-----close the keyboard and other editing objects
    
     [view_.view endEditing:YES];
     NSLog(@"Comb : close all editing objects");
}

#pragma mark - string actions

+(int)count_words_in_string:(NSString*)str{
    //-----count words in string
    
    NSArray *wor = [str componentsSeparatedByString:@" "];
    NSLog(@"Comb : counting < %@ > words. Rezult : %i",str,[wor count]);
    return [wor count];
}

#pragma mark - font actions

+(UIFont*)getFont:(NSString*)fontName:(int)size{
    //----get font by name, assing size
    
    UIFont *myFont = [UIFont fontWithName:fontName size:size];
 if (kk)   NSLog(@"Comb : request color name : %@ size : %i",fontName,size);
    return myFont;
}

#pragma mark - color actions

+(UIColor*)getColor:(float)R:(float)G:(float)B{
    //----get color
    
    UIColor *color =  [UIColor colorWithRed:R/255.f green:G/255.f blue:B/255.f alpha:1.f];
   // NSLog(@"Comb : sending color RGB : %f %f %f -> Got color %f %f %f",R,G,B,R/255.f,G/255.f,B/255.f);
    return color;

}

#pragma mark - system data actions



+(NSString*)whatsMyDeviceModel{
    //----- device model (iPhone, iPad)
//    NSLog(@"device: %@", [[UIDevice currentDevice] machine]);
    NSString *model = [[UIDevice currentDevice] model];
   // NSString *model =  [[UIDevice currentDevice] machine]);
 //   NSLog(@"Comb : Device model : %@", model);
    return model; 
}

+(NSString*)WhatsMyiOSVersion{
    //----- iOs version
    
    NSString *version = [[UIDevice currentDevice] systemVersion];
  //  NSLog(@"Comb : Device system version : %@",version);
    return version;
}

+(NSString*)WHatsMyUDID{
    
    return nil;
   // return [[UIDevice currentDevice] uniqueIdentifier];
    
}

+(NSString*)WhatsMyMachine{
    
    return [UIDevice_machine_ machine];
    
}

#pragma mark - time actions

+(int)getTimeNow_in_unix{
    //----- System time in unix
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:startDate];
    startDate = [startDate dateByAddingTimeInterval:interval];
    int startTime = [startDate timeIntervalSince1970];
    NSLog(@"Comb : System time now in Unix %d",startTime);
    return startTime;
}

+(NSString*)getTimeNow_in_unix_STRING{
    //----- System time in unix
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [NSDate date];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:startDate];
    startDate = [startDate dateByAddingTimeInterval:interval];
    int startTime = [startDate timeIntervalSince1970];
    NSLog(@"Comb : System time now in Unix %d",startTime);
    return [NSString stringWithFormat:@"%i",startTime];
}

+(int)ConvertTime_string_ToUnix:(NSString*)datestr{
    //-----convert string to unix
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSDate *startDate = [dateFormatter dateFromString:datestr];
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:startDate];
    startDate = [startDate dateByAddingTimeInterval:interval];
    int startTime = [startDate timeIntervalSince1970];
    NSLog(@"Comb : String date converted to unix %d",startTime);
    return startTime;
}

#pragma mark - indikator views

+(void)add_activity_indikator:(UIViewController*)view_ addField:(BOOL)field_ Text:(NSString*)text BlockUserInteract:(BOOL)block_{
    //-----get the actitivy indikator
    NSLog(@"Comb : Adding activity indicator");
    
    float fieldW =             130;            //----- field width
    float fieldH =             110;           //----- field height
    float textYpos = fieldH * 0.6f;          //----- text position move down
    float indicator_W =         32;         //----- width of indicator
    float indicator_H =         32;        //----- height of indicator
    
    UIView *field;
    UIActivityIndicatorView* indicatorView;
    
    if (block_) view_.view.userInteractionEnabled = NO;

    indicatorView = 
    [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite]; //----white style indicator
    [indicatorView setFrame:CGRectMake(0,0, indicator_W, indicator_H)];
    [indicatorView setHidesWhenStopped:YES];
    indicatorView.center = view_.view.center;       //-----always in view center
    [indicatorView startAnimating];
    
    if (field_) {
        field = [Combinations add_indicator_field:fieldW height:fieldH];
        field.center = indicatorView.center;
        [view_.view addSubview:field];
    }
    
    if (text != nil) {
        UILabel *label = [Combinations add_indicator_label:text :fieldW pos_Y:textYpos];
        [field addSubview:label];
    }
    
    field.tag =         kLoadingIndikatorField;     // 4002 tag
    indicatorView.tag = kLoadingIndikator;          // 4001 tag
    
    [view_.view addSubview:indicatorView];

}

+(void)remove_activity_indikator :(UIViewController*)view_{
    //-----remove loading Indicator & Loading field & Text Label
    
    for (UIView *subview in [view_.view subviews]) {
        if (subview.tag == kLoadingIndikator) {
            [subview removeFromSuperview];
  //          NSLog(@"Comb : Loading indicator removed       (tag = %i)",kLoadingIndikator);
        }
        
        if (subview.tag == kLoadingIndikatorField) {
            [subview removeFromSuperview];
   //         NSLog(@"Comb : Loading indicator field removed (tag = %i)",kLoadingIndikatorField);
        }
    }
    
     view_.view.userInteractionEnabled = YES;
    
}

+(UIView*)add_indicator_field :(float)w height:(float)h{
    //-----add black opacity 0.6f field, weight - w, height - h;
    
    UIView *myView = [[UIView alloc] initWithFrame:CGRectMake(0,0, w,h)];  
    myView.layer.cornerRadius = 10;  
    myView.backgroundColor = [UIColor colorWithWhite:0.0 alpha:0.6f];
    return myView;
    
}


+(UILabel*)add_indicator_label:(NSString*)message: (float)w pos_Y:(float)y{
    
    CGRect rect2 = CGRectMake(0, y, w, 40);
    UILabel *loads = [[UILabel alloc]initWithFrame:rect2];
    loads.backgroundColor = [UIColor clearColor];
    loads.textAlignment = UITextAlignmentCenter;
    loads.textColor = [UIColor whiteColor];
    // loads.font = [Combinations getFontArial:5];
    [loads setText:message];
    [loads setUserInteractionEnabled:NO];
    
    return loads;
}

+(void)callSel:(SEL)sel1:(UIViewController*)view_{
    
     
    
}

#pragma mark - async loading with Grand Central Dispatcher Actions

+(void)async_gcd:(SEL)sel1 :(SEL)sel2 :(SEL)sel3:(UIViewController*)view_{
    
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
        dispatch_async(queue, ^{
        
            dispatch_async(dispatch_get_main_queue(), ^{    
        //        NSLog(@"Comb : Async loading start...");
        //
                [view_ performSelector:sel1];
            });
                    [view_ performSelector:sel2];
        
                        dispatch_async(dispatch_get_main_queue(), ^{
                 //           NSLog(@"Comb : Async loading done.");
                    [view_ performSelector:sel3];
            
        });
        
    });
    
}

+(void)async_gcd_VIEW:(SEL)sel1 :(SEL)sel2 :(SEL)sel3:(UIView*)view_{
    
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
         //   NSLog(@"Comb : Async loading start...");
            
            [view_ performSelector:sel1];
        });
        [view_ performSelector:sel2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
         //   NSLog(@"Comb : Async loading done.");
            [view_ performSelector:sel3];
            
        });
        
    });
    
}

+(void)async_gcd_NSOBJECT:(SEL)sel1 :(SEL)sel2 :(SEL)sel3:(NSObject*)view_{
    
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        dispatch_async(dispatch_get_main_queue(), ^{
          //  NSLog(@"Comb : Async loading start...");
            
            [view_ performSelector:sel1];
        });
        [view_ performSelector:sel2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
        //    NSLog(@"Comb : Async loading done.");
            [view_ performSelector:sel3];
            
        });
        
    });
    
}

#pragma mark - View Actions

+(float)give_me_screen_height{
    
    if (k_APPORIENTATION_PORTRAIT) {
    //    NSLog(@"1");
        if (IS_IPAD) {
          //  NSLog(@"Comb : IPad : screen height is %d",HEIGHT_P_IPAD);
            return  HEIGHT_P_IPAD;
        }
        else if (IS_IPHONE_5){
          //  NSLog(@"Comb : IPhone 5 : screen height is %d",HEIGHT_P_IPHONE_5);
            return  HEIGHT_P_IPHONE_5;
        }
        else if (IS_IPHONE){
          //  NSLog(@"Comb : IPhone : screen height is %d",HEIGHT_P_IPHONE);
            return  HEIGHT_P_IPHONE;
        }
        
    }
  else if (!k_APPORIENTATION_PORTRAIT) {
      NSLog(@"2");
        if (IS_IPAD) {
          //  NSLog(@"Comb : IPad : screen height is %d",HEIGHT_L_IPAD);
            return  HEIGHT_L_IPAD;
        }
        else if (IS_IPHONE_5){
          //  NSLog(@"Comb : IPhone 5 : screen height is %d",HEIGHT_L_IPHONE_5);
            return  HEIGHT_L_IPHONE_5;
        }
        else if (IS_IPHONE){
          //  NSLog(@"Comb : IPhone : screen height is %d",HEIGHT_L_IPHONE);
            return  HEIGHT_L_IPHONE;
        }
        
    }
    
    return HEIGHT_P_IPHONE;
}

+(float)give_me_screen_width{
    
    if (k_APPORIENTATION_PORTRAIT) {
        if (IS_IPAD) {
      //      NSLog(@"Comb : IPad : screen width is %d",WIDTH_P_IPAD);
            return  WIDTH_P_IPAD;
        }
        else if (IS_IPHONE_5){
      //      NSLog(@"Comb : IPhone 5 : screen width is %d",WIDTH_P_IPHONE_5);
            return  WIDTH_P_IPHONE_5;
        }
        else if (IS_IPHONE){
       //     NSLog(@"Comb : IPhone : screen width is %d",WIDTH_P_IPHONE);
            return  WIDTH_P_IPHONE;
        }
        
    }
   else if (!k_APPORIENTATION_PORTRAIT) {
        if (IS_IPAD) {
       //     NSLog(@"Comb : IPad : screen width is %d",WIDTH_L_IPAD);
            return  WIDTH_L_IPAD;
        }
        else if (IS_IPHONE_5){
            //NSLog(@"Comb : IPhone 5 : screen width is %d",WIDTH_L_IPHONE_5);
            return  WIDTH_L_IPHONE_5;
        }
        else if (IS_IPHONE){
          //  NSLog(@"Comb : IPhone : screen width is %d",WIDTH_L_IPHONE);
            return  WIDTH_L_IPHONE;
        }
        
    }
    return WIDTH_P_IPHONE;
}

+(BOOL)is_orientation_portrait{
    
    if (UIDeviceOrientationIsPortrait([UIDevice currentDevice].orientation))
    {
        NSLog(@"Comb : Orientation is Portrait");
        return YES;     
    }
       NSLog(@"Comb : Orientation is Landspace");
    return NO;
}

+(BOOL)is_orientation_landspace{
    
    if (UIDeviceOrientationIsLandscape([UIDevice currentDevice].orientation))
    {
        NSLog(@"Comb : Orientation is Landspace");
        return YES;     
    }
       NSLog(@"Comb : Orientation is Portrait");
    return NO;
}

+(void)move_screen:(UIViewController*)view_ up:(BOOL)up_ move_pixels:(float)move_px{
    
    float moveSpeed = 0.3f;
    if ([[Combinations WhatsMyiOSVersion]intValue] >=5) moveSpeed = 0.25f;
    float width =  [Combinations give_me_screen_width];
    float height = [Combinations give_me_screen_height];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:moveSpeed];
    
    if (up_) {
        view_.view.frame = CGRectMake(0,-move_px,width,height);
    }
    
    else {
        
        view_.view.frame = CGRectMake(0, move_px, width, height);
    }
    
    [UIView commitAnimations];
    
    NSLog(@"Comb : Move screen  : %f",move_px);
    
}

+(void)move_screen_default:(UIViewController*)view_{
    
    NSLog(@"Comb : Move screen to default");
    
    float moveSpeed = 0.3f;
    if ([[Combinations WhatsMyiOSVersion]intValue] >=5) moveSpeed = 0.25f;
    float width =  [Combinations give_me_screen_width];
    float height = [Combinations give_me_screen_height];
    
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:moveSpeed];
    view_.view.frame = CGRectMake(0,0,width,height);
    [UIView commitAnimations];
    
}

+(void)add_background:(UIViewController*)view_ picName:(NSString*)name{
    
    CGRect rect = CGRectMake(0, 0, [Combinations give_me_screen_width],[Combinations give_me_screen_height]);
    
    UIImageView *bg = [[UIImageView alloc] initWithFrame:rect];
    
    [bg setImage:     [UIImage imageNamed:name]];
    
    [bg setBackgroundColor:[UIColor clearColor]];
    bg.opaque = NO;
    bg.contentMode = UIViewContentModeScaleAspectFill;
    
    [view_.view addSubview:bg];
    [view_.view sendSubviewToBack:bg];
    
}

+(float)get_image_width:(NSString*)name_{
    
    return [UIImage imageNamed:name_].size.width/2;
    
}
+(float)get_image_height:(NSString*)name_{
    
    return [UIImage imageNamed:name_].size.height/2;
    
}

/*
- (void)viewWillAppear:(BOOL)animated       // before the view appears

- (void)viewDidAppear:(BOOL)animated        // after the view appears 

- (void)viewWillDisappear:(BOOL)animated    // before the view disappears

- (void)viewDidDisappear:(BOOL)animated     // after the view disappears, but before the controller is released
*/

#pragma mark - ViewController actions

+(void)navControllerDescription:(UIViewController*)view_{

 NSLog(@"navcontroller desc %@",[[view_.navigationController viewControllers] description]);

}

+(int)count_view_controllers:(UIViewController*)view_{
    
    int count = [[view_.navigationController viewControllers] count];
    NSLog(@"Comb : Counting viewControllers : %i",count);
    return count; 
    
}

+(void)remove_view_controller:(UIViewController*)view_ nr:(int)tag{
    
    NSMutableArray *VCs = [NSMutableArray arrayWithArray: view_.navigationController.viewControllers];
    [Combinations navControllerDescription:view_];
    [VCs removeObjectAtIndex:tag];
    [Combinations navControllerDescription:view_];
    
}

+(void)hide_navigation_controller:(UIViewController*)view_ hide:(BOOL)val{
    
    if (val) {
        view_.navigationController.navigationBarHidden = YES;
    }
    else {
        view_.navigationController.navigationBarHidden = NO;
    }
}

+(BOOL)check_if_controller_was_created:(UIViewController*)view_ view:(NSString*)view2{
    /////!!!!!!!!!!!! IF view is "view" it will return YES etc !!!!!!!!!!!!!
    
    NSString *string = [[view_.navigationController viewControllers] description];
    
    if ([string rangeOfString:view2].location == NSNotFound) {
        NSLog(@"Comb : There is NO viewController named '' %@ '' between %@",view2,string);
        return NO;
    } else {
        NSLog(@"Comb : There IS viewController named '' %@ '' between %@",view2,string);
        return YES;
    }
    
//-----Private method. Check if viewController is in stack
//    for (UIViewController *controller in [view_.navigationController viewControllers]) {
//        if ([controller isMemberOfClass:[view_2 class]]){
//          NSLog(@"%@ is in stack",view_2);  
//        }
//    }
    
}

+(void)back_to_view_nr:(UIViewController*)view_ tag_number:(int)nr{

[view_.navigationController popToViewController:[view_.navigationController.viewControllers objectAtIndex:nr] animated:YES];

}

+(BOOL) check_controller_by_string:(UIViewController*)view_ controllerName:(NSString*)str{

if([view_ isMemberOfClass:NSClassFromString(str)])
{
    NSLog(@"Comb : Checking controller by string %@ . Return YES",str);
    return YES;
}
    NSLog(@"Comb : Checking controller by string %@ . Return NO",str);
    return NO;
}

//+(BOOL)LocationServicesEnabled{
//    
//    if([CLLocationManager locationServicesEnabled])
//    {
//        return YES;
//    }
//    return NO;
//}




#pragma mark - Images Actions

+(void)saveImage:(UIImage*)image:(NSString*)imageName{
    
    NSData *imageData = UIImagePNGRepresentation(image); //convert image into .png format.
    
    NSFileManager *fileManager = [NSFileManager defaultManager];//create instance of NSFileManager
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES); //create an array and store result of our search for the documents directory in it
    
    NSString *documentsDirectory = [paths objectAtIndex:0]; //create NSString object, that holds our exact path to the documents directory
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]]; //add our image to the path
    
    [fileManager createFileAtPath:fullPath contents:imageData attributes:nil]; //finally save the path (image)
    
    NSLog(@"Comb : %@.png image saved",imageName);
    
}

+(UIImage*)loadGetImage:(NSString*)imageName{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", imageName]];
    
    return [UIImage imageWithContentsOfFile:fullPath];
}

+(void)removeImage:(NSString*)fileName{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *fullPath = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.png", fileName]];
    
    [fileManager removeItemAtPath: fullPath error:NULL];
    
    NSLog(@"Comb : image %@.png removed",fileName);
    
}

+(UIImage *)resizeImage:(UIImage*)image newSize:(CGSize)newSize {
    CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
    CGImageRef imageRef = image.CGImage;
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // Set the quality level to use when rescaling
    CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
    CGAffineTransform flipVertical = CGAffineTransformMake(1, 0, 0, -1, 0, newSize.height);
    
    CGContextConcatCTM(context, flipVertical);
    // Draw into the context; this scales the image
    CGContextDrawImage(context, newRect, imageRef);
    
    // Get the resized image from the context and a UIImage
    CGImageRef newImageRef = CGBitmapContextCreateImage(context);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    UIGraphicsEndImageContext();
    
    return newImage;
}

#pragma mark - NSUSERDEFAULT Actions

+(void)saveNSDEFAULTS_FLOAT:(float)val_ forKey:(NSString*)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setFloat:val_ forKey:key];
    [prefs synchronize];
    
}

+(NSString*)giveDOCUMENTSPATH{
    
    NSArray *paths =    NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *path =    [paths objectAtIndex:0];
    path = [NSString stringWithFormat:@"%@/",path];
    return path;
    
}

+(BOOL)fileExtistsWithPath:(NSString*)path_{
    
    BOOL txtExists = [[NSFileManager defaultManager] fileExistsAtPath:path_];
    if (txtExists) {
     //   NSLog(@"file EXISTS :%@",path_);
        return YES;
    }
    else {
        //NSLog(@"FILE DOES NOT EXIST %@",path_);
    }
    return NO;
}

+(float)getNSDEFAULTS_FLOAT_forKey:(NSString*)key{
    
     return [[NSUserDefaults standardUserDefaults] floatForKey:key];
    
}

+(void)saveNSDEFAULTS_INT:(int)val_ forKey:(NSString*)key{
    
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setInteger:val_ forKey:key];
    [prefs synchronize];
    
}

+(int)getNSDEFAULTS_INT_forKey:(NSString*)key{
    
    return [[NSUserDefaults standardUserDefaults] integerForKey:key];
    
}

+(void)removeNSDEFAULTS_INT:(NSString*)forKey{
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:forKey];
}

+(void)saveNSDEFAULTS_String:(NSString*)str forKey:(NSString*)key{
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    [prefs setObject:str forKey:key];
    [prefs synchronize];
}

+(NSString*)getNSDEFAULTS_String:(NSString*)forKey{

   return [[NSUserDefaults standardUserDefaults] stringForKey:forKey];
    
}

+(void)removeNSDEFAULTS_String:(NSString*)forKey{
   // NSLog(@"Comb : removing from NSUSERDEFAULTS string for key %@",forKey);
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:forKey];
}

+(void)saveNSDEFAULTS_Bool:(BOOL)bool_ forKey:(NSString *)key{
    
    if (bool_) {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: TRUE forKey: key];
      //  NSLog(@"SET TO TRUE KEY %@",key);
        [defaults synchronize];
    }
    else if (!bool_){
        
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        [defaults setBool: FALSE forKey: key];
       //  NSLog(@"SET TO FALSE KEY %@",key);
        [defaults synchronize];
    }
}

+(BOOL)checkNSDEFAULTS_Bool_ForKey:(NSString*)key{
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL unlocked = [defaults boolForKey: key];
    
    if (!unlocked) {
      //  NSLog(@"Key <<%@>> is FALSE",key);
        return NO;
    } else {
        //  NSLog(@"Key <<%@>> is TRUE",key);
        return YES;
    }
    return NO;
}

+(BOOL)isNumberEven:(int)num{
    
    if (num % 2){
        //    NSLog(@"odd-nelyginis");
        return NO;
    }
    else{
        //  NSLog(@"even-lyginis");
        return YES;
    }
    return NO;
}

@end

//bringSubviewToFront
//sendSubviewToBack
//or any of the following if you're inserting the UIImageView as a subview:
//
//insertSubview:atIndex
//insertSubview:aboveSubview
//insertSubview:belowSubview
