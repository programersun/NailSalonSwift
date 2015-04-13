//
//  ZXY_AlbumDetailData.h
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXY_AlbumDetailUser;

@interface ZXY_AlbumDetailData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, assign) double isCollect;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, strong) NSString *imgCount;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) NSString *tag;
@property (nonatomic, assign) double isAtten;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSArray *images;
@property (nonatomic, assign) double isAgree;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) ZXY_AlbumDetailUser *user;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
