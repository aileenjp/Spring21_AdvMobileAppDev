package com.example.list.util

import android.content.Context
import android.util.Log
import com.example.list.model.Item

class SharedPrefsData {
    private val prefs_file = "ITEMS"

    fun saveDataSharedPrefs(itemList: ArrayList<Item>, context: Context) {
        //get access to a shared preferences file
        val sharedPrefs = context.getSharedPreferences(prefs_file, Context.MODE_PRIVATE)
        //create an editor to write to the shared preferences file
        val editor = sharedPrefs.edit()
        //add size to the editor
        if (itemList != null) {
            editor.putInt("size", itemList.size)
        }
        for ((index, item) in itemList.withIndex()){
            editor.putString("item$index", item.name)
        }
        //save the data
        editor.apply()
    }

    fun loadDataSharedPrefs(context: Context):ArrayList<Item>{
        var loadedItemList = ArrayList<Item>()
        //get access to a shared preferences file
        val sharedPrefs = context.getSharedPreferences(prefs_file, Context.MODE_PRIVATE)
        val size = sharedPrefs.getInt("size", 0)
        for (i in 0 until size){
            loadedItemList.add(Item(sharedPrefs.getString("item$i", "")!!))
        }
        return loadedItemList
    }
}