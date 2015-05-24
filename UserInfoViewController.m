//
//  UserInfoViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "UserInfoViewController.h"
#import "AFNetworking.h"
#import "UserArticleModel.h"
#import "UserArticleTableViewCell.h"
#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import "UIImageView+WebCache.h"
#import "UserArticleDetailViewController.h"
#import "MBProgressHUD.h"

@interface UserInfoViewController ()
@property (nonatomic,strong) NSMutableArray *imageList;
@property (nonatomic,strong) NSString *userId;
@end

@implementation UserInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefault = [NSUserDefaults standardUserDefaults];
    NSString *name = [userDefault objectForKey:@"name"];
    NSString *uid = [userDefault objectForKey:@"id"];
    //如果用户未登陆则把根视图控制器改变成登陆视图控制器
    if (name == nil)
    {
        
    }
    else
    {
        self.userId=uid;
    }
    _currentpage=1;
    self.imageList = [[NSMutableArray alloc]init];
    [self getImageList];
    UIRefreshControl *rc = [[UIRefreshControl alloc] init];
    rc.attributedTitle = [[NSAttributedString alloc]initWithString:@"下拉刷新"];
    [rc addTarget:self action: @selector(refreshTableView:)forControlEvents:UIControlEventValueChanged ];
    [self.UserArticleTable addSubview:rc];
    self.refreshControl=rc;
}
-(void) refreshTableView:(UIRefreshControl *)controller
{
    if(self.refreshControl.refreshing)
    {
        self.refreshControl.attributedTitle=[[NSAttributedString alloc] initWithString:@"加载中…"];
        [self getImageList];
        [controller endRefreshing];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
//    _currentpage=1;
//    self.imageList = [[NSMutableArray alloc]init];
//    [self getImageList];
    [self.navigationItem.backBarButtonItem setTitle:@""];
    [self.navigationController.navigationItem setHidesBackButton:YES];
    [self.navigationItem setHidesBackButton:YES];
    [self.navigationController.navigationBar.backItem setHidesBackButton:YES];
    [self.navigationController setNavigationBarHidden:NO animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)getImageList{
    NSDictionary *dict = @{
                           @"pid":([NSString stringWithFormat:@"%lu", (unsigned long)_currentpage]),
                           @"action":(@"userarticlelist")
                           };
    [NETWORK requestGetArticleByPageIdWithParmeter:dict completionHandler:^(id response, NSError *error) {
        //[self endLoading];
        
        //        if (error) {
        //            [self finishReloadingData];
        //            [self showMessagePrompt:@"网络无法连接"];
        //            return ;
        //        }
        NSArray *resposeArray = response[@"TableInfo"];
        //        if (resposeArray.count == 0) {
        //            [self showMessagePrompt:@"暂时无订单"];
        //        }
//        NSLog([NSString stringWithFormat:@"%d", resposeArray.count]);
        [resposeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            UserArticleModel *item = [[UserArticleModel alloc]init];
            item.articleTitle = obj[@"UserArticle_Content"];
            item.articleImageUrl = obj[@"UserArticle_Image"];
            item.imageHeight=[obj[@"UserArticle_ImageHeight"] integerValue];
            item.imageWidth=[obj[@"UserArticle_ImageWidth"] integerValue];
            item.userName = obj[@"User_Name"];
            item.commonCount=[obj[@"UserArticle_CommCount"] integerValue];
            item.likeCount=[obj[@"UserArticle_PraiseCount"] integerValue];
            item.userArticleId=[obj[@"UserArticle_Id"] integerValue];
            item.userImage=obj[@"User_Image"];
            item.userArticleTimeStr=obj[@"UserArticle_Showtime"];
            [self.imageList addObject:item];
        }];
        [self.UserArticleTable reloadData];
        //      [self finishReloadingData];
    }];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.imageList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserArticleTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserArticleCell"  forIndexPath:indexPath];
    UserArticleModel *dict =self.imageList[indexPath.row];
    cell.UserArticleTitle.text=dict.articleTitle;
    cell.userName.text=dict.userName;
    cell.userPingLun.text=[NSString stringWithFormat:@"%lu", (unsigned long)dict.commonCount];
    cell.userShouCang.text=[NSString stringWithFormat:@"%lu", (unsigned long)dict.likeCount];
;
    NSString *imagePath=dict.articleImageUrl;
//    NSLog(@"kaishiuser");
    //NSLog(dict.articleTitle);
    NSUInteger realwidth=dict.imageWidth;
    NSUInteger realheight=dict.imageHeight;
    NSUInteger showheight=340*realheight/realwidth;
    [cell.UserArticleImage setFrame:CGRectMake(18,0,340,showheight)];
    [cell.UserArticleTitle setFrame:CGRectMake(18,showheight-40,340,40)];
    [cell.userName setFrame:CGRectMake(18,showheight,340,40)];
    [cell.likeButton setFrame:CGRectMake(80,showheight,340,40)];
    [cell.userShouCang setFrame:CGRectMake(260,showheight,340,40)];
    [cell.pinglunButton setFrame:CGRectMake(140,showheight,340,40)];
    [cell.userPingLun setFrame:CGRectMake(322,showheight,340,40)];
    [cell.UserArticleImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
//    //设置图片阴影
    [[cell.UserArticleImage layer] setShadowOffset:CGSizeMake(1, 1)]; // 阴影的范围
    [[cell.UserArticleImage layer] setShadowRadius:2];                // 阴影扩散的范围控制
    [[cell.UserArticleImage layer] setShadowOpacity:1];               // 阴影透明度
    [[cell.UserArticleImage layer] setShadowColor:[UIColor grayColor].CGColor]; // 阴影的颜色
//
//    //兼容不同屏幕
//    CGRect rect = [[UIScreen mainScreen] bounds];
//    CGSize size = rect.size;
//    CGFloat screenwidth = size.width;
    //    if(screenwidth==320.f)
    //    {
    //        [cell.mainTitleCell setFrame:CGRectMake(10,1,200,90)];
    //        [cell.mainTitleCell setFont:[UIFont systemFontOfSize:18.0f]];
    //        [cell.mainImageCell setFrame:CGRectMake(215,15,90,65)];
    //        [cell setFrame:CGRectMake(0, 0, 300, 110)];
    //    }
    //
    UIEdgeInsets edgeInset = self.UserArticleTable.separatorInset;
    self.UserArticleTable.separatorInset = UIEdgeInsetsMake(edgeInset.top, 0, edgeInset.bottom, 0);//修改分隔线长度
    self.UserArticleTable.separatorStyle = UITableViewCellSelectionStyleNone;
    //    self.MainTableView.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UserArticleCell";
    UserArticleTableViewCell *cell = (UserArticleTableViewCell *)[[UserArticleTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    UserArticleModel *dict =self.imageList[indexPath.row];
    NSUInteger realwidth=dict.imageWidth;
    NSUInteger realheight=dict.imageHeight;
    NSUInteger showheight=340*realheight/realwidth;
    return cell.frame.size.height+showheight;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (([self.imageList count] == indexPath.row+1 && _loadingView.hidden == YES) ) {
        
        //NSLog(@"load data...");
        _currentpage++;
        _loadingView.hidden=NO;
        [self getImageList];
    }
    else
    {
        _loadingView.hidden=YES;
    }
}
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"ShowUserArticleDetail"]) {
        UserArticleDetailViewController *newsDetail = (UserArticleDetailViewController*)segue.destinationViewController;
        NSIndexPath *indexPath = [self.UserArticleTable indexPathForCell:(UITableViewCell *)sender];
        UserArticleModel *dict =self.imageList[indexPath.row];
        
        newsDetail.articleId= dict.userArticleId;
        newsDetail.articleImageUrl=dict.articleImageUrl;
        newsDetail.articleContentStr=dict.articleTitle;
        newsDetail.userImageUrl=dict.userImage;
        newsDetail.articleUserName=dict.userName;
        newsDetail.articleTimeStr=dict.userArticleTimeStr;
        [segue.destinationViewController setHidesBottomBarWhenPushed:YES];
        //self.hidesBottomBarWhenPushed = YES;
    }
}


-(IBAction)ShowCameraView:(id)sender {
//    NSLog(@"xiangji");
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
        UIActionSheet *sheet;
        sheet  = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"拍照",@"从相册选择", nil];
        sheet.tag = 255;
        [sheet showInView:self.view];
    }
}
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
//        NSUInteger sourceType = 0;
        UIImagePickerControllerSourceType sourceType;
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
        imagePickerController.delegate = self;
                imagePickerController.sourceType = sourceType;
        imagePickerController.allowsEditing = YES;
        if (buttonIndex == 1)
        {
                imagePickerController.cameraViewTransform=CGAffineTransformScale(imagePickerController.cameraViewTransform, 1.0, 0.6);
        }
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
    [self saveImage:editimg withName:@"currentImage.png"];

}
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{

    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.3);
    // 获取沙盒目录
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    // 将图片写入文件
    [imageData writeToFile:fullPath atomically:NO];
    [self ShowAddArticleView];
}
-(void)ShowAddArticleView
{
//        UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"CameraStoryBoard"];
//        registerViewController.modalTransitionStyle=UIModalTransitionStyleCoverVertical;
//        [self presentViewController:registerViewController animated:YES completion:^{NSLog(@"present modal view");}];
    UIStoryboard *mainStoryboard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *registerViewController=[mainStoryboard instantiateViewControllerWithIdentifier:@"CameraStoryBoard"];
    [self.navigationController pushViewController:registerViewController animated:YES];
}
- (IBAction)LikeArticle:(id)sender {
    UITableViewCell * cell = (UITableViewCell *)[[sender superview] superview];
    NSIndexPath *indexPath = [self.self.UserArticleTable indexPathForCell:cell];
//    NSIndexPath *indexPath = [self.UserArticleTable indexPathForCell:(UITableViewCell *)sender];
    UserArticleModel *dict =self.imageList[indexPath.row];
    NSInteger aid=dict.userArticleId;
    NSString *uid=self.userId;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [NETWORK addUserLikeWithParameters:@{
                                            @"uid":(uid),
                                            @"articleid":([NSString stringWithFormat:@"%d", aid]),
                                            @"action":@"addlike"
                                            } completionHandler:^(id response, NSError *error) {
                                                //                                           [self endLoading];
                                                [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                                if (error) {
                                                    hud.mode=MBProgressHUDModeText;
                                                    hud.labelText=@"出错啦！稍后再试";
                                                    NSLog(error);
                                                    return ;
                                                }
                                                if ([response[@"IsSucess"] isEqualToString:@"ok"]) {
//                                                    hud.mode=MBProgressHUDModeText;
//                                                    hud.labelText=@"评论成功";
//                                                    [self ShowPingLun];
                                                    return;
                                                }
                                                else if([response[@"IsSucess"] isEqualToString:@"error"])
                                                {
                                                    hud.mode=MBProgressHUDModeText;
                                                    hud.labelText=@"系统繁忙，稍后重试";
                                                    return;
                                                }
                                                
                                            }];
    

}
@end
