//
//  PRPasserEditController.h
//  Passer Rating
//
//  Created by Fritz Anderson on 11/9/2013.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PRPasserEditTableController;

@interface PRPasserEditController : UIViewController

- (void) childReadyForValues;

@property(nonatomic, weak) PRPasserEditTableController *	childEditor;
@property(nonatomic, strong) NSDictionary *					editValues;

//	As a convenience to the client, hold a reference to
//	whatever we're editing. We don't do anything with it.
@property(nonatomic, strong) id <NSObject>	representedObject;

@end
