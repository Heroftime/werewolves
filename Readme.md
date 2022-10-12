# Werewolves game app
This is werewolves game application created in Ruby on Rails 7, below are the instructions on how to run it and how to use it.

## How to run?

### Prerequisites 
1. Please make sure you have latest version of Ruby installed.
2. Git clone this repo.
3. CD to the project dir then run `bundle install`
4. Run the tests `rails test`
5. Run the command: `bin/dev` - This will build TailwindCSS code needed for CSS and then will run the server
6. (OPTIONAL) If step 5 doesn't work, run the command: `rails s`



## How to use the application
1. Upon opening the application browser, you will be redirected to the login page.
2. Click on **Sign Up** Button to register a user.
3. On the Sign Up page, fill the required details. Then you will be redirected to the home page. Create at least 2 players needed for a battle.
4. Then navigate to this url: http://localhost:3000/battles
5. Click on **New Battle** button.
6. On new battle page, Add the following:
    1. Initiator - Id of the person submitting the battle
    2. Opponent - Id of the opponent
    3. Status - Leave that, it is already set as Pending
7. Submit the battle.
8. As soon as the battle is submitted, battle processor will run. 
9. Battle processor can be manually run by doing the following:
    1. Run the command: `rails c`
    2. Then write the code: `BattleProcessorJob.perform_now`
10. Battle processor will run and will do the needful. It will also generate logs, which can be seen in the battle detail page.
11. Leaderboard is here: http://localhost:3000/leaderboard


### For any queries, please let me know :)