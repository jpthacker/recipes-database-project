require "recipe_repository"

def reset_recipes_table
    seed_sql = File.read("spec/seeds_recipes.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "recipes_directory_test" })
    connection.exec(seed_sql)
end

RSpec.describe RecipeRepository do
    before(:each) { reset_recipes_table }

    it "returns a respository of recipes" do
        
    end
end