//
//  Type3ViewController.m
//  TestTableInset
//
//  Created by EndoTsuyoshi on 2014/11/10.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "Type3ViewController.h"
#define THREASHOLD 150

@interface Type3ViewController ()

@end

@implementation Type3ViewController{
    UITableView *table0;
//    UITableView *table1;
    
    CGPoint lastCurrentOffset;
    
    int heightCell;
    int numberOfCellInTable1;
    
    
    NSMutableArray *arrTable;
    int numberOfSubTable;
    BOOL isDragging;
    BOOL isFirstPaging;
    BOOL isSecondPaging;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSLog(@"self.view at didload = (%d, %d)", (int)self.view.bounds.size.width,
          (int)self.view.bounds.size.height);
    // Do any additional setup after loading the view.
    
    isDragging = false;
    isFirstPaging = false;
    isSecondPaging = false;
    
    heightCell = self.view.bounds.size.height*2 - THREASHOLD;
    numberOfSubTable = 100;
    arrTable = [NSMutableArray array];
    UITableView *subTable;
    for(int i = 0;i < numberOfSubTable;i++){
        subTable = [[UITableView alloc]
                    initWithFrame:
                    CGRectMake(0, 0, self.view.bounds.size.width,
                               heightCell)];
        subTable.delegate = self;
        subTable.dataSource = self;
        [subTable setContentSize:CGSizeMake(self.view.bounds.size.width,
                                            heightCell)];
        subTable.pagingEnabled = NO;
        subTable.scrollEnabled = NO;
        subTable.tag = i;
        [arrTable addObject:subTable];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    NSLog(@"self.view at appear = (%d, %d)", (int)self.view.bounds.size.width,
          (int)self.view.bounds.size.height);
    
    table0 =
    [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table0.delegate = self;
    table0.dataSource = self;
//    table0.pagingEnabled = YES;
    table0.pagingEnabled = NO;
    //    table0.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.view addSubview:table0];
    
    
    numberOfCellInTable1 = 10;
    
    
    
//    table1 =
//    [[UITableView alloc]
//     initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, heightCell)
//     style:UITableViewStyleGrouped];
//    table1.delegate = self;
//    table1.dataSource = self;
//    [table1 setContentSize:CGSizeMake(self.view.bounds.size.width,
//                                      heightCell)];
//    table1.pagingEnabled = NO;
//    table1.scrollEnabled = NO;
    
    
    
    
    
    
    
    
    
    
    [table0 reloadData];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == table0){
        return numberOfSubTable;
    }else{
        return numberOfCellInTable1;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //１セルの高さを画面より少し大きくする→insetSizeを定義して下部を少し見せてあげる必要がある
    if(tableView == table0){
        return heightCell;
    }else{
        return heightCell/numberOfCellInTable1;
    }
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(tableView == table0){
        static NSString *CellIdentifier = nil;
        if(CellIdentifier == nil)
            CellIdentifier =
            [NSString stringWithFormat:@"cell%d", (int)indexPath.row];//unique
        UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        for(UIView *view in cell.subviews){
            NSLog(@"view1 = %@", view);//UITableViewCellScrollView(ios7),UITableViewCellContentView(ios8)
            for(UIView *subview in view.subviews){
                NSLog(@"subview1 = %@", subview);//UITableViewCellContentView(ios7),components(ios8)
//                for(UIView *subview2 in subview.subviews){
//                    NSLog(@"cell1 = %@", subview2);//view
//                    [subview2 removeFromSuperview];//コンテンツビューに貼り付けられたサブビュー
//                }
                [subview removeFromSuperview];
            }
        }
        
        NSLog(@"cell count = %d", (int)arrTable.count);
        if(!arrTable.count)return nil;
        NSLog(@"cell %d", (int)indexPath.row);
        UITableView *table = (UITableView *)arrTable[indexPath.row];
        [table reloadData];
        [cell.contentView addSubview:table];
        table = nil;
        return cell;
        
        switch ((int)indexPath.row) {
            case 0:{
                NSLog(@"indexPath=%d", (int)indexPath.row);
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
//            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a0.jpg"]];
//            imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 300);
//            
//            [cell.contentView addSubview:imageView];
//            
//            UILabel *label =
//            [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
//                                                     imageView.bounds.size.height)];
//            label.center = CGPointMake(imageView.bounds.size.width/2,
//                                       imageView.bounds.size.height/2);
//            label.textAlignment = NSTextAlignmentCenter;
//            [label setFont:[UIFont boldSystemFontOfSize:30]];
//            [label setText:[NSString stringWithFormat:@"header part 0"]];
//            [label setTextColor:[UIColor grayColor]];
//            [imageView addSubview:label];
//            
//            
//            
//            
//            NSLog(@"======height = %d", (int)imageView.bounds.size.height);
//            UITextView *tv =
//            [[UITextView alloc]
//             initWithFrame:
//             CGRectMake(0, imageView.bounds.size.height,
//                        cell.bounds.size.width,
//                        cell.bounds.size.height - imageView.bounds.size.height)];
//            
//            tv.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt";
//            tv.backgroundColor = [UIColor clearColor];
//            tv.textColor = [UIColor blackColor];
//            tv.editable = NO;
//            [cell.contentView addSubview:tv];
                
                
                
                
//                [cell.contentView addSubview:table1];
                [cell.contentView addSubview:(UITableView *)arrTable[indexPath.row]];
                
                
                break;
            }
            case 1:{
                NSLog(@"indexPath = %d", (int)indexPath.row);
                cell.contentView.backgroundColor = [UIColor whiteColor];
                
                //            UIView *topView =
                //            [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                //                                                   150)];
                //            topView.backgroundColor = [UIColor blueColor];
                
                UIImageView *topView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a10.jpg"]];
                topView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 300);
                
                UILabel *label =
                [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                                                         self.view.bounds.size.height)];
                label.center = CGPointMake(topView.bounds.size.width/2,
                                           topView.bounds.size.height/2);
                label.textAlignment = NSTextAlignmentCenter;
                [label setFont:[UIFont boldSystemFontOfSize:30]];
                [label setText:[NSString stringWithFormat:@"header part 1"]];
                [label setTextColor:[UIColor grayColor]];
                [topView addSubview:label];
                [cell.contentView addSubview:topView];
                
                break;
            }
            default:
                break;
        }
        
        return cell;
//    }else if(tableView == table1){
    }else{//factor of tableView-array:arrTable
    
        static NSString *CellIdentifier = nil;
        if(CellIdentifier == nil)
            CellIdentifier =
            [NSString stringWithFormat:@"subcell%d", (int)indexPath.row];//unique
        UITableViewCell *cell =
        [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        //
        if (cell == nil) {
            cell = [[UITableViewCell alloc]
                    initWithStyle:UITableViewCellStyleDefault
                    reuseIdentifier:CellIdentifier];
        }
        
        for(UIView *view in cell.subviews){
            NSLog(@"view1 = %@", view);//UITableViewCellScrollView(ios7),UITableViewCellContentView(ios8)
            for(UIView *subview in view.subviews){
                NSLog(@"subview1 = %@", subview);//UITableViewCellContentView(ios7),components(ios8)
//                for(UIView *subview2 in subview.subviews){
//                    NSLog(@"cell = %@", subview2);//view
//                    [subview2 removeFromSuperview];
//                }
                [subview removeFromSuperview];
            }
        }
        
        
        
        cell.contentView.backgroundColor =
        [UIColor colorWithRed:1.f-.1f*indexPath.row
                        green:MIN(.1f*tableView.tag, 1.f)
                         blue:MIN(.1f*indexPath.row,1.f)
                        alpha:1.f];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,100)];
        label.center = CGPointMake(self.view.bounds.size.width/2,
                                   cell.bounds.size.height/2);
        NSLog(@"section = %d, row = %d, color = %@",
              (int)indexPath.section, (int)indexPath.row,
              cell.contentView.backgroundColor);
        [label setText:[NSString stringWithFormat:@"%d : %d", (int)tableView.tag, (int)indexPath.row]];
        [label setTextColor:[UIColor whiteColor]];
        [label setFont:[UIFont boldSystemFontOfSize:30.f]];
        [cell.contentView addSubview:label];
        
//        switch (indexPath.row) {
//            case 0:{
//                NSLog(@"indexPath=%d", (int)indexPath.row);
//                cell.contentView.backgroundColor = [UIColor whiteColor];
//            }
//            case 1:{
//                NSLog(@"indexPath=%d", (int)indexPath.row);
//                cell.contentView.backgroundColor = [UIColor blackColor];
//            }
//        }
        
        return cell;
    
    }
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __func__);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    

    [self
     dismissViewControllerAnimated:YES
     completion:^{
         NSLog(@"returned from tyep2Viewcontroller");
     }];
}



//慣性スクロール完了時
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
    return;
    
    if(isFirstPaging){
        table0.scrollEnabled = YES;
    }
    
    
}

//自動スクロール完了時にのみコール:がっちゃん終了時
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
    
    NSLog(@"paging = %d", scrollView.pagingEnabled);
    
    return;//test
    
    
    //didEndScrollingAnimationでpagingがオンになっているときはがっちゃんページングが完了した時
    if(isFirstPaging){
        isFirstPaging = false;//test
        table0.scrollEnabled = YES;
        
        return;
        
        //新しいセルを取得する
        NSArray *arrIndexPath = [table0 indexPathsForVisibleRows];
        if(arrIndexPath.count > 1){
        
            //ページャブルをオフにする
            table0.pagingEnabled = false;
            [table0
             scrollToRowAtIndexPath:arrIndexPath[1]
             atScrollPosition:UITableViewScrollPositionTop
             animated:YES];
            
        }else{
            
        }
    }
}

//didScrollで毎カウントステータスを判断し、endDragging,endDecelerate等でアクションを定義するのが綺麗かもしれない

//手動スクロール完了時:フリック(decelerate=1)とドラッグ(decelerate=0)時にコール
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    
    isDragging = false;
    NSLog(@"%s decelerate=%d", __func__, decelerate);
    
    NSLog(@"paging = %d", scrollView.pagingEnabled);
}

//ドラッグ（フリック）し始めたタイミング
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    CGPoint translation = [scrollView.panGestureRecognizer translationInView:scrollView.superview];
    NSLog(@"%s : %f, %f", __func__, translation.x, translation.y);
    
    isDragging = true;
//    if(translation.x > 0)
//    {
//        // react to dragging right
//    } else
//    {
//        // react to dragging left
//    }
}

//閾値を超えた際のページングと下方向スクロールをした時のページングがある
//閾値を超えた際のページングが終わった後(didEndScroll?didEndDecelerating)、下方向ならページング、上方向ならpagingEnabledをオフ
//to do : 閾値以上になったらpagingをオンにしてスクロール禁止＆pagingEnabled、停止(o:didEndScroll,x:didEndDecelerate)したらスクロール可能＆ページングオフにする
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    if(isFirstPaging)return;//ページング中の悪さしてないか確認
    NSLog(@"scrollEnabled = %d, pagingEnabled = %d, isFirstPaging = %d, isSecondPaging = %d at y=%d",
          table0.scrollEnabled, table0.pagingEnabled, isFirstPaging, isSecondPaging, (int)table0.contentOffset.y);
    //スクロールできるのはtable0のみで、arrTableはセル位置
    if(scrollView == table0){
        
        
        
        //方向算出モジュール：使っているのは第二ページングのときのみであるが、以下のisPagingの時のみにしてしまうとlastCurrentOffsetが取得できないのでだめ
        BOOL isDownScroll;
        CGPoint currentOffset = scrollView.contentOffset;
        //        if(isDragging && currentOffset.y > lastCurrentOffset.y){
        if(currentOffset.y > lastCurrentOffset.y){
            //downward
            isDownScroll = YES;
            
            
//ブレーキ
//            if(scrollView.contentOffset.y > self.view.bounds.size.height/3){
//                NSLog(@"delay");
//                table0.decelerationRate = UIScrollViewDecelerationRateFast;
//            }else{
//                table0.decelerationRate = UIScrollViewDecelerationRateNormal;
//            }
            
            
            
        }else{
            isDownScroll = NO;
//            [self setOrdinaryStatusTable];
        }
        
        lastCurrentOffset = currentOffset;
        //方向算出モジュール
        
        
        
        //ブレーキモジュール:できれば毎回計算するんじゃなくて、ページングのときだけにして、あとは保有して同じ値を参照するようにすべき
        int y = table0.contentOffset.y;
        //table0のセル番号とoffset位置からブレーキをかけるかどうか判定
        NSArray *arrIndexPathsVisible = [table0 indexPathsForVisibleRows];
        //check
        for(NSIndexPath *indexPath in arrIndexPathsVisible){
            NSLog(@"visible indexPath = %@", indexPath);
        }
        
        NSLog(@"arrIndexPaths.count = %d", (int)arrIndexPathsVisible.count);
        
        
        //今見えているセルは最大でも二つ
        //→前のセルの番号Nを取得
        NSIndexPath *indexPathBefore = (NSIndexPath *)arrIndexPathsVisible[0];
        int removeHeight = 0;
        UITableView *tableBeforeToRemoveHeight = nil;//以前の全テーブルの高さを取得するため
        //０からN-1までのテーブルの高さを積み重ねる：removeHeight
        for(int i = 0 ;i <= indexPathBefore.row-1;i++){
            NSLog(@"i = %d", i);
            tableBeforeToRemoveHeight = arrTable[i];
            removeHeight += tableBeforeToRemoveHeight.contentSize.height;
        }
        //offsetからHを差し引いた値がセルNのoffsetとなる（arrTableの要素はスクロールされないので位置が取得できないため！）
        int nowTableContentOffsetY = y - removeHeight;//subTable=arrTable[indexPathBefore.row]におけるoffset位置
        NSLog(@"tableBeforeNo = %d, nowTableContentOffsetY = %d, removeHeight = %d",
              (int)indexPathBefore.row,
              nowTableContentOffsetY,
              removeHeight);
        
        
        UITableView *tableNow = arrTable[indexPathBefore.row];
//        int offsetInSubTable = tableNow.contentSize.height - nowTableContentOffsetY;
        
        //nowtableContentOffsetYがsubviewの高さの３分の１以上ならばブレーキをかける
        if(nowTableContentOffsetY > tableNow.contentSize.height/3){
            table0.decelerationRate = UIScrollViewDecelerationRateFast;
            NSLog(@"ブレーキ稼働");
        }else{
            table0.decelerationRate = UIScrollViewDecelerationRateNormal;
            NSLog(@"ブレーキ解除");
        }
        
        //ブレーキモジュール完了
        
        
        
        //第一ページング
        //to do : 閾値以上になったらpagingをオンにしてスクロール禁止、停止(didEndScroll)したらスクロール可能＆ページングオフにする
        
//        if(isDownScroll){
//            if(isDragging){
//                [self setOrdinaryStatusTable];
//            }
//        }else if(!isFirstPaging && !isSecondPaging){
        
        if(!isFirstPaging && !isSecondPaging){
            if(arrIndexPathsVisible.count > 1){//二つ以上のセルが見えている状態で
                CGRect rectNextCell = [table0 rectForRowAtIndexPath:arrIndexPathsVisible[1]];
                NSLog(@"dispalying next cell indexPath.row = %d", (int)((NSIndexPath *)arrIndexPathsVisible[1]).row);
                NSLog(@"nowTableContentOffsetY = %d", nowTableContentOffsetY);
                NSLog(@"rectNextCell.origin.y = %d, removeHeight = %d, THREASHOLD = %d, self.view.bounds.size.height = %d, sum = %d",
                      (int)rectNextCell.origin.y, removeHeight, THREASHOLD, (int)self.view.bounds.size.height,
                      (int)(rectNextCell.origin.y - removeHeight + THREASHOLD + 10 - self.view.bounds.size.height));
                
                if(nowTableContentOffsetY >
                   rectNextCell.origin.y - removeHeight + THREASHOLD + 10 - self.view.bounds.size.height){//閾値以上ならば
                    NSLog(@"drive at offset = %d", (int)table0.contentOffset.y);
                    int y = (int)rectNextCell.origin.y + THREASHOLD - self.view.bounds.size.height;
                    //test:閾値ギリギリで固定する
                    isFirstPaging = YES;
                    
                    //参考：ここを実行しないと上まで手動スクロールできるようになる
                    table0.scrollEnabled = NO;//didEndScrollで解除する必要がある
                    
                    [UIView
                     animateWithDuration:0.5f
                     animations:^{
                         
                        [table0
                         scrollRectToVisible:
                         CGRectMake(0, y,//直接table0.contentOffset.yを書いてしまうとアニメーションの途中で随時参照してしまう
                                    self.view.bounds.size.width,
                                    self.view.bounds.size.height)
                         animated:NO];
                     }
                     completion:^(BOOL finished){
                         if(finished){
                             table0.pagingEnabled = YES;
                             table0.scrollEnabled = YES;//自動スクロールが完了したらスクロールできるようにする制御
                             NSLog(@"drive finished");
                             
                         }
                     }];
                    
                    NSLog(@"drive over threashold");
                    
                    return;
                    //この後の制御文は第一ページングの後のスクロール
                }
            }
        }
        //第一ページング終了
        
        
        
        
        
        //疑問：少しでも下スクロールした時にデフォルトページングが走るのかどうか
        //→その間は
        
        //第一ページングの後のスクロール時で、第二ページング中ではないとき）
        NSLog(@"isFirstPaging=%d, isSecondPaging=%d, isDownScroll=%d", isFirstPaging, isSecondPaging, isDownScroll);
        if(isFirstPaging && !isSecondPaging){
            NSLog(@"第二ページング開始");
            
            if(isDownScroll){
                
                NSLog(@"下方向");
                isSecondPaging = YES;
                table0.scrollEnabled = NO;

                
                //下向きならば第二ページング
                table0.pagingEnabled = NO;
//                if(!table0.pagingEnabled){
//                    NSLog(@"うそだろ？！第二ページング開始時にページングがNO");
//                    return;
//                }else{
//                    
//                }
                
                NSArray *arrVisibleIndexPaths = [table0 indexPathsForVisibleRows];
                if(arrVisibleIndexPaths.count != 2){
                    NSLog(@"可視セル数が異常 : 終了");
                    return;
                }
                
                NSLog(@"第二ページングアニメーション開始 : visibleCells = %d & %d",
                      (int)((NSIndexPath *)arrVisibleIndexPaths[0]).row,
                      (int)((NSIndexPath *)arrVisibleIndexPaths[1]).row);
                
                //後者（次の）セルのインデックスパスを取得
                NSIndexPath *indexPath = (NSIndexPath *)arrVisibleIndexPaths[1];
                [table0
                 scrollToRowAtIndexPath:indexPath
                 atScrollPosition:UITableViewScrollPositionTop
                 animated:YES];
                [self performSelector:@selector(processAfterSecondPaging)
                           withObject:nil
                           afterDelay:.7f];
                
                
                
                //アニメーションを使うと実行後の状態（arrVisibleIndexPath[0]が空白で繊維してしまう)
//                [UIView
//                 animateWithDuration:.5f
//                 animations:^{
//                     [table0
//                      scrollToRowAtIndexPath:indexPath
//                      atScrollPosition:UITableViewScrollPositionTop
//                      animated:NO];
//                 }
//                 completion:^(BOOL finished){
//                     if(finished){
//                         [self processAfterSecondPaging];
//                     }
//                 }];
                
                indexPath = nil;
                arrVisibleIndexPaths = nil;
                //第二ページングが完了したらisPaging=falseに設定
                
                
            }else{
                //上向きならばページング解除
//                table0.pagingEnabled = false;
                if(isDragging)
                [self setOrdinaryStatusTable];
                
            }
            
            
            
        }
        
        
        
        //paging
        //二つ以上見えているとき（それ以上見えていることはない）でかつ、ページングアニメーション
//        if(!isPaging && arrIndexPaths.count > 1){
////            if(arrIndexPaths[1])
//            //次のセル位置
//            CGRect rectNextCell = [table0 rectForRowAtIndexPath:arrIndexPaths[1]];
////            UITableViewCell *cellNext = [table0 cellForRowAtIndexPath:arrIndexPaths[1]];
//            //次のセルの位置＋閾値ー画面高さ
//            if(nowTableContentOffsetY >
//               rectNextCell.origin.y + THREASHOLD + 10 - self.view.bounds.size.height){
//                table0.pagingEnabled = YES;
//                isPaging = YES;
//            }else{
//                //pagingEnabledをfalseにするのはdidEndScrollが起動した時
////                table0.pagingEnabled = NO;
////                isPaging = NO;
//            }
////            cellNext = nil;
//        }else{
////            table0.pagingEnabled = NO;
//        }
//        NSLog(@"paging = %d", table0.pagingEnabled);
        
        
        
        
//        if(arrIndexPaths.count > 1){
//            NSLog(@"set page");
//            table0.pagingEnabled = YES;
//        }else if(arrIndexPaths.count == 1){
////            table0.pagingEnabled = NO;
//            
//            if(arrIndexPaths.count > 1){
//                NSIndexPath *indexPath = arrIndexPaths[1];
////            if(indexPath.row == 1){//次のセルしか見えてなければ（実際には１だけではなく、次のセルのindexPathさえ取得できればいい
//                NSLog(@"paging ok");
//                
//                [table0
//                 scrollToRowAtIndexPath:indexPath
//                 atScrollPosition:UITableViewScrollPositionTop
//                 animated:YES];
////            }
//                indexPath = nil;
//            }
//        }
        
        
        indexPathBefore = nil;
        arrIndexPathsVisible = nil;
        tableNow = nil;
        
        
        
        
        
        
//        NSArray *arrIndexPathVisible = [table0 indexPathsForVisibleRows];
//        
//        
//        if(arrIndexPathVisible.count == 2){
//            NSLog(@"set paging");
//            table0.pagingEnabled = YES;
//        }else if(arrIndexPathVisible.count == 1){
//            table0.pagingEnabled = NO;
//            
//            NSIndexPath *indexPath = arrIndexPathVisible[0];
//            if(indexPath.row == 1){
//                NSLog(@"paging ok");
//                
//                [table0
//                 scrollToRowAtIndexPath:indexPath
//                 atScrollPosition:UITableViewScrollPositionTop
//                 animated:YES];
//            }
//            indexPath = nil;
//        }
////    for(NSIndexPath *indexPath in arrIndexPathVisible){
////
////    }
//        arrIndexPathVisible = nil;
//        
//        if(isDownScroll){
//            
//        }else{
//            //        table0.pagingEnabled = NO;
//        }
    }else{
        //arrTableの要素
        UITableView *table = (UITableView *)scrollView;
        NSLog(@"y=%.1f, table = %@", table.contentOffset.y, table);
        
        table = nil;
        
    }
}


-(void)processAfterSecondPaging{
    NSLog(@"第二ページング終了");
    table0.scrollEnabled = YES;
    isSecondPaging = false;
    isFirstPaging = false;//このタイミングで反転させるのか自信ない：上記のif(isFirstPaging...を通さないためという目的）
}


-(void)setOrdinaryStatusTable{
    table0.scrollEnabled = YES;
    table0.pagingEnabled = NO;
    isSecondPaging = false;
    isFirstPaging = false;
    isSecondPaging = false;
}

@end
