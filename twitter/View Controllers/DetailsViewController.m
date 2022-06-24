//
//  DetailsViewController.m
//  twitter
//
//  Created by Craig Lee on 6/23/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"


@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIScrollView *detailView;
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (weak, nonatomic) IBOutlet UILabel *numRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numLikes;
@property (weak, nonatomic) IBOutlet UIButton *retweetButton;
@property (weak, nonatomic) IBOutlet UIButton *likeButton;
@property (weak, nonatomic) IBOutlet UILabel *date;


@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self setParams:self.detailTweet];
}

- (void) setParams:(Tweet *)detailTweet {
    self.displayName.text = detailTweet.user.name;
    self.userName.text = detailTweet.user.screenName;
    NSString *URLString = detailTweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    if (self.detailTweet.user.profilePicture != nil) {
        [self.profilePic setImageWithURL:url];
    }
    self.numRetweets.text = [NSString stringWithFormat:@"%i", detailTweet.retweetCount];
    self.numLikes.text = [NSString stringWithFormat:@"%i", detailTweet.favoriteCount];
    
    if (detailTweet.retweeted) {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [self.retweetButton setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    if (detailTweet.favorited) {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [self.likeButton setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    // Configure the input format to parse the date string
    formatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    // Convert String to Date
    NSDate *date = [formatter dateFromString:self.detailTweet.createdAtString];
    // date.
    // Configure output format
    formatter.dateStyle = NSDateFormatterShortStyle;
    formatter.timeStyle = NSDateFormatterNoStyle;
    // Convert Date to String
    self.date.text = [formatter stringFromDate:date];
    self.text.text = detailTweet.text;
}

- (IBAction)tapLike:(id)sender {
    if (self.detailTweet.favorited == NO) {
        self.detailTweet.favorited = YES;
        self.detailTweet.favoriteCount += 1;
        
        [self setParams:self.detailTweet];
        
        [[APIManager shared] favorite:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self.delegate didClickTweet:self.path];
            }
        }];
    } else {
        self.detailTweet.favorited = NO;
        self.detailTweet.favoriteCount -= 1;
        
        [self setParams:self.detailTweet];
        
        [[APIManager shared] unfavorite:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
                [self.delegate didClickTweet:self.path];
            }
        }];
    }
}
- (IBAction)tappedRetweet:(id)sender {
    if (self.detailTweet.retweeted == NO) {
        self.detailTweet.retweeted = YES;
        self.detailTweet.retweetCount += 1;
        
        [self setParams:self.detailTweet];
        [[APIManager shared] retweet:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
                [self.delegate didClickTweet:self.path];
            }
        }];
    } else {
        self.detailTweet.retweeted = NO;
        self.detailTweet.retweetCount -= 1;
        
        [self setParams:self.detailTweet];
        [[APIManager shared] unretweet:self.detailTweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
                [self.delegate didClickTweet:self.path];
            }
        }];
    }
}


@end
