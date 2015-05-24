//
//  RegsiterViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "RegsiterViewController.h"
#import "RegInfoViewController.h"
#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import "MBProgressHUD.h"

@interface RegsiterViewController ()

@end

@implementation RegsiterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"提交中…";
    NSString *phone= self.userPhoneText.text;
    NSString *code=self.userCode.text;
    [NETWORK addUserPhoneWithParameters:@{
                                          @"phone":(phone),
                                          @"code":(code),
                                          @"action":@"checkcode"
                                          } completionHandler:^(id response, NSError *error) {
                                              //                                            [self endLoading];
                                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                              if (error) {
                                                  hud.mode=MBProgressHUDModeText;
                                                  hud.labelText=@"出错啦！稍后再试";
                                                  return ;
                                              }
                                              if ([response[@"IsSucess"] isEqualToString:@"ok"]) {
                                                  if ([segue.identifier isEqualToString:@"RegInfoSegue"]) {
                                                      
                                                      RegInfoViewController *newsDetail = (RegInfoViewController*)segue.destinationViewController;
//                                                      [newsDetail setValue:self.userPhoneText.text forKey:@"userPhone"];
                                                      newsDetail.userPhoneStr=self.userPhoneText.text;
                                                  }
                                                  //return;
                                              }
                                              else if([response[@"IsSucess"] isEqualToString:@"no"])
                                              {
                                                  hud.mode=MBProgressHUDModeText;
                                                  hud.labelText=@"验证错误";
                                                  //return;
                                              }
                                              else
                                              {
                                                  hud.mode=MBProgressHUDModeText;
                                                  hud.labelText=@"验证错误";
                                                  //NSLog(response[@"IsSucess"]);
                                                  return;
                                              }
                                          }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (IBAction)CheckPhone:(id)sender {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"提交中…";
    NSString *phone= self.userPhoneText.text;
    [NETWORK addUserPhoneWithParameters:@{
                                        @"phone":(phone),
                                        @"action":@"addphone"
                                        } completionHandler:^(id response, NSError *error) {
//                                            [self endLoading];
                                            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                            if (error) {
                                                hud.mode=MBProgressHUDModeText;
                                                hud.labelText=@"出错啦！稍后再试";
                                                return ;
                                            }
                                            if ([response[@"IsSucess"] isEqualToString:@"ok"]) {
                                                hud.mode=MBProgressHUDModeText;
                                                hud.labelText=@"发送成功";
                                                return;
                                            }
                                            else if([response[@"IsSucess"] isEqualToString:@"repeat"])
                                            {
                                                hud.mode=MBProgressHUDModeText;
                                                hud.labelText=@"手机号已使用";
                                                return;
                                            }
                                            
                                        }];

}
@end
