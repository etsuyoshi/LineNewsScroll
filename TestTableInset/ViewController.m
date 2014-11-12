//
//  ViewController.m
//  TestTableInset
//
//  Created by EndoTsuyoshi on 2014/11/05.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//  サブテーブルの末端まで行ったら親テーブルのpagingEnabledをオンにして下方向のscrollは親テーブルにのみ適用する

#import "ViewController.h"
#import "Type2ViewController.h"

@interface ViewController ()

@end

@implementation ViewController{
    UITableView *table0;
    UITableView *table1;
    UITableView *table2;
    
    
    
    int heightTable0;
    int heightTable1;
    int heightTable2;
    
    BOOL isPaged;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    NSLog(@"%s view = (%.f, %.f)",
          __func__,
          self.view.bounds.size.width,
          self.view.bounds.size.height);
    
    heightTable0 = self.view.bounds.size.height;
//    heightTable1 = self.view.bounds.size.height-100;
//    heightTable2 = self.view.bounds.size.height-100;
    heightTable1 = self.view.bounds.size.height;
    heightTable2 = self.view.bounds.size.height;

    
    isPaged = NO;
    
    table0 =
    [[UITableView alloc]
    initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                             heightTable0)
     style:UITableViewStyleGrouped];
    table0.delegate = self;
    table0.dataSource = self;
    //画面と同じコンテンツサイズにする
    [table0 setContentSize:
     CGSizeMake(self.view.bounds.size.width,
                self.view.bounds.size.height)];
    table0.scrollEnabled = YES;
    table0.pagingEnabled = YES;
    table0.backgroundColor = [UIColor darkGrayColor];
//    
//    table0.bounces = YES;
//    table0.alwaysBounceVertical = YES;
    [self.view addSubview:table0];
    
    
    
    //table1
    table1 = [[UITableView alloc]
              initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                                       heightTable1)
              style:UITableViewStyleGrouped];
    table1.delegate = self;
    table1.dataSource = self;
//    [table1 setContentSize:self.view.bounds.size];
    [table1 setContentSize:CGSizeMake(self.view.bounds.size.width, heightTable1)];
    [table1 setContentOffset:CGPointMake(-50, 0)];
//    NSLog(@"bounds = %f, %f",
//          table1.bounds.size.width,
//          table1.bounds.size.height);
    //table1の余白としてinsetsを設ける
    table1.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0);
    table1.backgroundColor = [UIColor brownColor];
    table1.scrollEnabled = NO;
    table1.scrollEnabled = YES;
    
//    table1.bounces = NO;
//    table1.alwaysBounceVertical = NO;
    
    //table2
    table2 = [[UITableView alloc]
              initWithFrame:
              CGRectMake(0, 0, self.view.bounds.size.width,
                         heightTable2)
              style:UITableViewStyleGrouped];
    table2.delegate = self;
    table2.dataSource = self;
//    table2.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    table2.backgroundColor = [UIColor greenColor];
    [table2 setContentSize:self.view.bounds.size];
    table2.contentInset = UIEdgeInsetsMake(-35, 0, -35, 0);
    table2.scrollEnabled = NO;
    table2.scrollEnabled = YES;
    
    
    
    
    
    
    
    
    
    
    
    [table0 reloadData];
    
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
//    if(tableView == table0){
//        return 2;//table1と2を貼り付けるためのセルを用意
//    }else{//table1,2
//        return 3;
//    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(section == 0){
        if(tableView == table0){
            return 2;//table1と2を貼り付けるためのセルを用意
        }else{//table1,2
            return 5;
        }
    }else{
        return 0;
    }

}

//-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
//    return 30;
//}
//
//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == table0){
        if(indexPath.row % 2 ==0){
            return table1.bounds.size.height;
        }else if(indexPath.row % 2== 1){
            return table2.bounds.size.height;
        }else{
            NSLog(@"error");
            return 10;
        }
    }else if(tableView == table1){
//        NSLog(@"numberOfRowsInSection = %d", (int)[table1 numberOfRowsInSection:0]);
        return heightTable1/3;//(int)[table1 numberOfRowsInSection:0];
    }else{// if(tableView == table2){
        return heightTable2/3;//(int)[table2 numberOfRowsInSection:0];
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if(tableView == table0){
        NSLog(@"%s %d", __func__, (int)section);
        UIView *header = [[UIView alloc]
                          initWithFrame:
                          CGRectMake(0, 0,
                                     self.view.bounds.size.width, 30)];
        header.backgroundColor = [UIColor blackColor];
        return header;
    }else if(tableView == table1){
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    }else{
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    }
}

-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if(tableView == table0){
        UIView *footer = [[UIView alloc]
                          initWithFrame:
                          CGRectMake(0, 0,
                                     self.view.bounds.size.width, 20)];
        footer.backgroundColor = [UIColor grayColor];
        return footer;
    }else if(tableView == table1){
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    }else{
        return [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 1)];
    }
}


-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    if(tableView == table0){
        static NSString *CellIdentifier = nil;
        if(CellIdentifier == nil)
            CellIdentifier =
            [NSString stringWithFormat:@"cell0%d", (int)indexPath.row];//unique
        UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //
        if(cell == nil){
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
//        for(UIView *view in cell.subviews){
//            NSLog(@"view = %@", view);//UITableViewCellScrollView
//            for(UIView *subview in view.subviews){
//                NSLog(@"subview = %@", subview);//UITableViewCellContentView
//                for(UIView *subview2 in subview.subviews){
//                    NSLog(@"cell");//view
//                    [subview2 removeFromSuperview];
//                }
//                [subview removeFromSuperview];
//            }
//        }
        
        
        if(indexPath.row % 2 == 0){
            NSLog(@"draw %@", indexPath);
//            [table1 setContentOffset:CGPointMake(0, 160)];
//            [table1 setContentSize:CGSizeMake(self.view.bounds.size.width,
//                                              10)];
            NSLog(@"table1 = %@", table1);
            [table1 reloadData];
            [cell.contentView addSubview:table1];
            cell.contentView.backgroundColor = [UIColor redColor];
        }else if(indexPath.row % 2 == 1){
            NSLog(@"draw %@", indexPath);
            [table2 reloadData];
            [cell.contentView addSubview:table2];
            cell.contentView.backgroundColor = [UIColor lightGrayColor];
        }else{
            NSLog(@"draw %@", indexPath);
            NSLog(@"other cell");
            cell.contentView.backgroundColor = [UIColor redColor];
        }
    
        return cell;
    }else if(tableView == table1){//table1
        static NSString *CellIdentifier = nil;
        if(CellIdentifier == nil)
            CellIdentifier =
            [NSString stringWithFormat:@"cell1%d", (int)indexPath.row];//unique
        UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        for(UIView *view in cell.subviews){
            NSLog(@"view = %@", view);//UITableViewCellScrollView
            for(UIView *subview in view.subviews){
                NSLog(@"subview = %@", subview);//UITableViewCellContentView
                for(UIView *subview2 in subview.subviews){
                    NSLog(@"cell");//view
                    [subview2 removeFromSuperview];
                }
                [subview removeFromSuperview];
            }
        }
        switch (indexPath.row) {
            case 0:{
                cell.contentView.backgroundColor = [UIColor redColor];
                break;
            }
            case 1:{
//                cell.contentView.backgroundColor = [UIColor yellowColor];
                cell.contentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.8f];
                break;
            }
            case 2:{
//                cell.contentView.backgroundColor = [UIColor blueColor];
                cell.contentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.6f];
                break;
            }
            case 3:{
                cell.contentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.4f];
                break;
            }
            case 4:{
                cell.contentView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:.2f];
                break;
            }
            default:{
                cell.contentView.backgroundColor = [UIColor colorWithRed:(float)(arc4random()%255)/255.0f green:0 blue:0 alpha:1.0f];
                break;
            }
        }
        
        return cell;
    }else{//table2
        static NSString *CellIdentifier = nil;
        if(CellIdentifier == nil)
            CellIdentifier =
            [NSString stringWithFormat:@"cell2%d", (int)indexPath.row];//unique
        UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        for(UIView *view in cell.subviews){
            NSLog(@"view = %@", view);//UITableViewCellScrollView
            for(UIView *subview in view.subviews){
                NSLog(@"subview = %@", subview);//UITableViewCellContentView
                for(UIView *subview2 in subview.subviews){
                    NSLog(@"cell");//view
                    [subview2 removeFromSuperview];
                }
                [subview removeFromSuperview];
            }
        }
        switch (indexPath.row) {
            case 0:{
                cell.contentView.backgroundColor = [UIColor purpleColor];
                break;
            }
            case 1:{
//                cell.contentView.backgroundColor = [UIColor cyanColor];
                cell.contentView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.8f];
                break;
            }
            case 2:{
                cell.contentView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.6f];
//                cell.contentView.backgroundColor = [UIColor magentaColor];
                break;
            }
            case 3:{
                cell.contentView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.4f];
//                cell.contentView.backgroundColor = [UIColor magentaColor];
                break;
            }
            case 4:{
//                cell.contentView.backgroundColor = [UIColor magentaColor];
                cell.contentView.backgroundColor = [[UIColor purpleColor] colorWithAlphaComponent:.2f];
                break;
            }
                
            default:{
                cell.contentView.backgroundColor = [UIColor colorWithRed:(float)(arc4random()%255)/255.0f green:0 blue:0 alpha:1.0f];
                break;
            }
        }
        
        return cell;
    }

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s %@", __func__, tableView);
    
    if(tableView == table0){
        NSLog(@"table0");
        
    }else if(tableView == table1){
        NSLog(@"table1");
        
//        [table1 setContentOffset:CGPointMake(0, 0)];
    }else{
        NSLog(@"table2 indexpath = %@", indexPath);
        
        if(indexPath.row == 0){
            NSLog(@"did tap table2 row=0");
            Type2ViewController *type2VC = [[Type2ViewController alloc]init];
//            [self.navigationController pushViewController:type2VC animated:YES];
            [self presentViewController:type2VC animated:YES completion:nil];
            NSLog(@"type2vc = %@", type2VC);
        }
    }
    NSLog(@"indexPath = %@", indexPath);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


//慣性スクロール完了時
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
}

//自動スクロール完了時にのみコール
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
}

//手動スクロール完了時:フリック(decelerate=1)とドラッグ(decelerate=0)時にコール
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    NSLog(@"%s decelerate=%d", __func__, decelerate);
    
    
}

//ドラッグ（フリック）し始めたタイミング
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    NSLog(@"%s : %f, %f", __func__, translation.x, translation.y);
//    if(translation.x > 0)
//    {
//        // react to dragging right
//    } else
//    {
//        // react to dragging left
//    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    NSLog(@"%s %@", __func__, [scrollView class]);
    
    if(scrollView == table0){
        NSLog(@"table0");
    }else if(scrollView == table1){
        NSLog(@"table1");
        
//        if(table1.contentOffset.y)
        NSLog(@"table1.contentOffset.y = %f", table1.contentOffset.y);
        
        //稼動領域を制限するためにはscroll可否ではなく、insetを最初に適切に設定する
        if(table1.contentOffset.y > heightTable1){
//            table1.scrollEnabled = NO;
//            table0.scrollEnabled = YES;
            
            [self pagingProgress];
        }
    }else{
        NSLog(@"table2");
        NSLog(@"table2.contentOffset.y = %f", table2.contentOffset.y);
        if(table2.contentOffset.y < -0){
//            table1.scrollEnabled = YES;
//            table0.scrollEnabled = NO;
            [self pagingReturn];
        }
    }
    
    
    
}

-(void)pagingProgress{
    NSLog(@"paging progress");
    if(!isPaged){
        isPaged = YES;//一度の実行で何度も実行されないようにする
        [table0
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
         atScrollPosition:UITableViewScrollPositionTop
         animated:YES];
        [self performSelector:@selector(setOrdinaryMode)
                   withObject:nil
                   afterDelay:1.0f];
        
        //以下のやり方でやるとスクロールした後の状態（ie.indexRow0Section1)でアニメーションがスタートする
//        [UIView
//         animateWithDuration:0.5f
//         animations:^{
//             [table0 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]
//                           atScrollPosition:UITableViewScrollPositionTop
//                                   animated:NO];
//             
//         }
//         completion:^(BOOL finished){
//             if(finished){
//                 [self setOrdinaryMode];
//             }
//         }];
    }
}

-(void)pagingReturn{
    NSLog(@"paging return");
    if(!isPaged){
        isPaged = YES;//一度の実行で何度も実行されないようにする
        
        
        [table0
         scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
         atScrollPosition:UITableViewScrollPositionTop
         animated:YES];
        [self
         performSelector:@selector(setOrdinaryMode)
         withObject:nil
         afterDelay:1.0f];
//        [UIView
//         animateWithDuration:0.5f
//         animations:^{
//             [table1 scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]
//                           atScrollPosition:UITableViewScrollPositionTop
//                                   animated:NO];
//         }
//         completion:^(BOOL finished){
//             if(finished){
//                 [self setOrdinaryMode];
//             }
//         }];
    }
}



-(void)setOrdinaryMode{
    isPaged = NO;
}

@end
