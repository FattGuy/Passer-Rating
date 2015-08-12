// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPasser.m instead.

#import "_PRPasser.h"


const struct PRPasserAttributes PRPasserAttributes = {
	.currentTeam = @"currentTeam",
	.firstName = @"firstName",
	.lastName = @"lastName",
};



const struct PRPasserRelationships PRPasserRelationships = {
	.games = @"games",
};






@implementation PRPasserID
@end

@implementation _PRPasser

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Passer" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Passer";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Passer" inManagedObjectContext:moc_];
}

- (PRPasserID*)objectID {
	return (PRPasserID*)[super objectID];
}

+ (NSSet*)keyPathsForValuesAffectingValueForKey:(NSString*)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}




@dynamic currentTeam;






@dynamic firstName;






@dynamic lastName;






@dynamic games;

	
- (NSMutableSet*)gamesSet {
	[self willAccessValueForKey:@"games"];
  
	NSMutableSet *result = (NSMutableSet*)[self mutableSetValueForKey:@"games"];
  
	[self didAccessValueForKey:@"games"];
	return result;
}
	






@end




