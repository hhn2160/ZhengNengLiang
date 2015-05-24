//
//  UserInfoViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserInfoViewController : UITableViewController
@property (nonatomic,assign) NSUInteger currentpage;

@property (strong, nonatomic) IBOutlet UITableView *UserArticleTable;
- (IBAction)ShowCameraView:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *loadingView;
- (IBAction)LikeArticle:(id)sender;

@end
