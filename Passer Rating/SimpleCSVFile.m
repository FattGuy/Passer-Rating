//
//  SimpleCSVFile.m
//  Passer Rating
//
//  Created by Xcode User on 4/22/10.
//  Copyright 2010, 2013 Frederic F. Anderson. All rights reserved.
//

#import "SimpleCSVFile.h"

#define NAIVE_LINE_BREAKS   1

NSString * const		WT9TErrorDomain = @"com.wt9t.error";

#if ! NAIVE_LINE_BREAKS
@interface NSString (LineBreakingExtensions)
- (NSArray *) componentsBrokenByLines;
@end

@implementation NSString (LineBreakingExtensions)

- (NSArray *) componentsBrokenByLines
{
    NSScanner *         scanner = [NSScanner scannerWithString: self];
    NSCharacterSet *    lineEnders = [NSCharacterSet newlineCharacterSet];
    NSMutableArray *    retval = [NSMutableArray array];
    
    [scanner setCharactersToBeSkipped: nil];
    while (! [scanner isAtEnd]) {
        NSString *      token;
        [scanner scanCharactersFromSet: lineEnders intoString: NULL];
        if ([scanner scanUpToCharactersFromSet: lineEnders intoString: &token])
            [retval addObject: token];
    }
    return retval;
}
@end

#endif  //  NAIVE_LINE_BREAKS

NSString * const		kCSVErrorLineKey = @"kCSVErrorLineKey";
NSString * const		kCSVExpectedFieldsKey = @"kCSVExpectedFieldsKey";
NSString * const		kCSVActualFieldsKey = @"kCSVActualFieldsKey";

@interface SimpleCSVFile () {
    NSArray *       _headers;
}
@property(nonatomic, assign) NSUInteger     lineCount;
@end

@implementation SimpleCSVFile

- (id) initWithPath: (NSString *) aPath
{
	if (self = [super init]) {
		_path = [aPath copy];
	}
	return self;
}

- (NSError *) badLineFormatError: (NSUInteger) fieldCount
{
    NSString *		localizedDescription = 
            [NSString stringWithFormat:
             @"%@:%lu: Expected %lu fields, got %lu.",
             self.path, (unsigned long)self.lineCount, (unsigned long)self.headers.count, (unsigned long)fieldCount];
    
    NSDictionary *	userInfo = @{
      kCSVErrorLineKey          : @(self.lineCount),
      kCSVExpectedFieldsKey     : @(self.headers.count),
      kCSVActualFieldsKey       : @(fieldCount),
      NSFilePathErrorKey        : self.path,
      NSLocalizedDescriptionKey : localizedDescription
      };
    
    return [NSError errorWithDomain: WT9TErrorDomain
                                 code: errCSVBadFormatLine
                             userInfo: userInfo];
}

- (NSError *) emptyFileError
{
    NSString *		localizedDescription =
    [NSString stringWithFormat:  @"%@: the file is empty", self.path];
    
    NSDictionary *	userInfo = @{
		 kCSVErrorLineKey          : @0,
		 NSFilePathErrorKey        : self.path,
		 NSLocalizedDescriptionKey : localizedDescription
		 };

    return [NSError errorWithDomain: WT9TErrorDomain
                               code: errCSVEmptyFile
                           userInfo: userInfo];
}

- (NSError *) noSuchFileError
{
    NSString *		localizedDescription =
    [NSString stringWithFormat:  @"%@: the file is missing", self.path];
    
    NSDictionary *	userInfo = @{
		 kCSVErrorLineKey          : @0,
		 NSFilePathErrorKey        : self.path,
		 NSLocalizedDescriptionKey : localizedDescription
		 };
    
    return [NSError errorWithDomain: WT9TErrorDomain
                               code: errCSVNoSuchFile
                           userInfo: userInfo];
}

- (BOOL) run: (SimpleCSVRecordBlock) block
       error: (NSError **) error
{
	NSString *	contents = [NSString stringWithContentsOfFile: self.path
													encoding: NSUTF8StringEncoding
													   error: error];
    if (! contents) {
        if (error) *error = [self noSuchFileError];
        return NO;
    }
    if (!contents.length) {
        if (error) *error = [self emptyFileError];
		return NO;
    }
	
#if NAIVE_LINE_BREAKS
    NSArray *	lines = [contents componentsSeparatedByCharactersInSet:
						 [NSCharacterSet newlineCharacterSet]];
#else
    NSArray *   lines = [contents componentsBrokenByLines];
#endif
    
	self.lineCount = 0;
	
	for (NSString * line in lines) {
		self.lineCount++;
		
		//	Decompose the line by commas. Real CSV can't break fields this
		//	way, but this is a baby-simple parser.
		NSArray *		fields = [line componentsSeparatedByString: @","];
		
		if (! _headers) {
			//	The first line is a header supplying the field keys.
			_headers = fields;
		}
		else {
			//	Subsequent lines contain records, with field values.
            //  Skip blank lines.
			if (fields.count <= 1)
				continue;
			
			if (fields.count != self.headers.count) {
				//	The record does not have the same number of fields as
				//	specified in the header.
				if (error) {
					*error = [self badLineFormatError: fields.count];
				}
				return NO;
			}
			//	Compose a dictionary of the fields, keyed by the headers.
			NSDictionary *	values = 
						[NSDictionary dictionaryWithObjects: fields
													forKeys: self.headers];
			//	Present the record to the caller.
            BOOL    accepted = block(self, values, error);
			//	If the delegate refuses (or otherwise wants parsing to stop),
			//	return failure (more or less).
			if (! accepted)
				return NO;
		}
	}
	
	return YES;	
}

@end
