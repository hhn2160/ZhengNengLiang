//
//  BaseViewController.h
//  ZhengNengLiang
//
//  Created by henan huang on 15-4-15.
//  Copyright (c) 2015年 hhn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController
{

}

+ (void)timerFireMethod:(NSTimer*)theTimer;
+ (void)showAlert:(NSString *) _message;

@end
