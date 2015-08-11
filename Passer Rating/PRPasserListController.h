//
//  PRPasserListController.h
//  Passer Rating
//
//  Created by Xcode User on 8/5/13.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CoreData/CoreData.h>

@interface PRPasserListController : UITableViewController <NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;

@end
