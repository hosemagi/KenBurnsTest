//
//  CSAppDelegate.h
//  KenBurns
//
//  Created by Preston Lewis on 4/22/13.
//  Copyright (c) 2013 Preston Lewis. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CSAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
