//
//  UserArticleTableViewCell.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-27.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserArticleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *UserArticleTitle;
@property (weak, nonatomic) IBOutlet UIImageView *UserArticleImage;
@property (weak, nonatomic) IBOutlet UILabel *userPingLun;
@property (weak, nonatomic) IBOutlet UILabel *userShouCang;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UIButton *pinglunButton;

@end
