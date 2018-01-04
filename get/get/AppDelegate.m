//
//  AppDelegate.m
//  get
//
//  Created by yishu on 2018/1/4.
//  Copyright © 2018年 TL. All rights reserved.
//

#define PATH_OF_DOCUMENT    [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject]
#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()<UIDocumentInteractionControllerDelegate>

@property (nonatomic ,strong)UIDocumentInteractionController *documentController;

@end

@implementation AppDelegate

// 主目录
- (NSString *)mainPathStr{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *filePath = [NSString stringWithFormat:@"%@/TLVIDEO",PATH_OF_DOCUMENT];
    if ([fileManager fileExistsAtPath:filePath]) {
        return filePath;
    }else{
        BOOL res = [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (res) {
            return filePath;
        }else{
            return [self mainPathStr];
        }
    }
}
- (void)preview:(NSURL *)pathUrl{
    if (!pathUrl) return;
    
    NSData *data = [NSData dataWithContentsOfURL:pathUrl];
    NSArray *nameArray = [[pathUrl description] componentsSeparatedByString:@"/"];
    
    NSFileManager  *fileManager = [NSFileManager defaultManager];
    NSString *cache = [self mainPathStr];
    NSString *filePath  = [cache stringByAppendingPathComponent:[nameArray lastObject]];
    if (![fileManager fileExistsAtPath:filePath]) {
        [data writeToFile:filePath atomically:YES];
    }
    
    NSURL *fileURL = [NSURL fileURLWithPath:filePath];
    //创建实例
    self.documentController = [UIDocumentInteractionController interactionControllerWithURL:fileURL];
    self.documentController.delegate = self;
    BOOL canOk = [self.documentController presentPreviewAnimated:YES];
    
    if (!canOk) {
        [fileManager removeItemAtPath:filePath error:nil];
    }
}
- (UIViewController *)documentInteractionControllerViewControllerForPreview:(UIDocumentInteractionController *)controller{
    return self.window.rootViewController;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    if (launchOptions) {
        
        [self preview:launchOptions[UIApplicationLaunchOptionsURLKey]];
    }
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = [ViewController new];
    [self.window makeKeyAndVisible];
    return YES;
}
- (BOOL)application:(UIApplication *)application openURL:(nonnull NSURL *)url options:(nonnull NSDictionary<NSString *,id> *)options {
    if (options) {
        [self preview:url];
    }
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
