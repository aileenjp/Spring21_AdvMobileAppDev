package com.example.movies.model

import android.content.Context
import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.movies.util.JSONData

class MovieViewModel: ViewModel() {
    val movieList = MutableLiveData<ArrayList<Movie>>()

    fun loadData(context: Context){
        val loader = JSONData()
        movieList.value = loader.getJSON(context)
        Log.i("vm load data list value", movieList.value?.size.toString())
    }
}