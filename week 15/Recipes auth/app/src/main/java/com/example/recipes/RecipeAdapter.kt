package com.example.recipes

import android.content.Intent
import android.net.Uri
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.recipes.model.Recipe
import com.example.recipes.model.RecipeViewModel
import com.firebase.ui.firestore.FirestoreRecyclerAdapter
import com.firebase.ui.firestore.FirestoreRecyclerOptions
import com.google.android.material.snackbar.Snackbar
import com.google.firebase.firestore.ktx.toObject

class RecipeAdapter(options: FirestoreRecyclerOptions<Recipe>, private val viewModel: RecipeViewModel) : FirestoreRecyclerAdapter<Recipe, RecipeAdapter.ViewHolder>(options) {
    class ViewHolder(view: View) : RecyclerView.ViewHolder(view) {
        var nameTextView: TextView = view.findViewById(R.id.textView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): RecipeAdapter.ViewHolder {
        val layoutInflater = LayoutInflater.from(parent.context)
        val recipeViewHolder = layoutInflater.inflate(R.layout.list_item, parent, false)
        return ViewHolder(recipeViewHolder)
    }

    override fun onBindViewHolder(holder: RecipeAdapter.ViewHolder, position: Int, model: Recipe) {
        //use model that is passed in and assign the properties defined in the ViewHolder class
        holder.nameTextView.text = model.name

        //context menu
        holder.itemView.setOnCreateContextMenuListener(){menu, view, menuInfo ->
            //set the menu title
            menu.setHeaderTitle(R.string.delete)

            //add the choices to the menu
            menu.add(R.string.yes).setOnMenuItemClickListener {
                //get recipe that was pressed
                //snapshots gets the array that the adapter is populated with
                //getSnapshot returns the snapshot at the position
                val id = snapshots.getSnapshot(position).id
                //delete item
                viewModel.deleteRecipe(id)
                Snackbar.make(view, R.string.deleteRecipe, Snackbar.LENGTH_LONG)
                    .setAction(R.string.action, null).show()
                true
            }
            menu.add(R.string.no)
        }

        //onclick listener
        holder.itemView.setOnClickListener{view->
            //get recipe that was pressed
            val documentSnapshot = snapshots.getSnapshot(position)
            val recipeURL = documentSnapshot.toObject<Recipe>()?.url
            Log.i("on click listener", recipeURL!!)

            //create new intent
            var intent = Intent()
            intent.action = Intent.ACTION_VIEW
            //var intent = Intent(Intent.ACTION_VIEW, it.context)
            intent.data = Uri.parse(recipeURL)

            //start activity
            view.context.startActivity(intent)
        }
    }
}