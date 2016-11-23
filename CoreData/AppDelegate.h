//
//  AppDelegate.h
//  CoreData
//
//  Created by Erin Luu on 2016-11-23.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

