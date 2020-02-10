#import "cfg.h"
#import "Combinations.h"
#import "Strings.h"
#import "cocos2d.h"

#import "SBJson.h"
#import "ASIFormDataRequest.h"
#import "ASIHTTPRequest.h"
#import "GAI.h"

#define kServerLink @""

@implementation cfg

+(NSString*)formatTo3digitsValue:(float)value_{
    
    NSNumberFormatter * formatter = [NSNumberFormatter new];
    [formatter setNumberStyle:NSNumberFormatterDecimalStyle];
   // [formatter setGroupingSeparator: @","];
	[formatter setGroupingSize: 3];
   // [formatter setMaximumFractionDigits:3]; // Set this if you need 2 digits
    NSString * newString = @"";
    
    if (value_ >= 10)
    {
        [formatter setGroupingSeparator: @","];
        newString = [formatter stringFromNumber:[NSNumber numberWithInt:value_]];
     
    }
    else if (value_ < 10)
    {
        newString = [formatter stringFromNumber:[NSNumber numberWithFloat:value_]];
    }
    
    [formatter release];
    
  //  NSLog(@"formatWidth %i",formatter.formatWidth);
    return newString;
}

+(NSInteger)MyRandomIntegerBetween:(int)min :(int)max
{
    return ( (arc4random() % (max-min+1)) + min );
}

+(NSString*)GENERATE_ME_UNIQID{
    
    NSString *ts = [NSString stringWithFormat:@"%i",[Combinations getTimeNow_in_unix]];
    
   // int leng = [ts length];
    
    for (int x = 0; x < 5; x++) {
        int rand = [cfg MyRandomIntegerBetween:0 :10];
        ts = [NSString stringWithFormat:@"%@%i",ts,rand];
    }
    
    if (ts ==nil || [ts isEqualToString:@""]) {
      //  NSLog(@"Warning - generated uniq id is invalid");
    }
    
    return ts;
}

+(BOOL)SS_TAKE_BONUS_FOR:(NSString*)userID_{
    
    BOOL gavedBonus;

    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",kServerLink]];
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
    [request setRequestMethod:@"POST"];
    
    [request setPostValue:@"take_bonus"          forKey:@"func"];
    [request setPostValue:userID_               forKey:@"player"];
    
    [request startSynchronous];
    
    NSError *error = [request error];
    NSString *response = [request responseString];
    
  //  NSLog(@"response string %@",response);
    
    if (error) {
        NSDictionary *tempDic= [response JSONValue];
        NSString *errorStr = [tempDic objectForKey:@"message"];
     //   NSLog(@"error message: %@",errorStr);
    }
    if (!error) {
        NSMutableArray *tempDic= [response JSONValue];
      //  NSLog(@"jsn got %@",tempDic);
        
        NSString *bonusState = [[tempDic objectAtIndex:0]objectForKey:@"status"];
      //  NSLog(@"%@",bonusState);
        
//        if ([bonusState isEqualToString:@""])
//        {
//            NSLog(@"Dont give bonus, it's not the time yet");
//            gavedBonus = NO;
//        }
        if ([bonusState isEqualToString:@"1"])
        {
         //   NSLog(@"Give the bonus");
             gavedBonus = YES;
        }
        else
        {
          //  NSLog(@"Warning ! Server error got invalid num giving bonus");
             gavedBonus = NO;
        }
        
        
    }

    
    return gavedBonus;
    
    
}

+(void)SS_purchase_player:(NSString*)player type:(NSString*)type_ state:(int)state_{
    
    if (![Combinations connectedToInternet])
    {
        return;
    }
    
    dispatch_queue_t  queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        
        //http://b6lux.com/api/server_v1.0.php
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",kServerLink]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        
        //    [request setUsername:kAPIUsername]; //cia reikia ideti analogiskai
        //    [request setPassword:kAPIPassword]; //email ir password is textfieldu
        
        [request setPostValue:@"purchase"   forKey:@"func"];
        [request setPostValue:player        forKey:@"player"];
        [request setPostValue:type_         forKey:@"type"];
        [request setPostValue:@""           forKey:@"price"];
        [request setPostValue:[NSString stringWithFormat:@"%i",state_]        forKey:@"state"];
        
        [request startSynchronous];
        
        NSError *error = [request error];
        NSString *response = [request responseString];
        //   NSLog(@"response string %@",response);
        
        if (error) {
            NSDictionary *tempDic= [response JSONValue];
            NSString *errorStr = [tempDic objectForKey:@"message"];
       //     NSLog(@"error message: %@",errorStr);
        }
        
    });
    
}

+(BOOL)isNumber:(int)a_ devidableBy:(int)b_{
    
    float a = (float)a_ / (float)b_;
    int aint = a_ / b_;
    float diff = a - aint;
    
    if (diff==0 && a_!=0)           //x_ == 3 || x_ == 6 || x_ == 9)
    {
        return YES;
    }
    return NO;
    
}


+(NSString*)SS_CHECK_BONUSTIMEFOR:(NSString*)userID_{
    
   // __block
    
     NSString *returnString = nil;
    
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@",kServerLink]];
        ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
        [request setRequestMethod:@"POST"];
        
        [request setPostValue:@"get_bonus"          forKey:@"func"];
        [request setPostValue:userID_               forKey:@"player"];
        
        [request startSynchronous];
        
        NSError *error = [request error];
        NSString *response = [request responseString];
        
      //  NSLog(@"response string %@",response);
        
        if (error) {
            NSDictionary *tempDic= [response JSONValue];
            NSString *errorStr = [tempDic objectForKey:@"message"];
          //  NSLog(@"error message: %@",errorStr);
        }
        if (!error) {
            NSMutableArray *tempDic= [response JSONValue];
         //   NSLog(@"jsn got %@",tempDic);
            
            NSString *bonusState = [[tempDic objectAtIndex:0]objectForKey:@"bonus_ready"];
          //  NSLog(@"%@",bonusState);
            
            if ([bonusState isEqualToString:@"0"])
            {
           //     NSLog(@"Not ready bonus, return the time");
                returnString = [[tempDic objectAtIndex:0]objectForKey:@"time_left"];
            }
            else if ([bonusState isEqualToString:@"1"])
            {
           //     NSLog(@"ready");
                returnString =  @"0";
            }
            else
            {
           //     NSLog(@"Warning ! Server error got invalid num");
                returnString = nil;
            }

            
        }

    
    return returnString;
    
}


@end

