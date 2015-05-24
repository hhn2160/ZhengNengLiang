//
//  MainDetailViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-3-21.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainDetailViewController : UIViewController<UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *MainDetailView;
@property (nonatomic,assign) NSUInteger *newsId;
@property (strong, nonatomic) NSString *keyId;
@end
