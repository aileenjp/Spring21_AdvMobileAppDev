package com.example.tulips

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.tulips.BulbAdapter.ViewHolder
import com.example.tulips.model.Bulb

class BulbAdapter(private val bulbList: ArrayList<Bulb>, private val clickListener:(Bulb) -> Unit): RecyclerView.Adapter<ViewHolder>() {
    class ViewHolder(view: View): RecyclerView.ViewHolder(view) {
        val bulbTextView: TextView = view.findViewById(R.id.textView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        //create an instance of LayoutInflater
        val layoutInflater = LayoutInflater.from(parent.context)
        //inflate the view
        val itemViewHolder = layoutInflater.inflate(R.layout.list_item, parent, false)
        return ViewHolder(itemViewHolder)
    }

    override fun getItemCount() = bulbList.size

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        //get data at the position
        val bulb = bulbList[position]
        //set the text of the textview to the name
        holder.bulbTextView.text = bulb.name
        //assign click listener
        holder.itemView.setOnClickListener{clickListener(bulb)}
    }

}