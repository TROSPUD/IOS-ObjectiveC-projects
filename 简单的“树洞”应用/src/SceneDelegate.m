//
//  SceneDelegate.m
//  treehole
//
//  Created by student3 on 2022/10/13.
//  Copyright © 2022 ouphMy. All rights reserved.
//

#import "SceneDelegate.h"
#import "login.h"
#include "mine.h"
#include "dis.h"

@interface SceneDelegate ()

@end

@implementation SceneDelegate


- (void)scene:(UIScene *)scene willConnectToSession:(UISceneSession *)session options:(UISceneConnectionOptions *)connectionOptions {
    // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
    // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
    // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
    UIWindowScene *windowScene = (UIWindowScene *)scene;
    self.window = [[UIWindow alloc] initWithWindowScene:windowScene];
    self.window.frame = windowScene.coordinateSpace.bounds;
    self.window.rootViewController = [[LogIn alloc]init];
    self.window.backgroundColor = [UIColor whiteColor];
    
    /*UITabBarController *bar = [[UITabBarController alloc]init];
    self.window.rootViewController = bar;
    
    mine *mi = [[mine alloc]init];
    UINavigationController *m1 = [[UINavigationController alloc] initWithRootViewController:mi];
    m1.title = @"mine";
    m1.tabBarItem.selectedImage = [UIImage imageNamed:@"mineicon.png"];
    m1.tabBarItem.image = [UIImage imageNamed:@"mineicon.png"];
    m1.tabBarItem.title = @"mine";
    
    Dis *di = [[Dis alloc] init];
    UINavigationController *d1 = [[UINavigationController alloc] initWithRootViewController:di];
    d1.title = @"discover";
    d1.tabBarItem.selectedImage = [UIImage imageNamed:@"disicon.png"];
    d1.tabBarItem.image = [UIImage imageNamed:@"disicon.png"];
    d1.tabBarItem.title = @"discover";
    bar.viewControllers = @[m1,d1];*/
    

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
