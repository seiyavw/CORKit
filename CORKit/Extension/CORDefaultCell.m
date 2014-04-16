//
//  CORDefaultCell.m
//  CORKit
//
//  Created by Seiya Sasaki on 2014/01/28.
//  Copyright (c) 2014年 Seiya Sasaki. All rights reserved.
//

#import "CORDefaultCell.h"

@implementation CORDefaultCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    //    [super setHighlighted:highlighted animated:animated];
    
    if (highlighted) {
        
        if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
            
            if (_highlightedColor != nil) {
                
                self.backgroundColor = _highlightedColor;
                
            } else {
                
                self.backgroundColor = [UIColor lightGrayColor];
            }
        }
    } else {
        
        if (_normalStateColor != nil) {
            
            self.backgroundColor = _normalStateColor;
            
        } else {
            
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    //    [super setSelected:selected animated:animated];
    
    if (selected) {
        
        if (self.selectionStyle != UITableViewCellSelectionStyleNone) {
            
            if (_highlightedColor != nil) {
                
                self.backgroundColor = _highlightedColor;
                
            } else {
                
                self.backgroundColor = [UIColor lightGrayColor];
            }
        }
    } else {
        
        if (_normalStateColor != nil) {
            
            self.backgroundColor = _normalStateColor;
            
        } else {
            
            self.backgroundColor = [UIColor whiteColor];
        }
    }
}

@end
