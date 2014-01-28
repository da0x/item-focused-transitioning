//
//  CustomSegue.m
//  Transistions
//
//  Created by Daher Alfawares on 1/21/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "CustomSegue.h"
#import "ItemFocusedTransitioning.h"

@implementation CustomSegue
{
    NSObject<UIViewControllerTransitioningDelegate>* customTransitioning;
}

- (id)initWithIdentifier:(NSString *)identifier source:(UIViewController *)source destination:(UIViewController *)destination
{
    self = [super initWithIdentifier:identifier source:source destination:destination];
    if( self )
    {
        self->customTransitioning = [ItemFocusedTransitioning new];
    }
    return self;
}

-(void)perform
{
    UIViewController* source = self.sourceViewController;
    UIViewController* destination = self.destinationViewController;
    destination.transitioningDelegate = self->customTransitioning;

    [source.navigationController presentViewController:destination animated:true completion:nil];
}

@end
