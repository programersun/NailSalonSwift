//
//  ZXYOriginAlbumData.h
//
//  Created by   on 15/3/29
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXYOriginAlbumUser, ZXYOriginAlbumImage;

@interface ZXYOriginAlbumData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) ZXYOriginAlbumUser *user;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) ZXYOriginAlbumImage *image;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
