//
//  DrawBoard.h
//  drawBoard
//
//  Created by Macx on 16/6/21.
//  Copyright © 2016年 Macx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawBoard : UIView
@property (nonatomic,strong)NSMutableArray *pointArray;
@property (nonatomic,strong)UIColor *strokeColor;
@property (nonatomic,assign)BOOL isXuxian;
@property (nonatomic,assign)CGFloat lineWidth;
@property (nonatomic,strong)NSMutableArray *lineArray;
@property (nonatomic,strong)NSMutableDictionary *lineDic;
@end
