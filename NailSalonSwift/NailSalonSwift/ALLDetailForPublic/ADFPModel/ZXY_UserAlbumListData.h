//
//  ZXY_UserAlbumListData.h
//
//  Created by   on 15/1/30
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface ZXY_UserAlbumListData : NSObject <NSCoding, NSCopying>

@property (nonatomic, strong) NSString *dataDescription;
@property (nonatomic, strong) NSString *isWarn;
@property (nonatomic, strong) NSString *collectCount;
@property (nonatomic, strong) NSString *cutPath;
@property (nonatomic, strong) NSString *width;
@property (nonatomic, strong) NSString *imgCount;
@property (nonatomic, strong) NSString *userId;
@property (nonatomic, strong) NSString *cutHeight;
@property (nonatomic, strong) NSString *isFirst;
@property (nonatomic, strong) NSString *imageId;
@property (nonatomic, strong) NSString *cutWidth;
@property (nonatomic, strong) NSString *agreeCount;
@property (nonatomic, strong) NSString *height;
@property (nonatomic, strong) NSString *imagePath;
@property (nonatomic, strong) NSString *addTime;
@property (nonatomic, strong) NSString *albumId;
@property (nonatomic, strong) NSString *isRecommend;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
