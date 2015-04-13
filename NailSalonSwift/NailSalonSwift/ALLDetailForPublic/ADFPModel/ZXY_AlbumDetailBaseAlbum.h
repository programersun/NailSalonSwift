//
//  ZXY_AlbumDetailBaseAlbum.h
//
//  Created by   on 15/4/12
//  Copyright (c) 2015 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ZXY_AlbumDetailData;

@interface ZXY_AlbumDetailBaseAlbum : NSObject <NSCoding, NSCopying>

@property (nonatomic, assign) double result;
@property (nonatomic, strong) ZXY_AlbumDetailData *data;

+ (instancetype)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
