//
//  PRPasserEditController.m
//  Passer Rating
//
//  Created by Fritz Anderson on 11/9/2013.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//
#import "PRPasserEditController.h"
#import "PRPasserEditTableController.h"

@implementation PRPasserEditController {
	//	A place to hold the editor contents until the child is ready
	NSDictionary *		_savedValues;
}

//	The embed segue is like any other: It has a source (the parent)
//	and a desination (the child). Capture the link between them;
//	there is no way to do it before now.
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
{
	if ([segue.identifier isEqualToString: @"Passer Edit Embed"]) {
		self.childEditor = segue.destinationViewController;
		self.childEditor.parent = self;
	}
}

//	The child exists and has fields it can fill
- (void) childReadyForValues
{
	self.childEditor.values = _savedValues;
}

//	The child's .values property is the "real" data,
//	but when the client sets them, the parent has to remember
//	them until the child can accept them.
- (NSDictionary *) editValues { return self.childEditor.values; }
- (void) setEditValues: (NSDictionary *) editValues
{
	_savedValues = editValues;
	self.childEditor.values = editValues;
}

@end
