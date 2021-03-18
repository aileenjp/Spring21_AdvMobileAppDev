package com.example.tulips

import android.content.Intent
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.LinearLayout
import android.widget.Toast
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.tulips.model.Bulb
import com.example.tulips.sample.SampleData

class MainActivity : AppCompatActivity() {
    private var bulbList = SampleData.tulipList

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)

        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //divider line between rows
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))

        //define an adapter
        val adapter = BulbAdapter(bulbList, {item: Bulb -> itemClicked(item)})

        //assign the adapter to the recycle view
        recyclerView.adapter = adapter

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)
    }

    private fun itemClicked(item : Bulb) {
        //create intent
        val intent = Intent(this, DetailActivity::class.java)
        intent.putExtra("name", item.name)
        intent.putExtra("resourceID", item.imageResourceID)

        //start activity
        startActivity(intent)
    }
}