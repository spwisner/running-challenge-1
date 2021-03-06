# Running Challenge

## Prep For Challenge

Clone the Repository

```bash
git clone git@github.com:spwisner/running-challenge.git
```

Enter the repository folder (running-challenge) and create a new branch that will be called challenge-work (see code).

Code:
```bash
cd running-challenge
git checkout -b my-work
```

Install Dependencies

Code:
```bash
bundle install
```

Create a `.env` for sensitive settings

Code:
```bash
touch .env
```

Copy and Paste the following code in the .env file:

```bash
SECRET_KEY_BASE_DEVELOPMENT=ebe00ac4d9569384d94ad2d68fe187a36f2ea9e8e3b14c3d09b48e8829291ab424fec5b66e18ccd44a16a84d0075d78a48b10d352a0de2ee8ce9486603078085
SECRET_KEY_BASE_TEST=36cb3d1123c8e2a4ee60bda201af664e4d5cc1a254dfb27da67f1035054910a0ba76682a9887fa467948eb8b764a30776e6047427f32740d3f512d6d4a9a8636
```

Build a local database

Code:
```bash
bin/rails db:nuke_pave
```

Run the Server

Code:
```bash
rails s
```

Create User Account (username will be Z@Z and password will be Z - you will not need to deal with manually entering credentials)

Code:
```bash
sh scripts/sign-up.sh
```
Output => {"user":{"id":1,"email":"Z@Z"}}

### Curl Requests:

Step 4 gives an example of a curl request.  **All curl requests will require you to include a user token**.  The user token is printed when you complete the sign-in curl request:

```bash
sh scripts/sign-in.sh
```
Output => {"user":{"id":1,"email":"Z@Z","token":"BAhJIiU1YzFiNjYyY2ZhNTE5ODQ0ODcyMzY5YWIyOWM5NmI3YgY6BkVG--13edc0930cafab1c06b74037b9bf137719bdbab7"}}

I included example curl requests in the "scripts" folder (there is also an example controller, example model, and example serializer)

After you write a curl request using the examples provided in "script" folder, you will run them by typing the following into the command line:

**All curl requests will require that a user be signed-in and have a valid token.  As a result, you must make sure that you include a token in every curl request**

### To Create:

Create Example 1
```bash
TOKEN=BAhJIiU2YzNjOGY3MGI1MGNkZTQ0OWE2NDRkNzUyYmZhYjNjZgY6BkVG--9ac321a2b3d104cf4856b376ace6b2aed42a0e93 TEXT="TEXT ONE" BOOL="true" sh scripts/create-example.sh
```
Output => {"example":{"id":1,"text":"TEXT ONE","bool":true,"editable":true}}

Create Example 2
```bash
TOKEN=BAhJIiU2YzNjOGY3MGI1MGNkZTQ0OWE2NDRkNzUyYmZhYjNjZgY6BkVG--9ac321a2b3d104cf4856b376ace6b2aed42a0e93 TEXT="TEXT TWO" BOOL="false" sh scripts/create-example.sh
```
Output => {"example":{"id":2,"text":"TEXT TWO","bool":false,"editable":true}}

### To Get:
```bash
TOKEN=BAhJIiU2YzNjOGY3MGI1MGNkZTQ0OWE2NDRkNzUyYmZhYjNjZgY6BkVG--9ac321a2b3d104cf4856b376ace6b2aed42a0e93 sh scripts/get-examples.sh
```
Output => {"examples":[{"id":1,"text":"TEXT ONE","bool":true,"editable":true},{"id":2,"text":"TEXT TWO","bool":false,"editable":true}]}

### To Show:
```bash
TOKEN=BAhJIiU2YzNjOGY3MGI1MGNkZTQ0OWE2NDRkNzUyYmZhYjNjZgY6BkVG--9ac321a2b3d104cf4856b376ace6b2aed42a0e93 ID=2 sh scripts/show-examples.sh
```
Output => {"example":{"id":2,"text":"TEXT TWO","bool":false,"editable":true}}

### To Update:
```bash
TOKEN=BAhJIiU2YzNjOGY3MGI1MGNkZTQ0OWE2NDRkNzUyYmZhYjNjZgY6BkVG--9ac321a2b3d104cf4856b376ace6b2aed42a0e93 ID=1 TEXT="Text One Updated" sh scripts/update-example.sh
```
Output => {"example":{"id":1,"text":"Text One Updated","bool":true,"editable":true}}

# Format for Answering Questions

Below is a list of tasks that will need to be completed.  After you complete a given task, you will need to do the following:

  1. Describe (in general), how you completed a goal.  Specifically, please describe if you accomplished your goal by writing code in this repository, or if you used the command line.  **If you use the command line, please cut and paste the command line code into this README file**
  2. Next, save your updated code using git by typing the following into the command line:

  (a) add the code to git
  ```bash
  git add example-file.js
  ```

  or a shortcut for adding multiple files at once:

  ```bash
  git add .
  ```
  (b) commit your work:

  ```bash
  git commit
  ```

  (c) After you type commit, you will be prompted to enter a commit message.  The commit message should always state the question you just completed.  For example: "Answer to Question 2"

  **Note: Close the commit message window in your text editor (e.g. close the atom commit message window.  Your text editor may refuse to let you continue coding until this window is closed.)**

### App Description

Assume we are making an app that keeps track of our runs for the marathon.

We want the user to monitor the following information about his or her daily training runs.  The user wants to be able to store the following information:

1. Date of the Run
1. Difficulty (on a scale of 1 to 10)
1. Distance in Miles
1. Time it took to complete the run
1. Notes

# Questions

### Question 1:
Create a Run Table with the columns: date, difficulty, distance, time, pace, and notes.

**Important: Make sure to include a user reference so that the record is associated with a particular user**

Create the table to be consistant with the information below:


|               | Date   | Difficulty  | Distance  |  Time  | Pace | Notes
| ------------- |:------:| -----------:| -----------:|-----------:|-----------:|-----------:|
| user submits:     | yes   | yes | yes | yes | no | yes
| user receives:    | yes   | yes | yes | yes | yes | yes
| data type     | date   | integer | float | time | time | text

Briefly, how did you approach this problem and create the table?  Did you generate code using the command line?  If so, copy and past the copy in the space below:

**---Your Answer Start---**

First, I generated a scafford of the RunRecord controller:
  ```bash
  bin/rails generate scaffold RunRecord date:date difficulty:integer distance:float time:float pace:float notes:string
  ```

Opening up app/controllers/run_records_controller.rb, I added the following line under the instantiation of the RunRecord object:
  ```ruby
  @run_record.pace = (@run_record.time/@run_record.distance).round(2)
  ```

This generates a value for `pace`.

To permit certain parameters, I also modified the private `run_record_params` method:
  ```ruby
  params.require(:run_record).permit(:date, :difficulty, :distance, :time, :notes)
  ```

In this case, I removed the `:pace` key from `run_record`.

I created a new shell script (`scripts/create-run_record.sh`) with the following text:
  ```bash
  #!/bin/bash

  API="${API_ORIGIN:-http://localhost:4741}"
  URL_PATH="/run_records"
  curl "${API}${URL_PATH}" \
    --include \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Token token=$TOKEN" \
    --data '{
      "run_record": {
        "date": "'"${DATE}"'",
        "difficulty": "'"${DIFFICULTY}"'",
        "distance": "'"${DISTANCE}"'",
        "time": "'"${TIME}"'",
        "pace": "'"${PACE}"'",
        "notes": "'"${NOTES}"'"
      }
    }'

  echo
  ```

Going back to the command line, I had to set attributes individually because I am running on Windows:
  ```bash
  set TOKEN=my_token
  set DATE=2017-01-01
  set DIFFICULTY=4
  set DISTANCE=1.5
  set TIME=15
  set PACE=9
  set NOTES=No notes for this day
  sh scripts/create-run_record.sh
  ```

I added a PACE value just to test and make sure that the `.permit` method was working properly.


On the server shell, I get a message:
  ```bash
  Unpermitted parameter: pace
  ```

which tells me my `.permit` method is working. In the shell, I also get the following output as a result of my curl request:

  ```bash
  {"run_record":{"id":1,"date":"2017-01-01","difficulty":4,"distance":1.5,"time":15.0,"pace":10.0,"notes":"No notes for this day"}}
  ```

This tells me that what I entered has been recorded in the database. The `ID` parameter tells me the record number for this particular user in the database.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**

### Steve Solution Comments

You were correct in using a scaffold.  The only things that is missing from the scaffold is a user reference, which can be included in the scaffold by adding user:references.

user:references creates a column in the RunRecord table which accepts an integer and the value will be that of the current user.  This ensures that only the user with a specific user ID (i.e. the current user) is able to access the data.

### Question 2:
Next, we decided that we want to make certain entries optional, some required, and some not allowed.  Please require the user to enter the date, difficulty, distance, and time of a given run.  Allow users to enter notes if they choose, but make this optional.  Finally, do not allow a user to submit their pace

Note: Submissions that do not include a required field or include a pace (which is not allow) must be rejected and partial records should not be created.  In other words, do not omit or have ruby ignore values that are not allowed.  Instead, reject the entire submission.

Briefly, how did you approach this problem and create the table?  Did you generate code using the command line?  If so, copy and past the copy in the space below:

**---Your Answer Start---**

I added the following section to the `run_record_params` method in `run_records_controller.rb` to reject `pace`:

  ```ruby
  if params[:run_record].values_at(:pace) != [""] and (params[:run_record].has_key?(:pace) == true)
    ActionController::Parameters.action_on_unpermitted_parameters = :raise
  else
    ActionController::Parameters.action_on_unpermitted_parameters = :log
  end
  ```

This will cause an exception to be raised if `pace` is non-empty, and no exception to be raised if either `pace` is left blank (has value of `[""]`) or `pace` was not included in the curl script (has value of `[nil]`).

The following code requires date, difficulty, distance, and time:

  ```ruby
  params[:run_record].require([:date, :difficulty, :distance, :time]) #requires :date, :difficulty, :distance, :time to be as an embedded hash in :run_record
  params.require(:run_record).permit(:date, :difficulty, :distance, :time, :notes) #permits the preceding required parameters to be a part of the :run_record object
  ```

The problem with adding `:distance` or `:time` to the model is that the parameters are processed in the model after the controller. If :pace is calculated in the controller and `:time` is missing, then Ruby will throw an error because `:distance` is being divided by a `nil` value. Therefore, `:time` at least needs to validated in the controller stage.

Now, if either pace is non-empty or any of the required fields are missing, an error is raised to the development environment. For example, an error will return if:

  ```bash
  set PACE=20
  ```

but an error will not return if:

  ```bash
  set PACE=
  ```

or if we change the curl script `create-run_record.sh` to be:

  ```bash
  #!/bin/bash

  API="${API_ORIGIN:-http://localhost:4741}"
  URL_PATH="/run_records"
  curl "${API}${URL_PATH}" \
    --include \
    --request POST \
    --header "Content-Type: application/json" \
    --header "Authorization: Token token=$TOKEN" \
    --data '{
      "run_record": {
        "date": "'"${DATE}"'",
        "difficulty": "'"${DIFFICULTY}"'",
        "distance": "'"${DISTANCE}"'",
        "time": "'"${TIME}"'",
        "notes": "'"${NOTES}"'"
      }
    }'

  echo
  ```

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**

### Steve Comments

***

You took an interesting approach to reject pace.  Probably the easiest way to accomplish the same goal is simply to update the permitted params in the run_records_controller.

If you look at the examples_controller, you will see:

```
def example_params
  params.require(:example).permit(:text, :bool)
end
```

This method permits the user to submit both text and bool data.  However, if you wanted the user to not be able to submit :text, you would simply remove this from the method and have:

```ruby
def example_params
  params.require(:example).permit(:text, :bool)
end
```

By default, if any other params are entered, the controller rejects all submitted values and an error is thrown.  Therefore, it appears that while your way works, it is easier to utilize the permitted params.

### Requiring Values

In terms of requiring something to be entered, this can best be accomplished using the model.  In the run_records model, you would include:

```ruby
# /models/run_record
validates_presence_of :date, :difficulty, :distance, :time
```

### Question 3:
Next, we need to add a validation to the existing table.  Create a validation for difficulty that only accepts submissions that are integers between 1 and 10.  Also, create a validation to make sure that a person has not submitted a future date.

**---Your Answer Start---**

Going into the `run_record.rb` model, I added the following lines of code:

  ```ruby
  validates :difficulty, inclusion: { in: 1..10 }, numericality: { only_integer: true }
  validates_each :date do |record, attr, value|
    record.errors.add(attr, 'date must be before today or today') if value > Date.today
  end
  ```

The line `validates :difficulty, inclusion: { in: 1..10 }, numericality: { only_integer: true }` ensures that `:difficulty` is both an integer and within the range of 1-10. The `numericality` portion is a bit redunant because the difficulty input was already scaffolded as a variable and transferred to the database in the migration as an integer. This was just something I added so that I can learn and test out all the different options to validate a model.

The following lines:

  ```ruby
  validates_each :date do |record, attr, value|
    record.errors.add(attr, 'date must be before today or today') if value > Date.today
  end
  ```

ensure that the value of `:date` is not equal to today. It breaks `:date` down into three components: its record, its attributes, and its value. I only need to compare the value to the Ruby generated `Date.today` object. I tried many different ways and this was the only way that worked. If you can let me know if a better way to do this, I appreciate it.

To test this, I changed:

  ```bash
  set DATE=2018-01-01
  set DIFFICULTY=20
  ```

And ran the `scripts/create-run_record.rb` script. Both inputs generate errors as expected. Both inputs set to appropriate values allow a record to pass, as expected.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**
### Question 4:
We want the average mile pace to be stored in the table without the user having to calculate this information.  Using Ruby, make this calculation for the user and have the results stored in the table

Briefly, how did you approach this problem and create the table?  Did you generate code using the command line?  If so, copy and past the copy in the space below:

**---Your Answer Start---**

This was covered in my results for Question #1. I added this line to my `run_records_controller.rb`:

  ```ruby
  @run_record.pace = (@run_record.time/@run_record.distance).round(2)
  ```

This creates a value for `pace` from `time` and `distance`. Because I do this in the controller, `time` has to be validated in the controller stage, or else a "divided by nil" error will occur. To keep things consistent, I validated the presence/absence of all input variables in the controller stage and validated their values (see Question #3) in the model stage.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**

# COMMENTS TO QUESTION 4:

You did a good job tackling this problem. My only recommendation is how you handled the conditional.

First, you already defined the run_record you are updating by having the following code

```ruby
# i.e.
def set_run_record
  @run_record = RunRecord.find(params[:id])
end
```

First, simplify the run_record_params to the following:

```ruby
def run_record_params
  params.require(:run_record).permit(:date, :difficulty, :distance, :time)
end
```

Then, the update method can be as follows:

```ruby
def update
  # If the params include distance (i.e. the user is updating distance), then distance is assigned this value.  If the user is not updating this value (i.e. the params are set to nil), then the distance will be equal to whatever the  user previously submitted (i.e. what is already stored in the run_record)
  distance = run_record_params['distance'].to_f || @run_record.distance
  time = run_record_params['time'].to_f || @run_record.time

  #Set the pace param to time / distance
  # Note: If the 'pace' param does not exist, writing it in this manner will add the param.
  run_record_params['pace'] = time / distance

  # Finally, the update method executes
    if @run_record.update(run_record_params)
      render json: @run_record
    else
      render json: @run_record.errors, status: :unprocessable_entity
    end
  else
    head :unauthorized
  end
end
```

### Question 5:
We realized that calculating the pace and storing the value creates a problem if someone updates their distance or the time of their run.  Using Ruby, have the pace automatically updated if a user updates either the distance or the time of a given run.

Briefly, how did you approach this problem and create the table?  Did you generate code using the command line?  If so, copy and past the copy in the space below:

**---Your Answer Start---**

I changed the `update` method in `run_records_controller.rb` to reflect the following:

  ```ruby
  def update
    @run_record = RunRecord.find(params[:id])
    params[:run_record][:pace] = (params[:run_record][:time].to_f/params[:run_record][:distance].to_f).round(2)

    if @run_record.update(params.require(:run_record).permit(:distance, :time, :pace))
      render json: @run_record
    else
      render json: @run_record.errors, status: :unprocessable_entity
    end
  end
  ```

The line `@run_record = RunRecord.find(params[:id])` selects the record indicated by the supplied `ID` value.

`params[:run_record][:pace] = (params[:run_record][:time].to_f/params[:run_record][:distance].to_f).round(2)` calculates a new key in `params` called `pace` from the values of `time` and `distance`.

Since the user is only updating `time` and `distance`, if the other inputs are nil, Rails will throw an error. Thus, I had to permit only the parameters that have been imputed/modified for this particular update using this `params.require(:run_record).permit(:distance, :time, :pace)`.

To test, I changed:

  ```bash
  set ID=2
  set DISTANCE=3
  set TIME=26
  ```

on a record with `ID` equal to 2. The code ran appropriately.

# Steve's Comments

**See comments from Question 4**


**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**
### Question 6:

Now, we decide that we need to add a column to the table.  Add a column "Finished" which will accept boolean values.  This represents whether or not a run was complete.  The user will be able to submit this information, which is not required.  However, there will be a default value of false associated with each row.

Briefly, how did you approach this problem and create the table?  Did you generate code using the command line?  If so, copy and past the copy in the space below:

**---Your Answer Start---**

First, I had Rails generate a new migration:

  ```bash
  rails generate migration add_finished_to_run_records finished:bool
  rake db:migrate
  ```

This creates a change in the original migration (adds a column) and allows up to update the schema to reflect the new change.

Then, I had to alter the `run_records_params` method in `run_records_controller.rb` to add `:finished` to the list of permitted, but not required variables:

  ```ruby
  def run_record_params
    ...
    params[:run_record].require([:date, :difficulty, :distance, :time])
    params.require(:run_record).permit(:date, :difficulty, :distance, :time, :notes, :finished)
  end
  ```

I also had to add `:finished` to be one of the update-able inputs:

  ```ruby
  def update
    ...

    if @run_record.update(params.require(:run_record).permit(:distance, :time, :pace, :finished))
      render json: @run_record
    else
      render json: @run_record.errors, status: :unprocessable_entity
    end
  end
  ```

After that, I had to modify the `run_record_serializer.rb` so that `finished` will show up in a POST/GET call:

  ```ruby
  class RunRecordSerializer < ActiveModel::Serializer
    attributes :id, :date, :difficulty, :distance, :time, :pace, :notes, :finished
  end
  ```

Then, after adding appropriate curl options to `scripts/create-run_record.sh` and `scripts/update-run_record.rb`, I set a new value:

  ```bash
  set FINISHED=true
  ```

and ran the code to get `finished` to be a parameter to be added to the table.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**
### Question 7:
Next, we find that no one is using the notes column of the app.  Delete this column.

**---Your Answer Start---**

I generated a new migration using the following code:

  ```bash
  rails generate migration remove_notes_from_run_records notes:string
  rails db:migrate
  ```

Afterwards, I deleted the `:notes` symbol from `run_record_serializer.rb`.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**
### Question 8:
Finally, our users tell us that they do not want to receive all the results.  Instead, they only want the data returned of runs they completed.  Make the necessary changes so that only completed runs are returned

**---Your Answer Start---**

I added the following to the `index` method in `run_records_controller.rb`:

  ```ruby
  def index
    @run_records = RunRecord.all
    @run_records = @run_records.where(:finished => true)
  ...
  end
  ```

This filters out all the `@run_record` values where `:finished` is not `true`. Similiarly, I added the following to the `show` method in `run_records_controller.rb`:

  ```ruby
  def show
    @run_records = @run_records.where(:finished => true)
  ...
  end
  ```

Though if an index is pointed to a record with `:finished` as `false`, then the `show` method returns a `nil` error. Is there a better way to do this?

I tested this by making a few observations that were true for `finished` and a few that were false, and running the `scripts/get-run_records.rb` shell script to see the results.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**


### Bonus 1 - Optional
Update your last answer so that only completed runs in which the runner completes a 5 mile run under 8 minute mile pace get returned.

**---Your Answer Start---**

I modified the `.where` methods found in Question #8 to read:

  ```ruby
  @run_records = @run_records.where(:finished => true).where("distance >= :distcomp AND pace < :pacecomp", distcomp: 5, pacecomp: 8)
  ```

in both the `index` and `show` methods. This filters the results again so that all results need to have a distance of greater than or equal to 5 miles and a pace of less than 8 minutes per mile. As per the last question, all results need to be completed runs.

Testing this with a few different distances and pace times indicates that Rails is able to filter the results appropriately.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**

### Bonus 2 - Optional

Our users tell us that they do not want to receive all the results.  Instead, they only want the data returned of runs they completed.  Make the necessary changes so that only completed runs are returned

**---Your Answer Start---**

same as Question #8.

I added the following to the `index` method in `run_records_controller.rb`:

  ```ruby
  def index
    @run_records = RunRecord.all
    @run_records = @run_records.where(:finished => true)
  ...
  end
  ```

This filters out all the `@run_record` values where `:finished` is not `true`. Similiarly, I added the following to the `show` method in `run_records_controller.rb`:

  ```ruby
  def show
    @run_records = @run_records.where(:finished => true)
  ...
  end
  ```

Though if an index is pointed to a record with `:finished` as `false`, then the `show` method returns a `nil` error. Is there a better way to do this?

I tested this by making a few observations that were true for `finished` and a few that were false, and running the `scripts/get-run_records.rb` shell script to see the results.

**---Your Answer End---**

**--------------------------------------------------**
**--------STOP - Add and Commit Your Work-----------**
**--------------------------------------------------**
