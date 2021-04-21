package com.example.recipes.model

import androidx.lifecycle.ViewModel
import com.example.recipes.util.RecipeDatabase

class RecipeViewModel: ViewModel() {
    private val recipedb = RecipeDatabase()
    val options = recipedb.getOptions()

    fun addRecipe(recipe: Recipe){
        recipedb.addRecipe(recipe)
    }

    fun deleteRecipe(id: String){
        recipedb.deleteRecipe(id)
    }
}