//
//  RegInfoViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegInfoViewController : UIViewController
@property (strong, nonatomic) NSString *userCode;
@property (weak, nonatomic) IBOutlet UITextField *userName;
@property (weak, nonatomic) IBOutlet UITextField *userPwd;
@property (weak, nonatomic) IBOutlet UIButton *addImageButton;
- (IBAction)addUserInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *userInfoImage;
- (IBAction)AddUserImage:(id)sender;
@property (strong, nonatomic)NSString *userPhoneStr;
@end
