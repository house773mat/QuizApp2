//
//  ViewController.h
//  QuizApp
//
//  Created by 松下泰久 on 2015/12/16.
//  Copyright © 2015年 yasuhisa.matsushita. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
-(IBAction) maru_button:(id)sender;
-(IBAction) batsu_button:(id)sender;
-(IBAction) restart_button:(id)sender;

@property (nonatomic, weak) IBOutlet UITextView *textView;

@end

