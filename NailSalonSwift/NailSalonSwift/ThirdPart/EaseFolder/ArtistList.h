//
//  ArtistList.h
//  KickYourAss
//
//  Created by 宇周 on 15/2/16.
//  Copyright (c) 2015年 多思科技. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface ArtistList : NSManagedObject

@property (nonatomic, retain) NSString * artistID;
@property (nonatomic, retain) NSString * artistImg;
@property (nonatomic, retain) NSString * artistName;

@end
