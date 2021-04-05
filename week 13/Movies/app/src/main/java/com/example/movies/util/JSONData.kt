package com.example.movies.util

import android.content.Context
import android.util.Log
import com.android.volley.Request
import com.android.volley.Response
import com.android.volley.toolbox.StringRequest
import com.android.volley.toolbox.Volley
import com.example.movies.model.Movie
import org.json.JSONException
import org.json.JSONObject

class JSONData {
    val dataList = ArrayList<Movie>()
    val api_url = "https://api.themoviedb.org/3/movie/top_rated?api_key="
    val api_key = "9bc41deb95194da5e8865be1fe7750a4"

    fun getJSON(context: Context): ArrayList<Movie>{

        var json = loadJSON(context)
        return dataList
    }

    fun loadJSON(context: Context) {
        val url = api_url + api_key

        // instantiate the Volley request queue
        val queue = Volley.newRequestQueue(context)

        // Request a string response from the provided URL.
        val stringRequest = StringRequest(
            Request.Method.GET, url,
            Response.Listener<String> { response ->
                parseJSON(response)
            },
            Response.ErrorListener {
                Log.e("ERROR", error("request failed"))
            })

        // Add the request to the RequestQueue.
        queue.add(stringRequest)
    }

    fun parseJSON(response: String){
        // Base url for the posters
        val poster_base_url = "https://image.tmdb.org/t/p/w185"

        try {
            //create JSONObject
            val jsonObject = JSONObject(response)

            //create JSONArray with the value from the results key
            val resultsArray = jsonObject.getJSONArray("results")

            //loop through each object in the array
            for (i in 0 until resultsArray.length()){
                val movieObject = resultsArray.getJSONObject(i)

                //get values
                val id = movieObject.getInt("id")
                val title = movieObject.getString("title")
                //save the fully qualified URL for the poster image
                val posterURL = poster_base_url + movieObject.getString("poster_path")
                val rating = movieObject.getDouble("vote_average").toString()

                //create new movie object
                val newMovie = Movie(id, title, posterURL, rating)

                //add character object to our ArrayList
                dataList.add(newMovie)
            }
        } catch (e: JSONException) {
            e.printStackTrace()
        }
        Log.i("json data list value", dataList.size.toString())
    }
}