# Recipes Model and Repository Classes Design Recipe

## User Stories

```
    As a food lover,
    So I can stay organised and decide what to cook,
    I'd like to keep a list of all my recipes with their names.

    As a food lover,
    So I can stay organised and decide what to cook,
    I'd like to keep the average cooking time (in minutes) for each recipe.

    As a food lover,
    So I can stay organised and decide what to cook,
    I'd like to give a rating to each of the recipes (from 1 to 5).
```

## 1. The Table


```
# EXAMPLE

Table: recipes

Columns:
id | name | cooking_time | rating
```

```sql
CREATE TABLE recipes (
  id SERIAL PRIMARY KEY,
  recipe_name text,
  cooking_time text,
  rating int
);
```

## 2. The test SQL seeds

Your tests will depend on data stored in PostgreSQL to run.

If seed data is provided (or you already created it), you can skip this step.

```sql
TRUNCATE TABLE recipes RESTART IDENTITY;

INSERT INTO recipes (recipe_name, cooking_time, rating) VALUES ('Aubergine Curry', '40:00' 8);
INSERT INTO recipes (recipe_name, cooking_time, rating) VALUES ('Fennel Pasta', '30:00' 9);
```

```bash
psql -h 127.0.0.1 your_database_name < seeds_{table_name}.sql
```

## 3. The classes

```ruby
# EXAMPLE
# Table name: students

# Model class
# (in lib/album.rb)
class Recipe
    attr_accessor :id, :title, :release_year, :artist_id
end

# Repository class
# (in lib/albums_repository.rb)
class RecipeRepository
    # Selecting all records
  # No arguments
  def all
    # Executes the SQL query:
    # SELECT id, recipe_name, cooking_time, rating FROM recipes;

    # Returns an array of recipe objects.
  end

  # Gets a single record by its ID
  # One argument: the id (number)
  def find(id)
    # Executes the SQL query:
    # SELECT id, recipe_name, cooking_time, rating FROM rating WHERE id = $1;

    # Returns a single Recipe object.
  end
end
```

## 4. The Model class

Define the attributes of your Model class. You can usually map the table columns to the attributes of the class, including primary and foreign keys.

```ruby
class Recipe

  # Replace the attributes by your own columns.
  attr_accessor :id, :recipe_name, :cooking_time, :rating
end
```

## 5. Test Examples

Write Ruby code that defines the expected behaviour of the Repository class, following your design from the table written in step 5.

These examples will later be encoded as RSpec tests.

```ruby
# EXAMPLES

# 1
# Get all recipes

repo = RecipeRepository.new

recipes = repo.all

recipes.length # =>  2

recipes[0].id # =>  1
recipes[0].recipe_name # =>  'Aubergine Curry'
recipes[0].cooking_time # =>  '40:00'
recipes[0].rating # => 8

recipes[1].id # =>  2
recipes[1].recipe_name # =>  'Fennel Pasta'
recipes[1].cooking_time # => '30:00'
recipes[1].rating # => 9

# 2
# Get a single album

repo = RecipeRepository.new

recipe = repo.find(1)

recipe.id # =>  1
recipe.recipe_name # =>  'Aubergine Curry'
recipe.cooking_time # =>  '40:00'
recipe.rating # => 8

repo = RecipeRepository.new

recipe = repo.find(2)

recipe.id # =>  2
recipe.recipe_name # =>  'Fennel Pasta'
recipe.cooking_time # => '30:00'
recipe.rating # => 9
```

Encode this example as a test.

## 7. Reload the SQL seeds before each test run

Running the SQL code present in the seed file will empty the table and re-insert the seed data.

This is so you get a fresh table contents every time you run the test suite.

```ruby
# EXAMPLE

# file: spec/student_repository_spec.rb

def reset_students_table
  seed_sql = File.read('spec/seeds_students.sql')
  connection = PG.connect({ host: '127.0.0.1', dbname: 'students' })
  connection.exec(seed_sql)
end

describe StudentRepository do
  before(:each) do 
    reset_students_table
  end

  # (your tests will go here).
end
```

## 8. Test-drive and implement the Repository class behaviour

_After each test you write, follow the test-driving process of red, green, refactor to implement the behaviour._