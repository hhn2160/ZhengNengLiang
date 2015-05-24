//
//  RegInfoViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-4.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "RegInfoViewController.h"
#import "MBProgressHUD.h"
#import "AFNetworking.h"
#import <CommonCrypto/CommonDigest.h>

@interface RegInfoViewController ()

@end

@implementation RegInfoViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(self.userPhone);
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

- (IBAction)AddUserImage:(id)sender {
    UIActionSheet *sheet;
    sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
    sheet.tag = 255;
    [sheet showInView:self.view];
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        NSUInteger sourceType = 0;
        
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            switch (buttonIndex) {
                case 0:
                    return;
                case 1:
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
                case 2:
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        imagePickerController.delegate= self;
        imagePickerController.allowsEditing = YES;
        imagePickerController.sourceType = sourceType;
        [self presentViewController:imagePickerController animated:YES completion:^{}];
        //        [imagePickerController release];
        
    }
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    //    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    /* 此处info 有六个值
     * UIImagePickerControllerMediaType; // an NSString UTTypeImage)
     * UIImagePickerControllerOriginalImage;  // a UIImage 原始图片
     * UIImagePickerControllerEditedImage;    // a UIImage 裁剪后图片
     * UIImagePickerControllerCropRect;       // an NSValue (CGRect)
     * UIImagePickerControllerMediaURL;       // an NSURL
     * UIImagePickerControllerReferenceURL    // an NSURL that references an asset in the AssetsLibrary framework
     * UIImagePickerControllerMediaMetadata    // an NSDictionary containing metadata from a captured photo
     */
    UIImage* editimg = [info objectForKey:UIImagePickerControllerEditedImage];
    // 保存图片至本地，方法见下文
    [self saveImage:editimg withName:@"currentUserImage.png"];
    
}
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.3);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    [self ShowUserImageView];
}
-(void)ShowUserImageView
{
//    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"CameraStoryBoard"];
//    [self.navigationController pushViewController:registerViewController animated:YES];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentUserImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //        isFullScreen = NO;
    [self.userInfoImage setImage:savedImage];
    self.userInfoImage.tag = 100;
    self.addImageButton.hidden=true;
}
- (IBAction)addUserInfo:(id)sender {
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"提交中…";
    NSString *userName=self.userName.text;
    NSString *userPwd=[self md5:self.userPwd.text];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"currentUserImage.png"];
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    //上传其他所需参数
    NSString *userphone=self.userPhoneStr;
    NSString *userid=@"1";
    NSString *action=@"addinfo";
    //上传请求POST
    AFHTTPClient *client=[ AFHTTPClient clientWithBaseURL :[ NSURL URLWithString : @"" ]];
//    NSString *urlString=[NSString stringWithFormat:@"http://192.168.1.102:8000/control/user.aspx"];
    NSString *urlString=[NSString stringWithFormat:@"http://znl.jingerge.com/control/user.aspx"];
    NSDictionary *dic=[[ NSDictionary alloc ] initWithObjectsAndKeys :userphone, @"phone" ,userName,@"uname",userPwd,@"upwd",action,@"action",userid,@"uid", nil ];
    NSURLRequest *request = [client multipartFormRequestWithMethod : @"POST" path :urlString parameters :dic constructingBodyWithBlock :^( id < AFMultipartFormData > formData) {
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
        id response_data = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        handler(response_data,nil);
        if ([response_data[@"IsSucess"] isEqualToString:@"ok"]) {
            NSString *uName=response_data[@"username"];
            NSString *uImage=response_data[@"userimage"];
            NSString *uId=response_data[@"userid"];
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        //登陆成功后把用户名和密码存储到UserDefault
        [userDefaults setObject:uName forKey:@"name"];
        [userDefaults setObject:uImage forKey:@"image"];
        [userDefaults setObject:uId forKey:@"id"];
        [userDefaults synchronize];
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self GotoUserInfoView];
        }
        else
        {
            hud.mode=MBProgressHUDModeText;
            hud.labelText=@"提交失败";
        }
        
        
    } failure :^( AFHTTPRequestOperation *operation, NSError *error) {
        NSLog ( @"上传失败->%@" , error);
    }];
    //执行
    [client. operationQueue addOperation :op];
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
