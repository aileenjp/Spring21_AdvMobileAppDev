package com.example.recipes.util

import com.example.recipes.model.Recipe
import com.firebase.ui.firestore.FirestoreRecyclerOptions
import com.google.firebase.firestore.CollectionReference
import com.google.firebase.firestore.FirebaseFirestore
import com.google.firebase.firestore.Query

class RecipeDatabase {
    //Firestore instance
    private val db: FirebaseFirestore = FirebaseFirestore.getInstance()

    //recipe collection
    private val recipeRef: CollectionReference = db.collection("recipes")

    //FirestoreRecycler options for the adapter
    fun getOptions(): FirestoreRecyclerOptions<Recipe> {
        //define query
        val query: Query = recipeRef
        val options = FirestoreRecyclerOptions.Builder<Recipe>()
            .setQuery(query, Recipe::class.java)
            .build()
        return options
    }

    fun addRecipe(recipe: Recipe){
        recipeRef.add(recipe)
    }

    fun deleteRecipe(id: String){
        recipeRef.document(id).delete()
    }
}