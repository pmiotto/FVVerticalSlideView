//
//  FVAwesomeLabel.h
//  RutasVillasRomanas
//
//  Created by Fernando on 19/11/15.
//  Copyright © 2015 Signlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NSString+FontAwesome.h"

@interface FVAwesomeLabel : UILabel



-(void) setAwesomeIcon:(FAIcon)icon andText:(NSString *)text withFotSize:(CGFloat)fontSize;

-(void) setAwesomeIcon:(FAIcon)icon withIconSize:(CGFloat)iconSize title:(NSString *)title andText:(NSString *)text withFotSize:(CGFloat)fontSize;

-(void) setAwesomeIcon:(FAIcon)icon withIconSize:(CGFloat)iconSize iconColor:(UIColor *)iconColor title:(NSString *)title andText:(NSString *)text withFotSize:(CGFloat)fontSize;

-(void) setAwesomeIcon:(FAIcon)icon withIconSize:(CGFloat)iconSize iconColor:(UIColor *)iconColor title:(NSString *)title titleColor:(UIColor *)titleColor andText:(NSString *)text withFotSize:(CGFloat)fontSize;

@end
