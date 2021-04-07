package com.example.movies

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import com.example.movies.model.MovieViewModel
import androidx.activity.viewModels
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.movies.util.JSONData

class MainActivity : AppCompatActivity() {

    private val viewModel: MovieViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //only load the JSON data once per app lifetime
        if (viewModel.movieList.value == null){
            val loader = JSONData()
            loader.loadJSON(this, viewModel)
            Log.i("main", "in if to load data")
        }

        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)

        //define an adapter
        val adapter = MyListAdapter(viewModel)

        //assign the adapter to the recycle view
        recyclerView.adapter = adapter

        //create the observer
        viewModel.movieList.observe(this, Observer {
            adapter.update()
        })
    }
}