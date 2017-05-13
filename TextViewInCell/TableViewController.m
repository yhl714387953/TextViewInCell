//
//  TableViewController.m
//  TextViewInCell
//
//  Created by L's on 2017/5/13.
//  Copyright © 2017年 zuiye. All rights reserved.
//

#import "TableViewController.h"
#import "LSTextViewCell.h"

@interface TableViewController ()<LSTextViewCellDelegate>

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[LSTextViewCell class] forCellReuseIdentifier:@"cell"];
}

-(void)dealloc{
    NSLog(@"%@销毁了", self.class.description);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
tableView.userInteractionEnabled
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LSTextViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.delegate = self;
    
    __weak typeof(self) weakSelf = self;
    cell.textView.heightDidChangeBlock = ^(NSString *text, CGFloat height) {
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    };
    
    // Configure the cell...
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return UITableViewAutomaticDimension;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewAutomaticDimension;
}

#pragma mark -
#pragma mark - LSTextViewCellDelegate
-(void)textViewCell:(LSTextViewCell *)cell textChange:(NSString *)text{
    NSIndexPath* indexPath = [self.tableView indexPathForCell:cell];
    NSLog(@"%@    %@", indexPath, text);
    //拿到了indexPath 那就做自己需要的工作了
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
