package com.example.movies.model

import android.content.ClipData
import android.content.Context
import android.util.Log
import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel
import com.example.movies.util.JSONData

class MovieViewModel: ViewModel() {
    val movieList = MutableLiveData<ArrayList<Movie>>()
}