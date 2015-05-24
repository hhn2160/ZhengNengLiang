//
//  CameraViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-28.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "CameraViewController.h"
#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import "AFNetworking.h"
#import "UserInfoViewController.h"
#import "MBProgressHUD.h"
@interface CameraViewController ()
@property (nonatomic,strong) NSString *userId;
@end

@implementation CameraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *uid = [userDefault objectForKey:@"id"];
    //如果用户未登陆则把根视图控制器改变成登陆视图控制器
    if (name == nil)
    {
        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
        UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"UserLoginView"];
        [self.navigationController pushViewController:registerViewController animated:YES];
    }
    else
    {
        self.userId=uid;
    }
//    CGRect frame = [self.articleContent frame];
//    frame.size.width = 7.0f;
//    UIView *leftview = [[UIView alloc] initWithFrame:frame];
//    self.articleContent.leftViewMode = UITextFieldViewModeAlways;
//    self.articleContent.leftView = leftview;
//    self.articleContent.rightViewMode=UITextFieldViewModeAlways;
//    self.articleContent.rightView=leftview;
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self ShowImage];
}
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ShowImage
{
        NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
        UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//        isFullScreen = NO;
        [self.cameraIamge setImage:savedImage];
        self.cameraIamge.tag = 100;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void)textViewDidBeginEditing:(UITextView *)textView {
    if ([textView.text isEqualToString:@"写下我的正能量"]) {
        textView.text = @"";
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView {
    if (textView.text.length<1) {
        textView.text = @"写下我的正能量";
    }
}
- (IBAction)CloseCameraView:(id)sender {
    [self GotoUserListView];
}

- (IBAction)AddArticle:(id)sender {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"发送中…";
    NSString *articleContent=self.articleContent.text;
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //上传其他所需参数
    NSString *userid=self.userId ;
    //上传请求POST
    AFHTTPClient *client=[ AFHTTPClient clientWithBaseURL :[ NSURL URLWithString : @"" ]];
    //NSString *urlString=[NSString stringWithFormat:@"http://172.16.168.168:8000/control/add.aspx"];
    NSString *urlString=[NSString stringWithFormat:@"http://znl.jingerge.com/control/add.aspx"];
    NSDictionary *dics=[[ NSDictionary alloc ] initWithObjectsAndKeys :userid, @"userid" ,articleContent,@"content", nil ];
    NSURLRequest *request = [client multipartFormRequestWithMethod : @"POST" path :urlString parameters :dics constructingBodyWithBlock :^(id formData) {
        //得到需要上传的数据
        NSData *data=UIImageJPEGRepresentation(savedImage, 0.2);//();
        //上传时使用当前的系统事件作为文件名
        NSDateFormatter *formatter = [[ NSDateFormatter alloc ] init ];
        formatter. dateFormat = @"yyyyMMddHHmmss" ;
        NSString *str = [formatter stringFromDate :[ NSDate date ]];
        NSString *fileName = [ NSString stringWithFormat : @"%@.jpg" , str];
        //服务器上传文件的字段和类型
       [formData appendPartWithFileData :data name : @"file" fileName :fileName mimeType : @"image/jpg/file" ];
    }];
    // 3. operation包装的urlconnetion
     AFHTTPRequestOperation *op = [[ AFHTTPRequestOperation alloc ] initWithRequest :request];
     [op setCompletionBlockWithSuccess :^( AFHTTPRequestOperation *operation, id responseObject) {
     NSLog ( @"上传完成" );
         [self GotoUserListView];
    } failure :^( AFHTTPRequestOperation *operation, NSError *error) {
        NSLog ( @"上传失败->%@" , error);
    }];
    //执行
    [client. operationQueue addOperation :op];

    
}
-(void)GotoUserListView
{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"UserInfoStoryBoard"];
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
@end
