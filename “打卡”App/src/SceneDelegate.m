//
//  SceneDelegate.m
//  test
//
//  Created by student3 on 2022/9/20.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import "SceneDelegate.h"
#import "ViewController.h"
#import "disVC.h"
#import "ClockinVC.h"
#import "mine.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options
             :(UISceneConnectionOptions *)connectionOptions {
    
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    
    UITabBarController *bar = [[UITabBarController alloc] init];
    self.window.rootViewController = bar;
    
    disVC *vc1 = [[disVC alloc]init];
    UINavigationController *c1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    c1.title = @"discover";
    c1.tabBarItem.selectedImage = [UIImage imageNamed:@"disicon.png"];
    c1.tabBarItem.image = [UIImage imageNamed:@"disicon.png"];
    c1.tabBarItem.title = @"discover";
    
    ClockinVC *vc2 = [[ClockinVC alloc] init];
    UINavigationController *c2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    c2.title = @"clockIn";
    c2.tabBarItem.selectedImage = [UIImage imageNamed:@"penicon.png"];
    c2.tabBarItem.image = [UIImage imageNamed:@"penicon.png"];
    c2.tabBarItem.title = @"clockIn";
    
    mineVC *vc3 = [[mineVC alloc] init];
    UINavigationController *c3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    c3.title = @"Mine";
    c3.tabBarItem.selectedImage = [UIImage imageNamed:@"mineicon.png"];
    c3.tabBarItem.image = [UIImage imageNamed:@"mineicon.png"];
    c3.tabBarItem.title = @"Mine";
    
    bar.viewControllers = @[c1, c2, c3];
    [self.window makeKeyAndVisible];
    NSLog(@"diudiudiu");
}


- (void)sceneDidDisconnect:(UIScene *)scene {
    // Called as the scene is being released by the system.
    // This occurs shortly after the scene enters the background, or when its session is discarded.
    // Release any resources associated with this scene that can be re-created the next time the scene connects.
    // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
}


- (void)sceneDidBecomeActive:(UIScene *)scene {
    // Called when the scene has moved from an inactive state to an active state.
    // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
}


- (void)sceneWillResignActive:(UIScene *)scene {
    // Called when the scene will move from an active state to an inactive state.
    // This may occur due to temporary interruptions (ex. an incoming phone call).
}


- (void)sceneWillEnterForeground:(UIScene *)scene {
    // Called as the scene transitions from the background to the foreground.
    // Use this method to undo the changes made on entering the background.
}


- (void)sceneDidEnterBackground:(UIScene *)scene {
    // Called as the scene transitions from the foreground to the background.
    // Use this method to save data, release shared resources, and store enough scene-specific state information
    // to restore the scene back to its current state.
}


@end
