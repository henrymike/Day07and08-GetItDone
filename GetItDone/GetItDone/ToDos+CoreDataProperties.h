//
//  ToDos+CoreDataProperties.h
//  GetItDone
//
//  Created by Oscar on 9/29/15.
//  Copyright © 2015 Mike Henry. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "ToDos.h"

NS_ASSUME_NONNULL_BEGIN

@interface ToDos (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *toDoDescription;
@property (nullable, nonatomic, retain) NSString *toDoPriority;
@property (nullable, nonatomic, retain) NSDate *toDoDueDate;
@property (nullable, nonatomic, retain) NSDate *toDoCompleteDate;
@property (nullable, nonatomic, retain) NSDate *dateEntered;
@property (nullable, nonatomic, retain) NSDate *dateUpdated;
@property (nullable, nonatomic, retain) NSString *userID;
@property (nullable, nonatomic, retain) NSNumber *toDoCompleteDone;
@property (nullable, nonatomic, retain) NSString *toDoName;

@end

NS_ASSUME_NONNULL_END
