//
//  CustomAnimation.m
//  Transistions
//
//  Created by Daher Alfawares on 1/17/14.
//  Copyright (c) 2014 Daher Alfawares. All rights reserved.
//

#import "ItemFocusedTransitioning.h"
#include <map>

@implementation ItemFocusedTransitioning

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
    return [ItemFocusedAnimationController new];
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    return [ItemFocusedDismissAnimationController new];
}

@end


@interface ItemFocusedAnimationController()
@property CGRect originalSourceRect;
@property BOOL isDismissing;
@end

@implementation ItemFocusedAnimationController
{
    std::map<UIView*,CGRect> rects;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    typedef UIViewController<ItemFocusedTransitionProtocol> ItemFocusedViewController;
    
    ItemFocusedViewController* sourceViewController      = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ItemFocusedViewController* destinationViewController = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView*                    container                 = [transitionContext containerView];
    
    if( [sourceViewController isKindOfClass:[UINavigationController class]] )
    {
        sourceViewController = [((UINavigationController*)sourceViewController).viewControllers lastObject];
    }
    
    if( [destinationViewController isKindOfClass:[UINavigationController class]] )
    {
        destinationViewController = [((UINavigationController*)destinationViewController).viewControllers lastObject];
    }
    
        // TODO: add safe checks.
    UIView* sourceView      = [sourceViewController viewForItemFocusedTransitioning];
    UIView* destinationView = [destinationViewController viewForItemFocusedTransitioning];
    
        // get destination frame.
    CGRect destinationRect = [self rectForView:destinationView inViewController:destinationViewController];
    CGRect sourceRect      = [self rectForView:sourceView inViewController:sourceViewController];
    
//    [destinationView setAlpha:0];
    
    [container addSubview:destinationViewController.view];
    [destinationViewController.view setAlpha:0];
    

    [UIView animateWithDuration:.5 animations:^{
        sourceView.frame = destinationRect;
        
        for( UIView* view in sourceViewController.view.subviews )
        {
            if( [view isEqual:sourceView] )
                continue;
            
            view.frame = [self rectForView:view forMovingAwayFromRect:sourceRect];
        }
        
    } completion:^(BOOL finished) {

        
        for( UIView* view in destinationViewController.view.subviews )
        {
            if( [view isKindOfClass:[UINavigationBar class]] )
                continue;
            
            if( [view isEqual:destinationView] )
                continue;
            
            self->rects[view] = view.frame;
            view.frame = [self rectForView:view forMovingAwayFromRect:destinationRect];
        }
        
        [UIView animateWithDuration:1 animations:^{
            
            [destinationViewController.view setAlpha:1];
            
            for( UIView* view in destinationViewController.view.subviews )
            {
                if( [view isKindOfClass:[UINavigationBar class]] )
                    continue;
                
                if( [view isEqual:destinationView] )
                    continue;
                
                view.frame = self->rects[view];
            }
            
        } completion:^(BOOL finished) {
            [destinationView setAlpha:1];
            [transitionContext completeTransition:true];
        }];
    }];
}

-(NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1;
}

#pragma mark helpers


-(CGRect)rectForView:(UIView*)view inViewController:(UIViewController*)viewController
{
        // get destination frame.
    CGRect rect;
    
        // Assume that destinationView is not always a direct subview of destinationViewController.view.
    if( viewController.view != view.superview )
    {
        rect = [viewController.view convertRect:view.frame fromView:view];
    }
    else
    {
        rect = view.frame;
    }
    
    return rect;
}

-(CGRect)rectForView:(UIView*)view forMovingAwayFromRect:(CGRect)awayFrom
{
    CGPoint p1 = awayFrom.origin;
    CGPoint p2 = view.frame.origin;
    
        // subtract
    CGPoint d = CGPointMake( p2.x - p1.x , p2.y - p1.y );
    
        // normalize
    float l = sqrtf( d.x * d.x + d.y * d.y );
    CGPoint n = CGPointMake( d.x / l , d.y / l );
    
        // final
    float distance = 2000;
    CGRect final = CGRectMake( n.x * distance, n.y * distance, view.frame.size.width, view.frame.size.height );
    return final;
}

@end


@implementation ItemFocusedDismissAnimationController
{
    std::map<UIView*,CGRect> rects;
}

-(void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    typedef UIViewController<ItemFocusedTransitionProtocol> ItemFocusedViewController;
    
    ItemFocusedViewController* sourceViewController      = (id)[transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    ItemFocusedViewController* destinationViewController = (id)[transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIView*                    container                 = [transitionContext containerView];
    
    if( [sourceViewController isKindOfClass:[UINavigationController class]] )
    {
        sourceViewController = [((UINavigationController*)sourceViewController).viewControllers lastObject];
    }
    
    
    [container insertSubview:destinationViewController.view belowSubview:sourceViewController.view];
    if( [destinationViewController isKindOfClass:[UINavigationController class]] )
    {
        destinationViewController = [((UINavigationController*)destinationViewController).viewControllers lastObject];
    }
    
    // TODO: add safe checks.
    UIView* sourceView      = [sourceViewController viewForItemFocusedTransitioning];
    UIView* destinationView = [destinationViewController viewForItemFocusedTransitioning];
    
    // get destination frame.
    CGRect destinationRect = [self rectForView:destinationView inViewController:destinationViewController];
    CGRect sourceRect      = [self rectForView:sourceView inViewController:sourceViewController];
    
    
    [UIView animateWithDuration:.5 animations:^{
        
        for( UIView* view in sourceViewController.view.subviews )
        {
            if( [view isEqual:sourceView] )
                continue;
            
            view.frame = [self rectForView:view forMovingAwayFromRect:sourceRect];
        }
        
    } completion:^(BOOL finished) {
     
        
        for( UIView* view in destinationViewController.view.subviews )
        {
            if( [view isKindOfClass:[UINavigationBar class]] )
                continue;
            
            if( [view isEqual:destinationView] )
                continue;
            
            self->rects[view] = view.frame;
            view.frame = [self rectForView:view forMovingAwayFromRect:destinationRect];
        }
        
        destinationView.frame = sourceRect;
        [sourceViewController.view removeFromSuperview];
        
        [UIView animateWithDuration:1 animations:^{
            destinationView.frame = destinationRect;
            
            for( UIView* view in destinationViewController.view.subviews )
            {
                if( [view isKindOfClass:[UINavigationBar class]] )
                    continue;
                
                if( [view isEqual:destinationView] )
                    continue;
                
                view.frame = self->rects[view];
            }
            
        } completion:^(BOOL finished) {
            
            [transitionContext completeTransition:true];
        }];
    }];
}

@end

