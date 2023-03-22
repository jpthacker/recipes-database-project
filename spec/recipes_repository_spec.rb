require "recipe_repository"

def reset_recipes_table
    seed_sql = File.read("spec/seeds_recipes.sql")
    connection = PG.connect({ host: "127.0.0.1", dbname: "recipes_directory_test" })
    connection.exec(seed_sql)
end

RSpec.describe RecipeRepository do
    before(:each) { reset_recipes_table }

    it "returns a respository of recipes" do
        repo = RecipeRepository.new

        recipes = repo.all

        expect(recipes.length).to eq 2

        expect(recipes[0].id).to eq '1'
        expect(recipes[0].recipe_name).to eq 'Aubergine Curry'
        expect(recipes[0].cooking_time).to eq '40:00'
        expect(recipes[0].rating).to eq '8'

        expect(recipes[1].id).to eq  '2'
        expect(recipes[1].recipe_name).to eq  'Fennel Pasta'
        expect(recipes[1].cooking_time).to eq '30:00'
        expect(recipes[1].rating).to eq '9'
    end
end