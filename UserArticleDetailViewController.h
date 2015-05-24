//
//  UserArticleDetailViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-18.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UserArticleDetailViewController : UIViewController <UITextViewDelegate,UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIImageView *articleImage;
@property (weak, nonatomic) IBOutlet UILabel *articleContent;
@property (weak, nonatomic) IBOutlet UILabel *articleUserNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *articleTime;
@property (nonatomic,assign) NSUInteger *articleId;
@property (strong, nonatomic)  NSString *articleImageUrl;
@property (strong, nonatomic)  NSString *articleUserName;
@property (strong, nonatomic)  NSString *articleTimeStr;
@property (strong, nonatomic)  NSString *userImageUrl;
@property (strong, nonatomic)  NSString *articleContentStr;
@property (weak, nonatomic) IBOutlet UIImageView *userImage;
@property (weak, nonatomic) IBOutlet UITableView *pinglunTable;
@property (weak, nonatomic) IBOutlet UITextField *pinglunText;
@property (weak, nonatomic) IBOutlet UIView *pinglungTextView;
@property (nonatomic,assign) NSUInteger currentpage;
@end
