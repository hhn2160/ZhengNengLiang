//
//  MyViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "MyViewController.h"
#import "UIImageView+WebCache.h"

@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self ShowUserInfo];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)ShowUserInfo
{
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *image = [userDefault objectForKey:@"image"];
    NSString *uid = [userDefault objectForKey:@"id"];
    //如果用户未登陆则把根视图控制器改变成登陆视图控制器
    if (name == nil)
    {
        self.userNameLabel.text=@"";
    }
    else
    {
        [self.userImageView sd_setImageWithURL:[NSURL URLWithString:image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
        CALayer * layer = [self.userImageView layer];
        [layer setMasksToBounds:YES];
        [layer setCornerRadius:8.0];
        [layer setMasksToBounds:YES];
        [layer setBorderWidth:2];
        [layer setBorderColor:[[UIColor whiteColor] CGColor]];
        self.userNameLabel.text=name;
        self.userInfoImage.hidden=true;
    }
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"SystemView"];
//    [self.navigationController pushViewController:registerViewController animated:YES];
}


- (IBAction)ShowLoginView:(id)sender {
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"UserLoginView"];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
@end
