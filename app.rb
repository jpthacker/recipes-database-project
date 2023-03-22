require_relative 'lib/database_connection'
require_relative 'lib/recipe_repository'

# We need to give the database name to the method `connect`.
DatabaseConnection.connect('recipes_directory')

recipe_repo = RecipeRepository.new
recipes = recipe_repo.all

recipes.each do |recipe|
    puts "Recipe: #{recipe.recipe_name}, cooking time: #{recipe.cooking_time}, rating: #{recipe.rating}"
end