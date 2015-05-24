//
//  MainViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UITableViewController
@property (strong, nonatomic) IBOutlet UITableView *MainTableView;
@property (weak, nonatomic) IBOutlet UIView *loadingView;

@property (nonatomic,assign) NSUInteger currentpage;
@end
