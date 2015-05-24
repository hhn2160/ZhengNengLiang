//
//  MyViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UITableViewController<UITabBarDelegate,UITableViewDelegate,UITableViewDataSource>
- (IBAction)ShowLoginView:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *userInfoImage;
@property (weak, nonatomic) IBOutlet UIImageView *userImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@end
