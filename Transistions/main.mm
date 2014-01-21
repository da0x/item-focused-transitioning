//
//  main.m
//  Transistions
//
//  Created by Daher Alfawares on 1/17/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"
#import "objc/runtime.h"
#import "stdlib.h"
#include <iostream>

namespace debug
{
    static IMP default_alloc = 0;
    
    void alloc(id self, SEL _cmd)
    {
        default_alloc(self,_cmd);
    }

    
    void initialize()
    {
        Method m = class_getClassMethod([NSObject class], @selector(alloc));
        debug::default_alloc = method_getImplementation(m);
        
        
        method_setImplementation(m, (IMP)debug::alloc);
    }
    
    
    NSString * property_type( NSString * attributeString )
    {
        NSString *type = [NSString string];
        NSScanner *typeScanner = [NSScanner scannerWithString:attributeString];
        [typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"@"] intoString:NULL];
        
        // we are not dealing with an object
        if ([typeScanner isAtEnd]) {
            return @"NULL";
        }
        [typeScanner scanCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\"@"] intoString:NULL];
        // this gets the actual object type
        [typeScanner scanUpToCharactersFromSet:[NSCharacterSet characterSetWithCharactersInString:@"\""] intoString:&type];
        return type;
    }
    
    
    
    class class_info
    {
        //std::set<std::string> depedency
    };
}

int main(int argc, char * argv[])
{
    //debug::initialize();
    
    @autoreleasepool {
        /*
        int numClasses;
        Class * classes = NULL;
        
        classes = NULL;
        numClasses = objc_getClassList(NULL, 0);
        
        if (numClasses > 0 )
        {
            classes = (__unsafe_unretained Class*) malloc(sizeof(Class) * numClasses);
            numClasses = objc_getClassList(classes, numClasses);
            
            for( int i=0; i< numClasses; i++ )
            {
                Class cls = classes[i];
                
                
                unsigned int count = 0;
                objc_property_t *properties = class_copyPropertyList( cls, &count);
                
                for( int i = 0; i < count; i++)
                {
                    // grab the property.
                    objc_property_t property = properties[i];
                    
                    // find out the name
                    NSString *propertyName  = [[NSString alloc] initWithUTF8String:property_getName(property)];
                    NSString *propertyClass = [[NSString alloc] initWithUTF8String:property_getAttributes(property)];
                    NSString *propertyType  = debug::property_type( propertyClass );
                    
                    std::cout
                    << "Class name: " << class_getName(cls) << " | "
                    << "Depends on: " << [propertyType UTF8String]
                    <<  std::endl;
                }
                
                free(properties);

            }
            
            free(classes);
        }
        
        */
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
