//
//  PRPasserListController.m
//  Passer Rating
//
//  Created by Xcode User on 8/5/13.
//  Copyright (c) 2013 Xcode User. All rights reserved.
//

#import "PRPasserListController.h"
#import "PRGameListController.h"
#import "PRDataModel.h"
#import "PRPasserEditController.h"

@interface PRPasserListController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation PRPasserListController {
    __strong PRPasser *		_passerToEdit;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
    //  Leave this in. I'll explain why.
    //	NSEntityDescription *entity =
    //            [[self.fetchedResultsController fetchRequest] entity];
    
    //  Initialize a new Passer.
    PRPasser *        newPasser =
    [PRPasser passerWithFirstName: @"FirstName"
                         lastName: @"LastName"
                        inContext:  self.managedObjectContext];
    newPasser.currentTeam = @"TeamName";
    
    // Save the context.
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        //  ...
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [self.fetchedResultsController sections][section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        NSError *error = nil;
        if (![context save:&error]) {
            // Replace this implementation with code to handle the error appropriately.
            // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void) tableView: (UITableView *) tableView
accessoryButtonTappedForRowWithIndexPath: (NSIndexPath *) indexPath
{
    _passerToEdit = [self.fetchedResultsController objectAtIndexPath: indexPath];
    [self performSegueWithIdentifier: @"Edit passer"
                              sender: _passerToEdit];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSManagedObject *object = [[self fetchedResultsController] objectAtIndexPath:indexPath];
        [[segue destinationViewController] setDetailItem: (PRPasser *) object];
    }
    else if ([segue.identifier isEqualToString: @"Edit passer"]) {
        PRPasserEditController *	editor = segue.destinationViewController;
        if (_passerToEdit) {
            editor.editValues = [_passerToEdit dictionaryWithValuesForKeys:
                                 @[@"firstName", @"lastName", @"currentTeam"]];
            editor.representedObject = _passerToEdit;
        }
        else {
            editor.editValues = @{@"firstName"		: @"",
                                  @"lastName"		: @"",
                                  @"currentTeam"    : @""};
            editor.representedObject = nil;
        }
    }
    _passerToEdit = nil;
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *fetchRequest =
    [NSFetchRequest fetchRequestWithEntityName: @"Passer"];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSArray *       sortDescriptors;
    sortDescriptors = @[
                        [NSSortDescriptor sortDescriptorWithKey: @"lastName"
                                                      ascending: YES],
                        [NSSortDescriptor sortDescriptorWithKey: @"firstName"
                                                      ascending: YES]
                        ];
    fetchRequest.sortDescriptors = sortDescriptors;
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Master"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed.
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

- (void)configureCell: (UITableViewCell *) cell
          atIndexPath: (NSIndexPath *) indexPath
{
    PRPasser *    passer = (PRPasser *)
    [self.fetchedResultsController objectAtIndexPath:indexPath];
    NSString *  content = [NSString stringWithFormat: @"%@ %@ (%.1f)",
                           passer.firstName, passer.lastName,
                           passer.passerRating];
    cell.textLabel.text = content;
}

#pragma mark - Editor results

- (IBAction) editorDidSave: (UIStoryboardSegue *) sender
{
    //	An unwind segue, presumably representing an exit
    //	from an editor, accepting the contents, has arrived.
    //	The segue provides the source controller, which is the editor.
    PRPasserEditController *	editor = sender.sourceViewController;
    
    //	The editor gives back the pointer to the PRPasser (if any)
    //	it was editing. It did _not_ change its values; the editor
    //	was just holding the pointer so we could get it back.
    PRPasser *					passer = editor.representedObject;
    
    if (! passer) {
        //	It's a new passer. Create it.
        passer = [PRPasser insertInManagedObjectContext: self.managedObjectContext];
    }
    
    //	Set the new/changed passer's attributes direcly from
    //	the editor's values.
    [passer setValuesForKeysWithDictionary: editor.editValues];
    
    NSError *					error;
    if (! [self.managedObjectContext save: &error]) {
        NSLog(@"%s: Could not save edited passer %@ - %@",
              __PRETTY_FUNCTION__, error, error.userInfo);
    }
}

- (IBAction) editorDidCancel: (UIStoryboardSegue *) sender
{
    //	If the edit was canceled, there's nothing to do.
}

@end
