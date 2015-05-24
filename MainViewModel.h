//
//  MainViewModel.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainViewModel : NSObject
@property (nonatomic,strong) NSString *articleTitle;
@property (nonatomic,strong) NSString *articleImageUrl;
@property (nonatomic,assign) NSUInteger imageWidth;
@property (nonatomic,assign) NSUInteger imageHeight;
@property (nonatomic,assign) NSUInteger articleCatchId;
@end
