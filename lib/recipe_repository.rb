require_relative "recipe"

class RecipeRepository
    def all
        recipes = []
        sql = 'SELECT id, recipe_name, cooking_time, rating FROM recipes;'
        results = DatabaseConnection.exec_params(sql, [])
        results.each do |record|
            recipe = Recipe.new
            recipe.id = record['id']
            recipe.recipe_name = record['recipe_name']
            recipe.cooking_time = record['cooking_time']
            recipe.rating = record['rating']
            recipes << recipe
        end
        recipes
    end

    def find(id)
        sql = 'SELECT id, recipe_name, cooking_time, rating FROM recipes WHERE id = $1;'
        params = [id]
        results = DatabaseConnection.exec_params(sql, params)
        record = results[0]
        recipe = Recipe.new
        recipe.id = record['id']
        recipe.recipe_name = record['recipe_name']
        recipe.cooking_time = record['cooking_time']
        recipe.rating = record['rating']
        recipe
    end
end