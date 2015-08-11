//
//  SimpleCSVFile.h
//  Passer Rating
//
//  Created by Xcode User on 4/22/10.
//  Copyright 2010, 2013 Frederic F. Anderson. All rights reserved.
//

#import <Foundation/Foundation.h>

@class	SimpleCSVFile;

extern NSString * const		WT9TErrorDomain;

enum _CSVErrors {
	errCSVBadFormatLine = -1,
	errCSVEmptyFile = -2,
    errCSVNoSuchFile = -3
};

/// `NSError*` `userInfo` dictionary key for the
/// line on which an error was detected. (`NSNumber`)
extern NSString * const		kCSVErrorLineKey;
/// `NSError*` `userInfo` dictionary key for the
/// number of fields in the header line. (`NSNumber`)
extern NSString * const		kCSVExpectedFieldsKey;
/// `NSError*` `userInfo` dictionary key for the
/// number of fields found in a record line. (`NSNumber`)
extern NSString * const		kCSVActualFieldsKey;

/**
 Receive key-value data from a line in a CSV file.
 
 This block is called once for every line in the file
 after the first by `-[SimpleCSVFie run:error:]`. The callee
 can stop parsing by returning `NO.` If it does, and
 `error` is not `NULL,` it must return `nil` or an
 `NSError*` object in `*error.`
 
 The dictionary will be keyed on the names found in the header
 line, and the values will be drawn from the fields in the
 corresponding positions.
 
 @param     file    The SimpleCSVFile object doing the parsing.
 @param     values  A dictionary of strings representing the
                    field values in the record line, keyed by
                    the field names supplied in the header line.
 @param[out] error  A pointer to an `NSError` object pointer.
                    May be `NULL.` If it is not, and the callee
                    returns NO, this _must_ be set to a valid
                    `NSError` object pointer, or at least to
                    `nil.`
 @return    `YES` if parsing may continue
 @return    `NO`  if it may not; the callee must fill the returned `NSError`.
 */
typedef BOOL (^SimpleCSVRecordBlock)(SimpleCSVFile * file,
                                     NSDictionary * values,
                                     NSError ** error);

/**
 Parser for simple CSV files.
 SimpleCSVFile will open a file and attempt to extract key-value data from it.
 It is expected that the first line will include keys that identify the fields
 in the data stream.
 
 @warning This is not a general CSV parser. 
 In particular, it does not handle quotes, embedded commas, or escaping.
 */

@interface SimpleCSVFile : NSObject
/**
 Initialize with a path to a CSV file. Designated initializer.
 
 @param aPath   A string containing an absolute or relative path to the input file.
 @return The receiver.
 */
- (id) initWithPath: (NSString *) aPath;

/**
 Parse the CSV file.
 Loops through the lines of the input file, interpreting the first line
 as unique keys for the data fields contained in the remaining lines.
 
 The keys and values for each line are gathered into an NSDictionary,
 which is presented line-by-line to the caller through the supplied block.
 
 It is an error for the file to have a line with a different number of
 fields than specified in the header line.
 
 @param     block   A block the caller supplies to accept
                    record-by-record data from the receiver.
 @param[out] error  A pointer to an `NSError` object pointer, or nil.
                    If non-nil, and an error occurs (signified by a
                    return value of `NO`), `*error` will describe the
                    problem.
 @return    `YES` if parsing succeeded.
 @return    `NO` if it did not. If an `NSError**` parameter
            was supplied, `*error` will describe the problem.
 */
- (BOOL) run: (SimpleCSVRecordBlock) block
       error: (NSError **) error;
    
    /// The path to the CSV file.
    /// The value is set by `-initWithPath:` and cannot be changed.
@property(nonatomic, readonly)	NSString *      path;

    /// An array of NSStrings which are the header names.
@property(nonatomic, readonly)	NSArray *		headers;
    
/**
 A managed-object context, for the use of the client.
 SimpleCSVFile makes no use of this property. It is provided as
 a convenience to the caller, so it can associate the records
 with a managed-object context.
 @fixme See if this is needed in a block-based mechanism.
 */
@property(strong) NSManagedObjectContext *              moc;

@end
