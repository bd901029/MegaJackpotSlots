//
//  FacebookIconManager.m
//  Slotomania
//
//  Created by user on 12-6-27.
//  Copyright (c) 2012年 ChenYue. All rights reserved.
//

#import "FacebookIconManager.h"

@implementation FacebookIconManager

static NSString* IMAGE_INFO_FILE_NAME = @"Documents/ImageInfos.plist";
static FacebookIconManager * _sharedHelper = nil;

+ (FacebookIconManager *) sharedMgr {
	
    if (_sharedHelper != nil) {
        return _sharedHelper;
    }
    _sharedHelper = [[FacebookIconManager alloc] init];
    return _sharedHelper;
	
}

-(void)Init
{
    imagesInfoPath = [[NSHomeDirectory() stringByAppendingPathComponent:IMAGE_INFO_FILE_NAME] retain];
    imagesInfo = [[NSMutableDictionary alloc] initWithContentsOfFile:imagesInfoPath];
    if (imagesInfo == nil) {
        imagesInfo = [[NSMutableDictionary alloc] init];
    }
    
    imageDirectory = [[NSString alloc] initWithString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"]];

    icons = [[NSMutableDictionary alloc] init];

}

-(void)Clear
{
    [icons removeAllObjects];
}


@end
