//
//  ViewController.m
//  CoreData
//
//  Created by Erin Luu on 2016-11-23.
//  Copyright © 2016 Erin Luu. All rights reserved.
//

#import "ViewController.h"
#import "Person+CoreDataClass.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //[self createPerson];
    [self fetchRequest];
    
    
}

-(void)createPerson {
    //Create new object with an entity and context
    Person * newPerson = [NSEntityDescription insertNewObjectForEntityForName:@"Person" inManagedObjectContext:self.context];
    //Set attributes
    newPerson.first = @"Philip";
    newPerson.last = @"Chan";
    newPerson.age = 23;
    
    //Save through context and check for errors
    NSError* error = nil;
    if (![self.context save:&error]) {
        NSLog(@"Couldn't be saves: %@", error.localizedDescription);
    }
}

-(void) fetchRequest {
    //Init a fetchRequest
    NSFetchRequest * fetchRequest = [[NSFetchRequest alloc] init];
    //Set it's entity description to the one you want to retrieve
    NSEntityDescription * entityDescrip = [NSEntityDescription entityForName:@"Person" inManagedObjectContext:self.context];
    [fetchRequest setEntity:entityDescrip];
    
    //Execute the fetch through context and check for errors
    NSError* error = nil;
    //Core data will ALWAYS return an array even for one record or if there are no matching records
    NSArray * results = [self.context executeFetchRequest:fetchRequest error:&error];
    if (error) {
        NSLog(@"Couldn't fetch: %@", error.localizedDescription);
    }
    if (results.count > 0) {
        NSManagedObject *person = (NSManagedObject *)[results objectAtIndex:0];
        //Be aware of faulting. Core data will return a fault NSManagedObject until you really need to access it's attributes.
        NSLog(@"1 - %@", person);
        NSLog(@"%@ %@", [person valueForKey:@"first"], [person valueForKey:@"last"]);
        NSLog(@"2 - %@", person);
    }
    
    //UPDATING RECORDS
    //After a fetch you are alter the NSManagedObject's attributes and do another save from the context
    Person *person = [results objectAtIndex:0];
    person.first = @"Linda";
    //Save through context and check for errors
    if (![self.context save:&error]) {
        NSLog(@"Couldn't be saves: %@", error.localizedDescription);
    }
    
    //DELETING RECORDS
    [self.context deleteObject:person];
    //Don't forget to save
    if (![self.context save:&error]) {
        NSLog(@"Couldn't be saves: %@", error.localizedDescription);
    }
}



@end
