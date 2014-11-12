//
//  Type2ViewController.m
//  TestTableInset
//
//  Created by EndoTsuyoshi on 2014/11/09.
//  Copyright (c) 2014年 in.thebase. All rights reserved.
//

#import "Type2ViewController.h"
#import "Type3ViewController.h"

@interface Type2ViewController ()

@end

@implementation Type2ViewController{
    UITableView *table0;
    
    
    CGPoint lastCurrentOffset;
    
    int heightCell;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    
    table0 =
    [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    table0.delegate = self;
    table0.dataSource = self;
//    table0.pagingEnabled = YES;
    table0.pagingEnabled = NO;
//    table0.contentInset = UIEdgeInsetsMake(0, 0, 10, 0);
    [self.view addSubview:table0];
    
    heightCell = self.view.bounds.size.height*2 - 150;
    
    
    
    
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
    return 2;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    //１セルの高さを画面より少し大きくする→insetSizeを定義して下部を少し見せてあげる必要がある
    return heightCell;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
            NSLog(@"indexPath=%d", (int)indexPath.row);
            cell.contentView.backgroundColor = [UIColor whiteColor];
            
            UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"a0.jpg"]];
            imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 300);
            
            [cell.contentView addSubview:imageView];
            
            UILabel *label =
            [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width,
                                                     imageView.bounds.size.height)];
            label.center = CGPointMake(imageView.bounds.size.width/2,
                                       imageView.bounds.size.height/2);
            label.textAlignment = NSTextAlignmentCenter;
            [label setFont:[UIFont boldSystemFontOfSize:30]];
            [label setText:[NSString stringWithFormat:@"header part 0"]];
            [label setTextColor:[UIColor grayColor]];
            [imageView addSubview:label];
            
            
            
            
            NSLog(@"======height = %d", (int)imageView.bounds.size.height);
            UITextView *tv =
            [[UITextView alloc]
             initWithFrame:
             CGRectMake(0, imageView.bounds.size.height,
                        cell.bounds.size.width,
                        cell.bounds.size.height - imageView.bounds.size.height)];
            
            tv.text = @"Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.\nLorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt";
            tv.backgroundColor = [UIColor clearColor];
            tv.textColor = [UIColor blackColor];
            tv.editable = NO;
            [cell.contentView addSubview:tv];
            
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
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%s", __func__);
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if(indexPath.row == 1){
        [self
         dismissViewControllerAnimated:YES
         completion:^{
             NSLog(@"returned from tyep2Viewcontroller");
         }];
    }else{
        //次のビューへ
        Type3ViewController *tvc = [[Type3ViewController alloc]init];
        [self presentViewController:tvc animated:YES completion:nil];
    }
    
    
}



//慣性スクロール完了時
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
    
    
    NSLog(@"paging = %d", scrollView.pagingEnabled);
    
}

//自動スクロール完了時にのみコール
-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    NSLog(@"%s", __func__);
    
    NSLog(@"paging = %d", scrollView.pagingEnabled);
}

//手動スクロール完了時:フリック(decelerate=1)とドラッグ(decelerate=0)時にコール
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView
                 willDecelerate:(BOOL)decelerate{
    NSLog(@"%s decelerate=%d", __func__, decelerate);
    
    NSLog(@"paging = %d", scrollView.pagingEnabled);
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
    NSLog(@"%s paging = %d", __func__, scrollView.pagingEnabled);
    
    
    if(scrollView.contentOffset.y > self.view.bounds.size.height/3){
        NSLog(@"delay");
        table0.decelerationRate = UIScrollViewDecelerationRateFast;
    }else{
        table0.decelerationRate = UIScrollViewDecelerationRateNormal;
    }
    
    
    BOOL isDownScroll;
    CGPoint currentOffset = scrollView.contentOffset;
    if(currentOffset.y > lastCurrentOffset.y){
        //downward
        isDownScroll = YES;
    }else{
        isDownScroll = NO;
    }
    
    lastCurrentOffset = currentOffset;
    
    
//    if(isDownScroll){
    
        
        
        NSArray *arrIndexPathVisible = [table0 indexPathsForVisibleRows];
        
        
        if(arrIndexPathVisible.count == 2){
            NSLog(@"set paging");
            table0.pagingEnabled = YES;
        }else if(arrIndexPathVisible.count == 1){
            table0.pagingEnabled = NO;
            
            NSIndexPath *indexPath = arrIndexPathVisible[0];
            if(indexPath.row == 1){
                NSLog(@"paging ok");
                
                [table0
                 scrollToRowAtIndexPath:indexPath
                 atScrollPosition:UITableViewScrollPositionTop
                 animated:YES];
            }
            indexPath = nil;
        }
//    for(NSIndexPath *indexPath in arrIndexPathVisible){
//
//    }
        arrIndexPathVisible = nil;
    
    if(isDownScroll){
        
    }else{
//        table0.pagingEnabled = NO;
        
        
    }
}

@end
