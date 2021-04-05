package com.example.movies

import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.movies.model.MovieViewModel
import com.squareup.picasso.Picasso

class MyListAdapter(private val movieViewModel: MovieViewModel): RecyclerView.Adapter<MyListAdapter.ViewHolder>(){
    private var myMovieList = movieViewModel.movieList.value

    class ViewHolder(view: View): RecyclerView.ViewHolder(view) {
        val titleTextView: TextView = view.findViewById(R.id.textView)
        val ratingTextView: TextView = view.findViewById(R.id.textView2)
        val imageView: ImageView = view.findViewById(R.id.imageView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        //create an instance of LayoutInflater
        val layoutInflater = LayoutInflater.from(parent.context)
        //inflate the view
        val itemViewHolder = layoutInflater.inflate(R.layout.card_list_item, parent, false)
        return ViewHolder(itemViewHolder)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        //get data at the position
        val movie = myMovieList?.get(position)
        //set the text of the title textview to the name
        holder.titleTextView.text = movie?.title ?: ""

        //set the text of the rating textview to the rating
        holder.ratingTextView.text = "Rating: " + movie?.rating ?: ""

        //load image using Picasso
        Picasso.get().load(movie?.posterURL ?: "")
            .error(R.drawable.image_placeholder)
            .placeholder(R.drawable.image_placeholder)
            .into(holder.imageView);
    }

    override fun getItemCount(): Int {
        if (myMovieList != null) {
            return myMovieList!!.size
        } else return 0
    }

    fun update(){
        myMovieList = movieViewModel.movieList.value
        notifyDataSetChanged()
        Log.i("adapter update", movieViewModel.movieList.value?.size.toString())
    }
}