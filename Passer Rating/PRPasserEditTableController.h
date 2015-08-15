//
//  PRPasserEditTableController.h
//  Passer Rating
//
//  Created by Fritz Anderson on 11/9/2013.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRPasserEditController;

@interface PRPasserEditTableController : UITableViewController
@property (weak, nonatomic) IBOutlet UITextField *firstNameField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameField;
@property (weak, nonatomic) IBOutlet UITextField *currentTeamField;

@property(strong, nonatomic) NSDictionary *			values;
@property(weak, nonatomic) PRPasserEditController *	parent;
@end
