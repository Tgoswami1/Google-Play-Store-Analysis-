--identifiyingnull values--

select * from dbo.googleplaystore
where App is null
or Category is null
or Rating is null
or reviews is null
or Size is null
or Installs is null
or Type is null
or Price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Current_Ver is null
or Android_Ver is null

-- removing null values--

Delete from dbo.googleplaystore
where App is null
or Category is null
or Rating is null
or reviews is null
or Size is null
or Installs is null
or Type is null
or Price is null
or Content_Rating is null
or Genres is null
or Last_Updated is null
or Current_Ver is null
or Android_Ver is null

--Overview of dataset--
SELECT 
COUNT(distinct App) as total_apps,
COUNT(distinct Category) as total_category
FROM  dbo.googleplaystore

--Explore app categories--

select top 5
Category,
COUNT(app) as total_apps
from dbo.googleplaystore
group by Category
order by total_apps desc

-- top rated free apps--
select top 10
App,
Category,
Rating,
Reviews
from dbo.googleplaystore
where Type = 'Free' and Rating <> 'NaN'
order by Rating desc

-- Apps with highest number of reviews--

select top 5
App,
Category,
reviews
from dbo.googleplaystore
order by reviews desc
 
 --Average rating for each category --

 select top 10
 category,
 AVG(TRY_CAST(Rating as float)) as avg_rating
 from dbo.googleplaystore
 group by Category
 order by avg_rating desc

 -- top categories by highest number of installs--

 select top 5
 Category,
 SUM(cast(replace(substring(installs, 1, patindex('%[^0-9]%', installs + ' ') -1), ',', ',' ) as int))
  as total_installs
 from dbo.googleplaystore
 group by Category
 order by total_installs desc

 -- avg sentiment polarity by app category--

 select
 Category,
 AVG(TRY_CAST(Sentiment_Polarity as float)) as avg_seniment_polarity
 from dbo.googleplaystore
 join dbo.googleplaystore_user_reviews
 on dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
 group by Category
 order by avg_seniment_polarity 

 -- sentiment reviews by app category--

 select top 10
 Category,
 Sentiment,
 COUNT(*) as total_sentimments
 from dbo.googleplaystore
 join dbo.googleplaystore_user_reviews
 on dbo.googleplaystore.App = dbo.googleplaystore_user_reviews.App
 where Sentiment <> 'nan'
 group by category, Sentiment
 order by total_sentimments desc
