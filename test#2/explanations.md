# Notification Implementation
-------------------------------

## DB schema and Model
We could imagine that the app has this kind of DB schema :

### Tasks

| Field | Type |
|:-----:|:----:|
| id    | bigint|
| title | string |
| done  | boolean |
|  due_date | datetime |
| user_id | bigint |

-> foreign_key: user_id

Then we could add a ```:late``` scope to the task model to query the tasks which aren't done and which due date is in the past.

---------------

### For situation A

We could make a controller in stimulus that fetch the current_user tasks that aren't done (if there are any) after the page has finished loading and display them at the right of the navbar. We could for example have an action in the tasks controller that query the late tasks and then render them in an html partial and send the partials as a string using render_as_string. Then we take the html code in the stimulus controller and append it to the navbar.

--------------

### For situation B

We could use a cron job (using the whenever gem or heroku scheduler) to execute a rake task every week on tuesday at midnight.
The rake task would send an email in a background job to the persons who have late tasks.
