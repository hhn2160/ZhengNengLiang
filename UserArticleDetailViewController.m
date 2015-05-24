//
//  UserArticleDetailViewController.m
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-18.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import "UserArticleDetailViewController.h"
#import "UIImageView+WebCache.h"
#import "ZNLLRestaurantAndGiftNetworkCenter.h"
#import "UserPingLunViewCell.h"
#import "UserPinglunModel.h"
#import "MBProgressHUD.h"

@interface UserArticleDetailViewController ()
@property (nonatomic,strong) NSMutableArray *pinglunList;
@property (nonatomic,strong) NSString *userId;
@end

@implementation UserArticleDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    NSLog([NSString stringWithFormat:@"%lu", (unsigned long) self.articleId]);
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
    [self ShowUserArticleDetail];
    //[self ShowPingLun];
}

-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    [self ShowPingLun];
}
-(void)ShowUserArticleDetail
{
    NSString *imagePath=self.articleImageUrl;
    NSString *userImagePath=self.userImageUrl;
    [self.articleImage setFrame:CGRectMake(0,0,375,300)];
    [self.articleUserNameLabel setFrame:CGRectMake(100,305,250,40)];
    [self.articleContent setFrame:CGRectMake(100,345,250,40)];
    [self.userImage sd_setImageWithURL:[NSURL URLWithString:userImagePath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [self.articleImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    self.articleContent.text=self.articleContentStr;
    self.articleUserNameLabel.text=self.articleUserName;
    self.articleTime.text=self.articleTimeStr;
    CALayer * layer = [self.userImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
    [layer setMasksToBounds:YES];
    [layer setBorderWidth:1];
    [layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

-(void)ShowPingLun
{
    _currentpage=1;
    self.pinglunList = [[NSMutableArray alloc]init];
    [self getPingLunList];
}
- (void)getPingLunList{
    NSDictionary *dict = @{
                           @"pid":([NSString stringWithFormat:@"%d", _currentpage]),
                           @"aid":([NSString stringWithFormat:@"%d", self.articleId]),
                           @"action":(@"getcomment")
                           };
    [NETWORK requestGetUserPingLunByPageIdWithParmeter:dict completionHandler:^(id response, NSError *error) {
        //[self endLoading];
        
        //        if (error) {
        //            [self finishReloadingData];
        //            [self showMessagePrompt:@"网络无法连接"];
        //            return ;
        //        }
        NSArray *resposeArray = response[@"TableInfo"];
                if (resposeArray.count == 0) {
                    //[self showMessagePrompt:@"暂时无订单"];
                    self.pinglunTable.hidden=YES;
                }
        else
        {
            self.pinglunTable.hidden=NO;
            [resposeArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                UserPinglunModel *item = [[UserPinglunModel alloc]init];
                item.pinglunUserImage = obj[@"User_Image"];
                item.pinglunUserName = obj[@"User_Name"];
                item.pinglunContent=obj[@"Comment_Content"];
                item.pinglunTime=obj[@"Comment_AddTime"];
                [self.pinglunList addObject:item];
            }];
            NSLog([NSString stringWithFormat:@"%d", self.pinglunList.count]);
            [self.pinglunTable reloadData];
         }
        //      [self finishReloadingData];
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.pinglunList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserPingLunViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"UserPingLunCell"  forIndexPath:indexPath];
    UserPinglunModel *dict =self.pinglunList[indexPath.row];
    cell.pinglunUserContent.text=dict.pinglunContent;
    cell.pinglunUserName.text=dict.pinglunUserName;
    NSString *imagePath=dict.pinglunUserImage;
    [cell.pinglunUserContent setFrame:CGRectMake(100,36,280,30)];
    [cell.pinglunUserName setFrame:CGRectMake(100,8,280,20)];
    [cell.pinglunUserImage sd_setImageWithURL:[NSURL URLWithString:imagePath] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    cell.pinglunTime.text=dict.pinglunTime;
    CALayer * layer = [cell.pinglunUserImage layer];
    [layer setMasksToBounds:YES];
    [layer setCornerRadius:6.0];
    [layer setMasksToBounds:YES];
    [layer setBorderWidth:1];
    [layer setBorderColor:[[UIColor grayColor] CGColor]];
    
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
    UIEdgeInsets edgeInset = self.pinglunTable.separatorInset;
    self.pinglunTable.separatorInset = UIEdgeInsetsMake(edgeInset.top, 0, edgeInset.bottom, 0);//修改分隔线长度
//    self.pinglunTable.separatorStyle = UITableViewCellSelectionStyleNone;
        self.pinglunTable.separatorStyle=UITableViewCellSeparatorStyleSingleLine;
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"UserPingLunCell";
    UserPingLunViewCell *cell = (UserPingLunViewCell *)[[UserPingLunViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    UserPinglunModel *dict =self.pinglunList[indexPath.row];
    return 83;
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (([self.pinglunList count] == indexPath.row+1 && _loadingView.hidden == YES) ) {
//        
//        //NSLog(@"load data...");
//        _currentpage++;
//        _loadingView.hidden=NO;
//        [self getImageList];
//    }
//    else
//    {
//        _loadingView.hidden=YES;
//    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)textFieldDidBeginEditing:(UITextField *)textField{
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat screenwidth = size.width;
    CGFloat screenHeight = size.height;
    [self.pinglungTextView setFrame:CGRectMake(0,screenHeight-326,screenwidth,50)];
    [self.pinglunText setFrame:CGRectMake(50,350,260,30)];
//    [self.view bringSubviewToFront:self.pinglungTextView];
    [self.view addSubview:self.pinglungTextView];
    [self.view addSubview:self.pinglunText];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [self.pinglungTextView addSubview:self.pinglunText];
    self.pinglunText.hidden=false;
    [textField resignFirstResponder];
    
    return YES;
}


-(void)textFieldDidEndEditing:(UITextField *)textField{
    //输入框编辑完成以后，当键盘即将消失时，将视图恢复到原始状态
    CGRect rect = [[UIScreen mainScreen] bounds];
    CGSize size = rect.size;
    CGFloat screenwidth = size.width;
    CGFloat screenHeight = size.height;
    [self.pinglungTextView setFrame:CGRectMake(0,screenHeight-50,screenwidth,50)];
    [self.pinglunText setFrame:CGRectMake(50,screenHeight-40,260,30)];
    [self.view addSubview:self.pinglunText];
    if ([self.pinglunText.text isEqualToString:@""]) {
    }
    else
    {
        [self addPinglunContnet];
        self.pinglunText.text=@"";
    }
}
-(void)addPinglunContnet
{
    NSString *pingluncontent=self.pinglunText.text;
    NSInteger *aid=self.articleId;
    NSString *uid=self.userId;
    MBProgressHUD *hud=[MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.mode=MBProgressHUDAnimationFade;
    hud.labelText=@"提交中…";
    [NETWORK addUserPingLunWithParameters:@{
                                          @"uid":(uid),
                                          @"commentcontent":(pingluncontent),
                                          @"articleid":([NSString stringWithFormat:@"%d", aid]),
                                          @"commentid":(@"0"),
                                          @"action":@"addcomment"
                                          } completionHandler:^(id response, NSError *error) {
                                              //                                            [self endLoading];
                                              [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
                                              if (error) {
                                                  hud.mode=MBProgressHUDModeText;
                                                  hud.labelText=@"出错啦！稍后再试";
                                                  NSLog(error);
                                                  return ;
                                              }
                                              if ([response[@"IsSucess"] isEqualToString:@"ok"]) {
                                                  hud.mode=MBProgressHUDModeText;
                                                  hud.labelText=@"评论成功";
                                                  [self ShowPingLun];
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
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
