package com.example.tulips

import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.ImageView
import android.widget.TextView

class DetailActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_detail)

        //get intent
        val name = intent.getStringExtra("name")
        val resourceID = intent.getIntExtra("resourceID", -1)

        //update view
        val bulbImage:ImageView = findViewById(R.id.imageViewBulb)
        bulbImage.setImageResource(resourceID)
        val bulbName:TextView = findViewById(R.id.textViewName)
        bulbName.text = name
    }
}