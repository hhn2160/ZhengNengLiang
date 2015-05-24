//
//  UserArticleModel.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-27.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserArticleModel : NSObject

@property (nonatomic,strong) NSString *articleTitle;
@property (nonatomic,strong) NSString *articleImageUrl;
@property (nonatomic,assign) NSUInteger imageWidth;
@property (nonatomic,assign) NSUInteger imageHeight;
@property (nonatomic,assign) NSUInteger userid;
@property (nonatomic,strong) NSString *userName;
@property (nonatomic,strong) NSString *userArticleTimeStr;
@property (nonatomic,strong) NSString *userImage;
@property (nonatomic,assign) NSUInteger commonCount;
@property (nonatomic,assign) NSUInteger likeCount;
@property (nonatomic,assign) NSUInteger userArticleId;
@end
