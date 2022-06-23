//
//  TweetCell.m
//  twitter
//
//  Created by Craig Lee on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "APIManager.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setTweet:(Tweet *)tweet {
// Since we're replacing the default setter, we have to set the underlying private storage _movie ourselves.
// _movie was an automatically declared variable with the @propery declaration.
// You need to do this any time you create a custom setter.

    _tweet = tweet;

    self.displayName.text = tweet.user.name;
    self.userName.text = tweet.user.screenName;
    self.date.text = tweet.createdAtString;
    NSString *URLString = tweet.user.profilePicture;
    NSURL *url = [NSURL URLWithString:URLString];
    //NSData *urlData = [NSData dataWithContentsOfURL:url];
    [self.profilePic setImageWithURL:url];
    if (tweet.retweeted) {
        [self.didTapRetweet setImage:[UIImage imageNamed:@"retweet-icon-green"] forState:UIControlStateNormal];
    } else {
        [self.didTapRetweet setImage:[UIImage imageNamed:@"retweet-icon"] forState:UIControlStateNormal];
    }
    
    if (tweet.favorited) {
        [self.didTapLike setImage:[UIImage imageNamed:@"favor-icon-red"] forState:UIControlStateNormal];
    } else {
        [self.didTapLike setImage:[UIImage imageNamed:@"favor-icon"] forState:UIControlStateNormal];
    }
    self.numRetweets.text = [NSString stringWithFormat:@"%i", tweet.retweetCount];
    self.numFavorites.text = [NSString stringWithFormat:@"%i", tweet.favoriteCount];
    self.text.text = tweet.text;
}

- (IBAction)tappedLike:(id)sender {
    // Update the local model of the tweet
    if (self.tweet.favorited == NO) {
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        //update the cell UI
        [self setTweet:self.tweet];        
        
        //Send a POST request to the POST favorites/create endpoint
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
    }  else {
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        [self setTweet:self.tweet];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}
- (IBAction)tappedRetweet:(id)sender {
    if (self.tweet.retweeted == NO) {
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        
        //update the cell UI
        [self setTweet:self.tweet];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    } else {
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        
        //update the cell UI
        [self setTweet:self.tweet];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                 NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
        
    }
}

@end
