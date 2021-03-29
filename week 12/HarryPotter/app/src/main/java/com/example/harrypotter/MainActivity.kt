package com.example.harrypotter

import android.content.Intent
import android.net.Uri
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.util.Log
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.harrypotter.data.JSONData
import com.example.harrypotter.model.Character

class MainActivity : AppCompatActivity() {
    var potterList = ArrayList<Character>()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        Log.i("main", "in oncreate")
       if (savedInstanceState == null){
           Log.i("main", "in if")
            val data = JSONData()
            //populate with JSON data
            potterList = data.getJSON(this)
       }
        setupRecyclerView()
    }

    private fun setupRecyclerView(){
        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //divider line between rows
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))

        //define an adapter
        val adapter = MyListAdapter(potterList, {item: Character -> itemClicked(item)})

        //assign the adapter to the recycle view
        recyclerView.adapter = adapter

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
    }

    private fun itemClicked(item : Character) {
        //create intent
        var intent = Intent()
        intent.action = Intent.ACTION_VIEW
        intent.data = Uri.parse(item.info)
        //start activity
        startActivity(intent)
    }

    override fun onSaveInstanceState(outState: Bundle) {
        outState.putParcelableArrayList("potterlist", potterList)
        super.onSaveInstanceState(outState)
    }

    override fun onRestoreInstanceState(savedInstanceState: Bundle) {
        Log.i("main", "in on restore")
        super.onRestoreInstanceState(savedInstanceState)
        potterList = savedInstanceState.getParcelableArrayList<Character>("potterlist") as ArrayList<Character>
        setupRecyclerView()
    }
}