/***QUESTION 4:
Hashtag Researching: A partner brand wants to know, which hashtags to use in the post to reach the most people on the platform.
Your Task: Identify and suggest the top 5 most commonly used hashtags on the platform
**/
# SELECT 

# t.tag_name,
# count(p.photo_id) as num_tags
# from ig_clone.photo_tags p

# INNER JOIN ig_clone.tags t
# ON p.tag_id=t.id

# GROUP BY tag_name

# ORDER BY num_tags desc
# Limit 5
 
/**QUESTION 5
Launch AD Campaign: The team wants to know, which day would be the best day to launch ADs.
Your Task: What day of the week do most users register on? Provide insights on when to schedule an ad campaign
**/

/**0-MONDAY
1-TUESDAY
2-WEDNESDAY
3-THURSDAY
4-FRIDAY
5-SATURDAY
6-SUNDAY
**/

# SELECT 
#   WEEKDAY(created_at) as weekday,
#   count(username) as num_users

# from
# ig_clone.users

# group by 
# weekday

# ORDER BY
# num_users desc


/**QUESTION 6:
User Engagement: Are users still as active and post on Instagram or they are making fewer posts
Your Task: Provide how many times does average user posts on Instagram. Also, provide the total number of photos on Instagram/total number of users
**/

# with CTE as 
# (SELECT 
# 	u.id as users,
#     count(p.id) as photoid
# FROM ig_clone.users as u
# LEFT JOIN ig_clone.photos as p
# on u.id=p.user_id

# group by users)
# select 
# 	sum(photoid) as total_photos,
#     count(users) as total_users,
#     sum(photoid)/count(users) as average
# from CTE  #ntile function for median where we can calculate total no of users
# where photoid>0

/**QUESTION 07:
Bots & Fake Accounts: The investors want to know if the platform is crowded with fake and dummy accounts
Your Task: Provide data on users (bots) who have liked every single photo on the site (since any normal user would not be able to do this).
**/

# SELECT count(*) FROM ig_clone.photos

with photo_count as
(SELECT 
user_id,
count(photo_id) as num_like
FROM ig_clone.likes
GROUP BY user_id
ORDER BY num_like DESC)
SELECT 
* 
FROM photo_count
where num_like=(select count(*) from ig_clone.photos)
