//
//  LoginViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "LoginViewController.h"
#import "MBProgressHUD.h"
#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import <CommonCrypto/CommonDigest.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)ShowRegView:(id)sender {
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"UserRegView"];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
- (IBAction)userLogin:(id)sender {
    NSString *userphone=self.userPhone.text;
    NSString *userpwd=[self md5:self.userPwd.text];;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"登录中…";
    [NETWORK userLoginWithParameters:@{
                                            @"userphone":(userphone),
                                            @"userpwd":(userpwd),
                                            @"action":@"login"
                                            } completionHandler:^(id response, NSError *error) {
                                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                if (error) {
                                                    hud.mode=MBProgressHUDModeText;
                                                    hud.labelText=@"出错啦！稍后再试";
                                                    return ;
                                                }
                                                if ([response[@"IsSucess"] isEqualToString:@"ok"]) {
                                                    NSString *uName=response[@"User_Name"];
                                                    NSString *uImage=response[@"User_Image"];
                                                    NSString *uId=response[@"User_Id"];
                                                    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
                                                    //登陆成功后把用户名和密码存储到UserDefault
                                                    [userDefaults setObject:uName forKey:@"name"];
                                                    [userDefaults setObject:uImage forKey:@"image"];
                                                    [userDefaults setObject:uId forKey:@"id"];
                                                    [userDefaults synchronize];
                                                    hud.mode=MBProgressHUDModeText;
                                                    hud.labelText=@"登录成功";
                                                    [self GotoUserInfoView];
                                                    //return;
                                                }
                                                else if([response[@"IsSucess"] isEqualToString:@"error"])
                                                {
                                                    hud.mode=MBProgressHUDModeText;
                                                    hud.labelText=@"密码错误，请重试";
                                                    return;
                                                }
                                                else if([response[@"IsSucess"] isEqualToString:@"no"])
                                                {
                                                    hud.mode=MBProgressHUDModeText;
                                                    hud.labelText=@"手机号未注册，请注册";
                                                    return;
                                                }
                                            }];
 
}
-(void)GotoUserInfoView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"UserLoginInfoView"];
    //    [self.navigationController pushViewController:registerViewController animated:YES];
    CATransition *transition = [CATransition animation];
    transition.duration = 1;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    transition.delegate = self;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    self.navigationController.navigationBarHidden = NO;
    [self.navigationController pushViewController:registerViewController animated:NO];
    
}
- (NSString *)md5:(NSString *)str
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, strlen(cStr), result); // This is the md5 call
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}
@end
