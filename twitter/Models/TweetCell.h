//
//  TweetCell.h
//  twitter
//
//  Created by Craig Lee on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Tweet.h"

NS_ASSUME_NONNULL_BEGIN

@interface TweetCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *displayName;
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UILabel *numRetweets;
@property (weak, nonatomic) IBOutlet UILabel *numFavorites;
@property (weak, nonatomic) IBOutlet UILabel *text;
@property (nonatomic, strong) Tweet *tweet; // Display date
@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UIButton *didTapReply;
@property (weak, nonatomic) IBOutlet UIButton *didTapRetweet;
@property (weak, nonatomic) IBOutlet UIButton *didTapLike;

@end

NS_ASSUME_NONNULL_END
