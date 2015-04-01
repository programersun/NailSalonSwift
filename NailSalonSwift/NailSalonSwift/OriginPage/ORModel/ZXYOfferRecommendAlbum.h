//
//  ZXYOfferRecommendAlbum.h
//
//  Created by   on 15/3/31
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXYOfferImage;

@interface ZXYOfferRecommendAlbum : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *nickName;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *headImage;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, strong) NSString *role;
@property (nonatomic, strong) ZXYOfferImage *image;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *recommendAlbumDescription;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *addTime;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
