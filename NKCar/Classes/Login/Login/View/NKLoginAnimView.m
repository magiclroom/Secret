//
//  NKLoginAnimView.m
//  01-通讯录
//
//  Created by J on 15/9/9.
//  Copyright (c) 2015年 jay. All rights reserved.
//

#import "NKLoginAnimView.h"

@interface NKLoginAnimView()
@property (weak, nonatomic) IBOutlet UIImageView *leftArmView;
@property (weak, nonatomic) IBOutlet UIImageView *leftHandView;
@property (weak, nonatomic) IBOutlet UIImageView *rightArmView;
@property (weak, nonatomic) IBOutlet UIImageView *rightHandView;
@property (weak, nonatomic) IBOutlet UIView *ArmView;

/** 手臂y的偏移量*/
@property (nonatomic,assign) CGFloat armSetY;
/** 左手臂x的偏移量*/
@property (nonatomic,assign) CGFloat leftArmSetX;

/**右手臂X的偏移量 */
@property (nonatomic,assign) CGFloat rightArmSetX;



@end

@implementation NKLoginAnimView

+(instancetype)loginAnimView
{
    return [[NSBundle mainBundle] loadNibNamed:@"NKLoginAnimView" owner:nil options:nil][0];
}

- (void)awakeFromNib
{
    //手臂y的偏移量
    _armSetY = self.frame.size.height - self.leftArmView.frame.origin.y;
    
    //左手臂x的偏移量
    _leftArmSetX = - _leftArmView.frame.origin.x;
    
    //右手臂X的偏移量
    _rightArmSetX =_ArmView.frame.size.width - _rightHandView.frame.size.width - _rightArmView.frame.origin.x;
    
    //平移左臂
    _leftArmView.transform = CGAffineTransformMakeTranslation(_leftArmSetX, _armSetY);
    
    //平移右臂
    _rightArmView.transform = CGAffineTransformMakeTranslation(_rightArmSetX, _armSetY);
}


//手臂动画
- (void)setAnim:(BOOL)isClose
{
    if (isClose) {//闭住眼睛
        [UIView animateWithDuration:0.25 animations:^{
            //恢复形变
            _leftArmView.transform = CGAffineTransformIdentity;
            _rightArmView.transform = CGAffineTransformIdentity;
            
            
            //左手
            _leftHandView.transform = CGAffineTransformMakeTranslation(-_leftArmSetX, -_armSetY + 5);
            _leftHandView.transform = CGAffineTransformMakeScale(0.01, 001);
            
            
            //右手
            _rightHandView.transform = CGAffineTransformMakeTranslation(-_rightArmSetX, -_armSetY + 5);
            _rightHandView.transform = CGAffineTransformMakeScale(0.01, 0.01);
        }];
    }else {//睁开眼睛
        [UIView animateWithDuration:0.25 animations:^{
            //平移左臂
            _leftArmView.transform = CGAffineTransformMakeTranslation(_leftArmSetX, _armSetY);
            
            //平移右臂
            _rightArmView.transform = CGAffineTransformMakeTranslation(_rightArmSetX, _armSetY);
            
            //恢复手的形变
            _leftHandView.transform = CGAffineTransformIdentity;
            
            _rightHandView.transform = CGAffineTransformIdentity;

        }];
        
    }
        
}



@end
