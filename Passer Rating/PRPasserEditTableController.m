//
//  PRPasserEditTableController.m
//  Passer Rating
//
//  Created by Fritz Anderson on 11/9/2013.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import "PRPasserEditTableController.h"
#import "PRPasserEditController.h"

static NSArray *	sPropertyNames;

@implementation PRPasserEditTableController

+ (void) initialize
{
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		sPropertyNames = @[@"firstName", @"lastName", @"currentTeam"];
	});
}

- (void) viewDidLoad
{
	[super viewDidLoad];
	[self.parent childReadyForValues];
}

- (NSDictionary *) values
{
	NSMutableDictionary *	retval = [NSMutableDictionary dictionary];
	
	for (NSString * propName in sPropertyNames) {
		UITextField *		field;
		field = (UITextField *) [self valueForKey:
								 [propName stringByAppendingString: @"Field"]];
		retval[propName] = field.text?: @"";
		
	}
	return retval;
}

- (void) setValues: (NSDictionary *) values
{
	for (NSString * propName in sPropertyNames) {
		UITextField *		field;
		field = (UITextField *) [self valueForKey:
								 [propName stringByAppendingString: @"Field"]];
		field.text = values[propName]?: @"";
	}
}


@end
