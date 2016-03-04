//
//  FVAwesomeLabel.m
//  Created by Fernando on 19/11/15.
//

#import "FVAwesomeLabel.h"

@implementation FVAwesomeLabel

-(void) setAwesomeIcon:(FAIcon)icon andText:(NSString *)text withFotSize:(CGFloat)fontSize
{
    //Icon
    UIFont *awesomeFont = [UIFont fontWithName:kFontAwesomeFont size:fontSize];
    NSDictionary *awesomeFontDict = [NSDictionary dictionaryWithObject: awesomeFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString fa_stringForFontAwesomeIcon:icon] attributes: awesomeFontDict];
    
    //Text
    UIFont *systemFont = [UIFont systemFontOfSize:fontSize];
    NSDictionary *systemFontDict = [NSDictionary dictionaryWithObject: systemFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes: systemFontDict];
    
    [aAttrString1 appendAttributedString:aAttrString2];
    self.attributedText = aAttrString1;
}

-(void) setAwesomeIcon:(FAIcon)icon withIconSize:(CGFloat)iconSize title:(NSString *)title andText:(NSString *)text withFotSize:(CGFloat)fontSize
{
    //Icon
    UIFont *awesomeFont = [UIFont fontWithName:kFontAwesomeFont size:iconSize];
    NSDictionary *awesomeFontDict = [NSDictionary dictionaryWithObject: awesomeFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString fa_stringForFontAwesomeIcon:icon] attributes: awesomeFontDict];
    
    //Title
    UIFont *titleFont = [UIFont systemFontOfSize:fontSize+4];
    NSDictionary *titleFontDict = [NSDictionary dictionaryWithObject:titleFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",title] attributes: titleFontDict];
    
    //Text
    UIFont *textFont = [UIFont systemFontOfSize:fontSize];
    NSDictionary *textFontDict = [NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes: textFontDict];
    
    [aAttrString2 appendAttributedString:aAttrString3];
    [aAttrString1 appendAttributedString:aAttrString2];
    self.attributedText = aAttrString1;
}


-(void) setAwesomeIcon:(FAIcon)icon withIconSize:(CGFloat)iconSize iconColor:(UIColor *)iconColor title:(NSString *)title andText:(NSString *)text withFotSize:(CGFloat)fontSize
{
    //Icon
    UIFont *awesomeFont = [UIFont fontWithName:kFontAwesomeFont size:iconSize];
    NSDictionary *awesomeFontDict = @{NSForegroundColorAttributeName : iconColor,NSFontAttributeName: awesomeFont};
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString fa_stringForFontAwesomeIcon:icon] attributes: awesomeFontDict];
    
    //Title
    UIFont *titleFont = [UIFont systemFontOfSize:fontSize+4];
    NSDictionary *titleFontDict = [NSDictionary dictionaryWithObject:titleFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",title] attributes: titleFontDict];
    
    //Text
    UIFont *textFont = [UIFont systemFontOfSize:fontSize];
    NSDictionary *textFontDict = [NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes: textFontDict];
    
    [aAttrString2 appendAttributedString:aAttrString3];
    [aAttrString1 appendAttributedString:aAttrString2];
    self.attributedText = aAttrString1;
}

-(void) setAwesomeIcon:(FAIcon)icon withIconSize:(CGFloat)iconSize iconColor:(UIColor *)iconColor title:(NSString *)title titleColor:(UIColor *)titleColor andText:(NSString *)text withFotSize:(CGFloat)fontSize
{
    //Icon
    UIFont *awesomeFont = [UIFont fontWithName:kFontAwesomeFont size:iconSize];
    NSDictionary *awesomeFontDict = @{NSForegroundColorAttributeName : iconColor,NSFontAttributeName: awesomeFont};
    NSMutableAttributedString *aAttrString1 = [[NSMutableAttributedString alloc] initWithString:[NSString fa_stringForFontAwesomeIcon:icon] attributes: awesomeFontDict];
    
    //Title
    UIFont *titleFont = [UIFont systemFontOfSize:fontSize+4];
    NSDictionary *titleFontDict = @{NSForegroundColorAttributeName : titleColor,NSFontAttributeName: titleFont};
    NSMutableAttributedString *aAttrString2 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",title] attributes: titleFontDict];
    
    //Text
    UIFont *textFont = [UIFont systemFontOfSize:fontSize];
    NSDictionary *textFontDict = [NSDictionary dictionaryWithObject:textFont forKey:NSFontAttributeName];
    NSMutableAttributedString *aAttrString3 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@" %@",text] attributes: textFontDict];
    
    [aAttrString2 appendAttributedString:aAttrString3];
    [aAttrString1 appendAttributedString:aAttrString2];
    self.attributedText = aAttrString1;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
