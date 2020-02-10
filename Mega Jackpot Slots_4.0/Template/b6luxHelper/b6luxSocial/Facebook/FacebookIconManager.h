//
//  FacebookIconManager.h
//  Slotomania
//
//  Created by user on 12-6-27.
//  Copyright (c) 2012年 ChenYue. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FacebookIconManager : NSObject {
    NSString* imageDirectory;
    NSString* imagesInfoPath;
	NSMutableDictionary* imagesInfo;
    
    struct Icon
    {
        NSString*   url;
    };
	NSMutableDictionary* icons;
}

+ (FacebookIconManager*)sharedMgr;

-(void)Init;
-(void)Clear;

@end
