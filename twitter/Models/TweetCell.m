//
//  TweetCell.m
//  twitter
//
//  Created by Craig Lee on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"

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
//    if (tweet.retweeted) {
//        self.didTapRetweet.currentImage = retwee
//    }
    self.numRetweets.text = [NSString stringWithFormat:@"%i", tweet.retweetCount];
    self.numFavorites.text = [NSString stringWithFormat:@"%i", tweet.favoriteCount];
    self.text.text = tweet.text;
}

@end
