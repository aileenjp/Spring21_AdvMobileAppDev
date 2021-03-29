package com.example.harrypotter

import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.TextView
import androidx.recyclerview.widget.RecyclerView
import com.example.harrypotter.model.Character

class MyListAdapter(private val characterList: ArrayList<Character>, private val clickListener:(Character) -> Unit): RecyclerView.Adapter<MyListAdapter.ViewHolder>() {
    class ViewHolder(view: View): RecyclerView.ViewHolder(view) {
        val itemTextView: TextView = view.findViewById(R.id.textView)
    }

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): ViewHolder {
        //create an instance of LayoutInflater
        val layoutInflater = LayoutInflater.from(parent.context)

        //inflate the view
        val itemViewHolder = layoutInflater.inflate(R.layout.list_item, parent, false)
        return ViewHolder(itemViewHolder)
    }

    override fun onBindViewHolder(holder: ViewHolder, position: Int) {
        //get data at the position
        val item = characterList[position]

        //set the text of the textview to the name
        holder.itemTextView.text = item.name

        //assign click listener
        holder.itemView.setOnClickListener{clickListener(item)}
    }

    override fun getItemCount() = characterList.size
}