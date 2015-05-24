//
//  MainDetailViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "MainDetailViewController.h"
#import "MainNavController.h"
#import "MBProgressHUD.h"

@interface MainDetailViewController ()

@end

@implementation MainDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"加载中…";
    // Do any additional setup after loading the view.
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    //    [_DetailWebView setFrame:CGRectMake(0, 0, size.width, size.height )];
    [_MainDetailView setFrame:CGRectMake(0, 0, size.width, size.height )];
    [self.MainDetailView setScalesPageToFit:YES];                    //自动缩放页面以适应屏幕
    NSString *urlStr=[[NSString alloc] initWithFormat:
                      @"http://znl.jingerge.com/newsapp.aspx?aid=%@",[NSString stringWithFormat:@"%d", self.newsId]];
//    NSLog(urlStr);
    NSURL *url=[NSURL URLWithString:urlStr];
    NSURLRequest *request=[NSURLRequest requestWithURL:url];
    [_MainDetailView loadRequest:request];
    self.MainDetailView.delegate=self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
