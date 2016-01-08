//
//  ViewController.m
//  QuizApp
//
//  Created by 松下泰久 on 2015/12/16.
//  Copyright © 2015年 yasuhisa.matsushita. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController (){
    UIButton *seikai_button;
    UIButton *fuseikai_button;
    UILabel *resultLabel;
    
    NSInteger quiz_num;
    NSInteger button_status;
    NSInteger score;
    //viewコントロールをまたぐ場合は受け渡しが必要
    //バース　mBaaS nifty 無料で使える。セキリティ的にも大丈夫
}
@property (weak, nonatomic) IBOutlet UITextView *textBox;//control+ドラッグで関連付ける
@property (strong, nonatomic) AVAudioPlayer *player;

@end

@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    //初期化処理
    [self seikai];
    [self fuseikai];
    [self resultLabel];
    seikai_button.hidden = YES;
    fuseikai_button.hidden = YES;
    resultLabel.hidden = YES;

    quiz_num = 0;
    score = 0;
    
    [self quiz];
}

//////////////* 問題記述 */////////////////
-(void) quiz {
    switch (quiz_num) {
        case 0:
            self.textView.text = @"ドラえもんは、体内にある原子炉のエネルギーで動いている。";
            break;
        case 1:
            self.textView.text = @"哺乳類のうち、口で呼吸するのは人間だけである。";
            break;
        case 2:
            self.textView.text = @"日本には世界中で飼われているペンギンの4分の1がいる。";
            break;
        case 3:
            self.textView.text = @"ジャイアントパンダの日本語名（和名）は、シロクログマである。";
            break;
        case 4:
            self.textView.text = @"西郷隆盛は本名ではなく、実は父親の名前である。";
            break;

    }
}
//////////////////////////////////////////

//////////////* 答え合わせ *////////////////
-(void) answer {
    switch (quiz_num) {
        case 0:
            if(button_status == 1){
                seikai_button.hidden = NO;
                score++;
                [self crrect];
            }else if(button_status == 2){
                fuseikai_button.hidden = NO;
                [self notCrrect];
            }
            button_status = 0;
            break;
        case 1:
            if(button_status == 1){
                seikai_button.hidden = NO;
                score++;
                [self crrect];
            }else if(button_status == 2){
                fuseikai_button.hidden = NO;
                [self notCrrect];
            }
            button_status = 0;
            break;
        case 2:
            if(button_status == 1){
                seikai_button.hidden = NO;
                score++;
                [self crrect];
            }else if(button_status == 2){
                fuseikai_button.hidden = NO;
                [self notCrrect];
            }
            button_status = 0;
            break;
        case 3:
            if(button_status == 1){
                seikai_button.hidden = NO;
                score++;
                [self crrect];
            }else if(button_status == 2){
                fuseikai_button.hidden = NO;
                [self notCrrect];
            }
            button_status = 0;
            break;
        case 4:
            if(button_status == 1){
                seikai_button.hidden = NO;
                score++;
                [self crrect];
            }else if(button_status == 2){
                fuseikai_button.hidden = NO;
                [self notCrrect];
            }
            button_status = 0;
            [self results];
            break;
            
    }
}
//////////////////////////////////////////

///////////* 正解不正解出力 *///////////////
//正解ボタンの設置 //重なった場合どうするの？
-(void) seikai {
    seikai_button = [UIButton buttonWithType:UIButtonTypeCustom];
    seikai_button.frame = CGRectMake(0, 0, 250, 200);
    seikai_button.center = CGPointMake(160, 250);
    [seikai_button setImage:[UIImage imageNamed:@"seikai.png"] forState:UIControlStateNormal];
    [seikai_button setImage:[UIImage imageNamed:@"seikai_on.png"] forState:UIControlStateHighlighted];
    [seikai_button addTarget:self action:@selector(seikai_on:) forControlEvents:UIControlEventTouchUpInside];
    seikai_button.translatesAutoresizingMaskIntoConstraints = NO;//内部的に勝手にレイアウトを設定していたのを削除した
    [self.view addSubview:seikai_button];
    //addSubviewの後にAutoLayoutの情報を出す
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:seikai_button
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:seikai_button
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [seikai_button addConstraint:[NSLayoutConstraint constraintWithItem:seikai_button
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:250]];
    
    [seikai_button addConstraint:[NSLayoutConstraint constraintWithItem:seikai_button
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:200]];
}
//不正解ボタンの設置
-(void) fuseikai{
    fuseikai_button = [UIButton buttonWithType:UIButtonTypeCustom];
    fuseikai_button.frame = CGRectMake(0, 0, 250, 200);
    fuseikai_button.center = CGPointMake(160, 250);
    [fuseikai_button setImage:[UIImage imageNamed:@"fuseikai.png"] forState:UIControlStateNormal];
    [fuseikai_button setImage:[UIImage imageNamed:@"fuseikai_on.png"] forState:UIControlStateHighlighted];
    [fuseikai_button addTarget:self action:@selector(fuseikai_on:) forControlEvents:UIControlEventTouchUpInside];
    fuseikai_button.translatesAutoresizingMaskIntoConstraints = NO;//内部的に勝手にAutolayoutを設定していたのを削除した
    [self.view addSubview:fuseikai_button];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fuseikai_button
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:fuseikai_button
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [fuseikai_button addConstraint:[NSLayoutConstraint constraintWithItem:fuseikai_button
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:250]];
    
    [fuseikai_button addConstraint:[NSLayoutConstraint constraintWithItem:fuseikai_button
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:200]];
    
}

//正解ボタンを押す
-(void) seikai_on:(id)sender {
    seikai_button.hidden = YES;
    quiz_num++;
    [self quiz];
}

//不正解ボタンを押す
-(void) fuseikai_on:(id)sender {
    fuseikai_button.hidden = YES;
    quiz_num++;
    [self quiz];
}
//////////////////////////////////////////

/////////////* ボタン判定 */////////////////UIkitでhiddenの設定をどうやって実装するのか？？
-(IBAction) maru_button:(id)sender{
    button_status = 1;
    [self answer];//結果を見に行く
}
-(IBAction) batsu_button:(id) sender{
    button_status = 2;
    [self answer];//結果を見に行く
}
//////////////////////////////////////////

//////////////* 結果表示 */////////////////
-(void) resultLabel {
    resultLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 300, 280)];
    resultLabel.center = CGPointMake(160, 230);
    resultLabel.font = [UIFont fontWithName:@"HiraKakuProN-W6" size:35];
    resultLabel.text = @"Hello world!!";
    resultLabel.textColor = [UIColor whiteColor];
    resultLabel.backgroundColor = [UIColor orangeColor];
    resultLabel.textAlignment = NSTextAlignmentCenter;
    resultLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:resultLabel];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:resultLabel
                                                          attribute:NSLayoutAttributeCenterX
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterX
                                                         multiplier:1
                                                           constant:0]];
    
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:resultLabel
                                                          attribute:NSLayoutAttributeCenterY
                                                          relatedBy:NSLayoutRelationEqual
                                                             toItem:self.view
                                                          attribute:NSLayoutAttributeCenterY
                                                         multiplier:1
                                                           constant:0]];
    
    [resultLabel addConstraint:[NSLayoutConstraint constraintWithItem:resultLabel
                                                              attribute:NSLayoutAttributeWidth
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeWidth
                                                             multiplier:1
                                                               constant:300]];
    
    [resultLabel addConstraint:[NSLayoutConstraint constraintWithItem:resultLabel
                                                              attribute:NSLayoutAttributeHeight
                                                              relatedBy:NSLayoutRelationEqual
                                                                 toItem:nil
                                                              attribute:NSLayoutAttributeHeight
                                                             multiplier:1
                                                               constant:280]];
}
//////////////////////////////////////////

//////////////* 結果判定 */////////////////
-(void) results {
    switch (score) {
        case 0:
            resultLabel.text = @"0点です。残念";
            resultLabel.hidden = NO;
            break;
        case 1:
            resultLabel.text = @"1点です。残念";
            resultLabel.hidden = NO;
            break;

        case 2:
            resultLabel.text = @"2点ですね。";
            resultLabel.hidden = NO;
            break;
            
        case 3:
            resultLabel.text = @"3点です。普通";
            resultLabel.hidden = NO;
            break;
        case 4:
            resultLabel.text = @"4点です。すごい！";
            resultLabel.hidden = NO;
            break;
        case 5:
            resultLabel.text = @"5点です。満点！";
            resultLabel.hidden = NO;
            break;
    }
}
//////////////////////////////////////////

///////////////* 音の処理 *////////////////
-(void) crrect{
    NSString *soundFileName = [NSString stringWithFormat:@"crrect"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:soundFileName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //エラー処理
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [self.player play];
}

-(void) notCrrect {
    NSString *soundFileName = [NSString stringWithFormat:@"not_crrect"];
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:soundFileName ofType:@"mp3"];
    NSURL *url = [NSURL fileURLWithPath:path];
    //エラー処理
    NSError *error = nil;
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:&error];
    [self.player play];
}

//////////////////////////////////////////

/////////////* リセット処理 *///////////////
-(IBAction)restart_button:(id)sender {
    seikai_button.hidden = YES;
    fuseikai_button.hidden = YES;
    resultLabel.hidden = YES;
    quiz_num = 0;
    score = 0;
    [self quiz];
}

//////////////////////////////////////////

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
