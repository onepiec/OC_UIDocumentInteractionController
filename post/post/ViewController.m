//
//  ViewController.m
//  post
//
//  Created by yishu on 2018/1/4.
//  Copyright © 2018年 TL. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic ,strong)UIDocumentInteractionController *documentController;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIButton *btn0 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn0.frame = CGRectMake(50, 100, 50, 50);
    btn0.backgroundColor = [UIColor redColor];
    [btn0 addTarget:self action:@selector(click0) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn0];
    
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(150, 100, 50, 50);
    btn1.backgroundColor = [UIColor redColor];
    [btn1 addTarget:self action:@selector(click1) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
}

- (void)click0{
    
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"tl_text" withExtension:@"txt"]];
    self.documentController.delegate = self;
    
    // 预览
    //    [self.documentController presentPreviewAnimated:YES];
    
    // 不展示可选操作
    //    [self.documentController presentOpenInMenuFromRect:self.view.bounds inView:self.view animated:YES];
    
    // 展示可选操作
    [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}
- (void)click1{
    
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:[[NSBundle mainBundle] URLForResource:@"tl_movie" withExtension:@"mp4"]];
    self.documentController.delegate = self;
    [self.documentController presentOptionsMenuFromRect:self.view.bounds inView:self.view animated:YES];
}

- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
