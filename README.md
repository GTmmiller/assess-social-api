# README

In order to run this application run `bundle install` and then `rails s`

Run the tests with `rails t` and add new data to the system via the console with `rails c`


## Design Considerations

With my design I was focused on laying the ground work for a social network api that would scale more easily with new post types.

### Design Shortcuts

* I didn't implement a full User creation/permissions system because the challenge didn't seem focused on security
* I didn't implement jsonbuilders to make the json match what the wireframes displayed. I implemented methods on models that would be needed, but I ran out of time on the display side
* Didn't implement pagination for GitHub due to it being differenf from the pagination I was using with the 

### Design Emphasis

* I wanted to make database decisions that would prevent large amounts of locking on a central table and would conform with what works best with Rails.

* Emphasis on pagination using ids in the timeline feed. Tradeoffs include potentially dropping activity that was fetched, but with creative caching those drops could be used for higher performance on longer scrolling sessions

* Adding a new activity type would be a linear expansion of fetching needed to call the feed once.

* Separate models with separate tables for Posts, Ratings, etc. avoiding one big table and the potenital headache of locking issues on the big single table. Rails also seems to work better with this layout than using "inherited" sql tables

* Calling the github api instead of saving data for now. Could change if we start hitting an api limit or want to cache.

* Custom pagination could be rolled up better into a more modular system

* Tests added to ensure things worked
