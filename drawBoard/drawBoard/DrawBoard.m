//
//  DrawBoard.m
//  drawBoard
//
//  Created by Macx on 16/6/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "DrawBoard.h"

@implementation DrawBoard
-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _pointArray = [NSMutableArray array];
        _strokeColor = [UIColor blackColor];
        _lineWidth = 1;
        _lineArray = [NSMutableArray array];
        _lineDic = [NSMutableDictionary dictionary];
        _isXuxian = NO ;
    }
    return self;
}
- (void)drawRect:(CGRect)rect {
    
    CGContextRef ref = UIGraphicsGetCurrentContext();
    
    //绘制旧的线条
    for (NSDictionary *dic in _lineArray) {
        NSArray *points = dic[@"pointArray"];
        UIColor *color = dic[@"strokeColor"];
        BOOL xuXian = [dic[@"isXuxian"] boolValue];
        CGFloat width = [dic[@"linewidth"] floatValue];
        CGContextSetStrokeColorWithColor(ref, color.CGColor);
        CGContextSetLineWidth(ref, width);
        if (xuXian) {
            CGFloat length[] = {10,10};
            CGContextSetLineDash(ref, 0, length, 2);
        }else{
            CGContextSetLineDash(ref, 0, NULL, 0);
        }
        if (points.count>0) {
            CGContextMoveToPoint(ref, [points[0] CGPointValue].x, [points[0] CGPointValue].y);
        }
        for (int i = 1; i < points.count; i ++) {
            
            CGContextAddLineToPoint(ref, [points[i] CGPointValue].x, [points[i] CGPointValue].y);
        }
        CGContextStrokePath(ref);
    }

   //绘制新的线条

    CGContextSetStrokeColorWithColor(ref, _strokeColor.CGColor);
    CGContextSetLineWidth(ref, _lineWidth);
    if (_isXuxian) {
        CGFloat length[]= {10,10};
        CGContextSetLineDash(ref, 0, length, 2);
    }else{
        CGContextSetLineDash(ref, 0, NULL, 0);
    }
    
    if (_pointArray.count > 0) {
        CGContextMoveToPoint(ref, [_pointArray[0]CGPointValue].x,  [_pointArray[0]CGPointValue].y);
    }
    for (int i = 1 ; i < _pointArray.count; i ++) {
        CGContextAddLineToPoint(ref, [_pointArray[i]CGPointValue].x, [_pointArray[i]CGPointValue].y);
    }
    CGContextStrokePath(ref);

    
    

}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    //将点装进去点数组内，因为点事一个结构体，无法直接装入nsarray类型，所以需要nsvalue来封装
    [_pointArray addObject:[NSValue valueWithCGPoint:point]];
    //将点数组装入线字典内
    [_lineDic setValue:_pointArray forKey:@"pointArray"];
    //一条线段是否是虚线，由下笔的第一秒就触发touchbegan这个方法就已经确定下来了，所以我们可以直接在这里将isXuxian,linewidth,ctrokecolor在这里装起来
    [_lineDic setValue:[NSNumber numberWithBool:_isXuxian] forKey:@"isXuxian"];
    [_lineDic setValue:[NSNumber numberWithFloat:_lineWidth] forKey:@"linewidth"];
    [_lineDic setValue:_strokeColor forKey:@"strokeColor"];
    [self setNeedsDisplay];
}
-(void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    [_pointArray addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [[touches anyObject]locationInView:self];
    [_pointArray addObject:[NSValue valueWithCGPoint:point]];
    [self setNeedsDisplay];
    
    [_lineArray addObject:_lineDic];

    
    //将之前的数据初始化
    _pointArray = [NSMutableArray array];
    _lineDic = [NSMutableDictionary dictionary];
   
}






@end
