//
//  ZoomabeImageView.m
//  PhotoLibrary
//
//  Created by Eri Tange on 2014/04/21.
//  Copyright (c) 2014年 Eri Tange. All rights reserved.
//

#import "ZoomabeImageView.h"
@interface ZoomabeImageView()<UIScrollViewDelegate>
@property(weak,nonatomic)UIImageView *imageView;
@end

@implementation ZoomabeImageView

-(id)initWithCoder:(NSCoder *)aDecoder{
    
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initialize];
    }
    
    return self;
}


- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self initialize];
    }
    return self;
}

-(void)initialize{
    
    self.delegate = self;
    self.maximumZoomScale = 4.0f;
    self.backgroundColor = [UIColor blackColor];
    
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.autoresizingMask = UIViewAutoresizingNone;
    imageView.contentMode = UIViewContentModeScaleToFill;
    [self addSubview:imageView];
    
    _imageView = imageView;
}

-(UIImage *)image{
    
    return self.imageView.image;
}

-(void)setImage:(UIImage *)image{
    
    self.imageView.image = image;
}

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat viewWidth = CGRectGetWidth(self.frame);
    CGFloat viewHeight = CGRectGetHeight(self.frame);
    CGFloat imageWidth = self.image.size.width;
    CGFloat imageHeight = self.image.size.height;
    CGFloat ratio = MAX(imageWidth/viewWidth, imageHeight/viewHeight);
    
    CGFloat imageViewWidth = imageWidth/ratio * self.zoomScale;
    CGFloat imageViewHeight = imageHeight/ratio * self.zoomScale;
    CGFloat imageViewX = MAX(0,viewWidth - imageViewWidth)/2;
    CGFloat imageViewY = MAX(0,viewHeight - imageViewHeight)/2;
    
    self.imageView.frame = CGRectMake(imageViewX,imageViewY,imageViewWidth,imageViewHeight);
    self.contentSize = self.imageView.frame.size;

}

-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    
    return self.imageView;

}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
