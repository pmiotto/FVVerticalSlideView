//
//  FVVerticalSlideView.m
//  Created by Fernando Valle.
//

@import AudioToolbox;
#import "FVVerticalSlideView.h"
#import "PRTween.h"

@implementation FVVerticalSlideView
{
    UIView *translationView;
    FVSlideViewStatus status;
    CGFloat topY;
    CGFloat bottomY;
    PRTweenOperation *activeTweenOperation;
}

-(id) initWithTop:(CGFloat)top bottom:(CGFloat)bottom translationView:(UIView *)view
{
    
    self = [super initWithFrame:CGRectMake(0,
                                           view.frame.size.height-bottom,
                                           view.frame.size.width,
                                           view.frame.size.height-top)];
    
    if (self)
    {
        translationView = view;
        bottomY = bottom;
        
        UIPanGestureRecognizer* pgr = [[UIPanGestureRecognizer alloc]
                                       initWithTarget:self
                                       action:@selector(handlePanGesture:)];
        
        [self addGestureRecognizer:pgr];
        
#if 0   //  default animation
        self.animationDurationPhase1 = 0.4;
        self.animationDurationPhase2 = 0;
        self.animationLengthPhase2 = 0;
#else   //  2 phases animation
        self.animationDurationPhase1 = 0.1;
        self.animationDurationPhase2 = 0.5;
        self.animationLengthPhase2 = 160;
#endif
        status = FVStatusBottom;
    }
    
    return self;
}

-(void) setTranslationView:(UIView *)tView
{
    self.translationView = tView;
}

-(void) setTopY:(CGFloat )tY
{
    topY = tY;
}

-(void) setBotY:(CGFloat )bY
{
    bottomY = bY;
}

-(void) layoutSubviews
{
    [super layoutSubviews];
}

- (void)handlePanGesture:(UIPanGestureRecognizer *)gesture
{
    static CGPoint lastTranslate;   // the last value
    static CGPoint prevTranslate;   // the value before that one
    static NSTimeInterval lastTime;
    static NSTimeInterval prevTime;
    
    CGPoint translate = [gesture translationInView:translationView];
    CGPoint origin = gesture.view.frame.origin;
    
    
    if (gesture.state == UIGestureRecognizerStateBegan)
    {
        lastTime = [NSDate timeIntervalSinceReferenceDate];
        lastTranslate = translate;
        prevTime = lastTime;
        prevTranslate = lastTranslate;
        
        if(_delegate != nil)
            [_delegate startMovingSliderView];
        
        
    }
    else if (gesture.state == UIGestureRecognizerStateChanged)
    {
        prevTime = lastTime;
        prevTranslate = lastTranslate;
        lastTime = [NSDate timeIntervalSinceReferenceDate];
        lastTranslate = translate;
        
        if(_delegate != nil)
            [_delegate movingSliderView:(origin.y + translate.y)];
        
        
        if(origin.y + translate.y < topY) //determine top Y
        {
            origin = CGPointMake(origin.x, topY);
            CGRect frame = gesture.view.frame;
            frame.origin =origin;
            gesture.view.frame=frame;
        }
        else if(origin.y + translate.y > (translationView.frame.size.height-bottomY)) //determine bottom Y
        {
            origin = CGPointMake(origin.x, translationView.frame.size.height-bottomY);
            CGRect frame = gesture.view.frame;
            frame.origin =origin;
            gesture.view.frame=frame;
        }
        else
        {
            origin = CGPointMake(origin.x, origin.y + translate.y);
            CGRect frame = gesture.view.frame;
            frame.origin =origin;
            gesture.view.frame=frame;
            [gesture setTranslation:CGPointZero inView:gesture.view];
            
        }
        
        
        if(origin.y + translate.y < (translationView.frame.size.height*1/4+topY)) //Top part
        {
            if(_delegate != nil)
                [_delegate closeTopPositionSliderView:(origin.y + translate.y)];
        }
        else //Bottom part
        {
            if(_delegate != nil)
                [_delegate closeBottomPositionSliderView:(origin.y + translate.y)];
        }
    }
    else if (gesture.state == UIGestureRecognizerStateEnded)
    {
        CGPoint swipeVelocity = CGPointZero;
        
        NSTimeInterval seconds = [NSDate timeIntervalSinceReferenceDate] - prevTime;
        if (seconds)
        {
            swipeVelocity = CGPointMake((translate.x - prevTranslate.x) / seconds, (translate.y - prevTranslate.y) / seconds);
        }
        
        if(_delegate != nil)
            [_delegate stopMovingSliderView:(origin.y + translate.y)];
        
        
        
        float inertiaSeconds = 1.0;
        
        CGPoint center = gesture.view.center;
        
        if(swipeVelocity.y > 0) //Scrolling to top
        {
            if(swipeVelocity.y > 100.0f)
            {
                if (translate.y <= 0 && prevTranslate.y <= 0)
                    [self slideToTop:YES];
            }
            else if((center.y + translate.y + swipeVelocity.y * inertiaSeconds) < (translationView.frame.size.height+topY))
            {
                [self slideToTop:YES];
            }
            else
            {
                [self slideToBottom:YES];
            }
            
            
        }
        else //Scrolling to bottom
        {
            if(swipeVelocity.y < -100.0f)
            {
                if (translate.y >= 0 && prevTranslate.y >= 0)
                    [self slideToBottom:YES];
            }
            else if((center.y + translate.y + swipeVelocity.y * inertiaSeconds) > (translationView.frame.size.height+topY))
            {
                [self slideToBottom:YES];
            }
            else
            {
                [self slideToTop:YES];
            }
            
        }
    }
    
}

-(void) slideToBottom
{
    [self slideToBottom:NO];
}


-(void) slideToBottom:(BOOL)isSimple
{
    
    CGRect frame = self.frame;
    frame.origin.y = translationView.frame.size.height-bottomY;
    
    SystemSoundID sid;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"stash-down" ofType:@"wav"];
    NSURL* url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sid);
    AudioServicesPlaySystemSound(sid);
    
    activeTweenOperation = [PRTweenCGRectLerp lerp:self property:@"frame" from:self.frame to:frame duration:0.8 delay:0 timingFunction:&PRTweenTimingFunctionQuintOut updateBlock:nil completeBlock:^(BOOL finished) {
        if(finished) {
            if(_delegate != nil)
                [_delegate closeBottomPositionSliderView:topY];
            
            status = FVStatusBottom;
        }
    }];
    
    
    /*
     CGPoint startPoint = self.frame.origin;
     CGRect fromValue = self.frame;
     
     CGRect frame = self.frame;
     frame.origin.y = translationView.frame.size.height-bottomY;
     CGRect toValue = frame;
     
     
     [CATransaction begin]; {
     
     [CATransaction setCompletionBlock:^{
     
     if(_delegate != nil)
     [_delegate closeBottomPositionSliderView:topY];
     
     status = FVStatusBottom;
     
     
     }];
     
     CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
     animation.fromValue = [NSValue valueWithCGRect:fromValue];
     animation.toValue = [NSValue valueWithCGRect:toValue];
     animation.duration = 1;
     animation.removedOnCompletion = YES;
     animation.fillMode = kCAFillModeForwards;
     animation.timingFunction = [CAMediaTimingFunction functionWithControlPoints:0.2 :1.0 :0.3 :1.0];
     [self.layer addAnimation:animation forKey:animation.keyPath];
     } [CATransaction commit];
     */
    
    /*
     
     NSTimeInterval duration1 = self.animationDurationPhase1;
     NSTimeInterval duration2 = self.animationDurationPhase2;
     CGFloat length = self.animationLengthPhase2;
     if (isSimple)
     {
     duration1 = 0.4;
     duration2 = 0;
     length = 0;
     }
     [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     CGRect frame = self.frame;
     frame.origin.y = (translationView.frame.size.height-bottomY) - length;
     self.frame = frame;
     
     } completion:^(BOOL finished) {
     [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     CGRect frame = self.frame;
     frame.origin.y = translationView.frame.size.height-bottomY;
     self.frame = frame;
     
     } completion:^(BOOL finished) {
     if(_delegate != nil)
     [_delegate closeBottomPositionSliderView:topY];
     
     status = FVStatusBottom;
     }];
     }];
     */
}

-(void) slideToTop
{
    [self slideToTop:NO];
}

-(void) slideToTop:(BOOL)isSimple
{
    CGRect frame = self.frame;
    frame.origin.y = topY;
    
    SystemSoundID sid;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"stash-up" ofType:@"wav"];
    NSURL* url = [NSURL fileURLWithPath:path];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)url, &sid);
    AudioServicesPlaySystemSound(sid);
    
    activeTweenOperation = [PRTweenCGRectLerp lerp:self property:@"frame" from:self.frame to:frame duration:0.8 delay:0 timingFunction:&PRTweenTimingFunctionQuintOut updateBlock:nil completeBlock:^(BOOL finished) {
        if(finished) {
            if(_delegate != nil)
                [_delegate closeTopPositionSliderView:topY];
            
            status = FVStatusTop;
        }
    }];
    
    
    /*
     NSTimeInterval duration1 = self.animationDurationPhase1;
     NSTimeInterval duration2 = self.animationDurationPhase2;
     CGFloat length = self.animationLengthPhase2;
     if (isSimple)
     {
     duration1 = 0.4;
     duration2 = 0;
     length = 0;
     }
     [UIView animateWithDuration:duration1 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     CGRect frame = self.frame;
     frame.origin.y = topY + length;
     self.frame = frame;
     
     } completion:^(BOOL finished) {
     [UIView animateWithDuration:duration2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
     CGRect frame = self.frame;
     frame.origin.y = topY;
     self.frame = frame;
     
     } completion:^(BOOL finished) {
     if(_delegate != nil)
     [_delegate closeTopPositionSliderView:topY];
     
     status = FVStatusTop;
     }];
     }];
     */
}

-(FVSlideViewStatus) slideViewStatus
{
    return status;
}


@end