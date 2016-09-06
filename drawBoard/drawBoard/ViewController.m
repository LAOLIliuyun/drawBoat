//
//  ViewController.m
//  drawBoard
//
//  Created by Macx on 16/6/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import "ViewController.h"
#import "DrawBoard.h"
@interface ViewController ()
{
    DrawBoard *drawBoarwview;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    drawBoarwview= [[DrawBoard alloc]initWithFrame:self.view.frame];
    drawBoarwview.backgroundColor = [UIColor whiteColor];
    [self.view insertSubview:drawBoarwview atIndex:0];
    
    
    
}
- (IBAction)valueAction:(id)sender {
    UISlider *slider = (UISlider *)sender;
    drawBoarwview.lineWidth = slider.value;
    }
- (IBAction)xuXianAction:(id)sender {
    UIButton *button = (UIButton *)sender;
    button.selected = !button.selected;
    drawBoarwview.isXuxian = button.selected;

}
- (IBAction)colorAction:(id)sender {
    UIButton *button =(UIButton *)sender;
    drawBoarwview.strokeColor = button.backgroundColor ;
//    如果有view 的是有边框的话，要根据tag值来判定
    for (id view in self.view.subviews) {
        if ([view isKindOfClass:[UIButton class]]) {
            UIButton *button = (UIButton *)view;
            button.layer.borderWidth = 0 ;
        }
    }
    button.layer.borderWidth = 5,
    button.layer.borderColor = [UIColor blackColor].CGColor;
    
}
- (IBAction)redoAction:(id)sender {
    [drawBoarwview.lineArray removeLastObject];
    [drawBoarwview setNeedsDisplay];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
