// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PRPasser.h instead.

#import <CoreData/CoreData.h>



extern const struct PRPasserAttributes {
	__unsafe_unretained NSString *currentTeam;
	__unsafe_unretained NSString *firstName;
	__unsafe_unretained NSString *lastName;
} PRPasserAttributes;



extern const struct PRPasserRelationships {
	__unsafe_unretained NSString *games;
} PRPasserRelationships;






@class PRGame;








@interface PRPasserID : NSManagedObjectID {}
@end

@interface _PRPasser : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PRPasserID*)objectID;





@property (nonatomic, strong) NSString* currentTeam;



//- (BOOL)validateCurrentTeam:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* firstName;



//- (BOOL)validateFirstName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) NSString* lastName;



//- (BOOL)validateLastName:(id*)value_ error:(NSError**)error_;





@property (nonatomic, strong) PRGame *games;

//- (BOOL)validateGames:(id*)value_ error:(NSError**)error_;





@end



@interface _PRPasser (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveCurrentTeam;
- (void)setPrimitiveCurrentTeam:(NSString*)value;




- (NSString*)primitiveFirstName;
- (void)setPrimitiveFirstName:(NSString*)value;




- (NSString*)primitiveLastName;
- (void)setPrimitiveLastName:(NSString*)value;





- (PRGame*)primitiveGames;
- (void)setPrimitiveGames:(PRGame*)value;


@end
