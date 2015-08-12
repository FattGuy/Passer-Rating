//
//  PRGameListController.h
//  Passer Rating
//
//  Created by Xcode User on 8/5/13.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRPasser;

@interface PRGameListController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) id <NSObject> detailItem;

@end
