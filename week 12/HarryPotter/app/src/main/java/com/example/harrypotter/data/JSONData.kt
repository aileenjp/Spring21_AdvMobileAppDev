package com.example.harrypotter.data

import android.content.Context
import android.util.Log
import com.example.harrypotter.R
import com.example.harrypotter.model.Character
import org.json.JSONException
import org.json.JSONObject

class JSONData() {
    var characterList = ArrayList<Character>()

    fun getJSON(context: Context): ArrayList<Character>{
        Log.i("info", "in get json")
        var json = loadJSONFromRes(context)
        characterList = parseJSON(json)
        return characterList
    }

    fun loadJSONFromRes(context: Context): String{
        //opens the raw JSON file and assigns it to an InputStream instance
        val inputStream = context.resources.openRawResource(R.raw.harrypotter)

        //creates a buffered reader on the InputStream and readText() returns a String
        val jsonString = inputStream.bufferedReader().use {it.readText()}
        return jsonString
    }

    fun parseJSON(jsonString: String): ArrayList<Character>{
        try {
            //create JSONObject
            val jsonObject = JSONObject(jsonString)

            //create JSONArray with the value from the characters key
            val characterArray = jsonObject.getJSONArray("characters")

            //loop through each object in the array
            for (i in 0 until characterArray.length()){
                val item = characterArray.getJSONObject(i)

                //get values for name and info keys
                val name = item.getString("name")
                val info = item.getString("info")

                //create new Character object
                val newCharacter = Character(name, info)

                //add character object to our ArrayList
                characterList.add(newCharacter)
            }
        } catch (e: JSONException) {
            e.printStackTrace()
        }
        return characterList
    }
}