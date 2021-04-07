package com.example.list

import android.content.DialogInterface
import android.os.Bundle
import android.util.Log
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.android.material.snackbar.Snackbar
import androidx.appcompat.app.AppCompatActivity
import android.view.Menu
import android.view.MenuItem
import android.widget.EditText
import androidx.activity.viewModels
import androidx.appcompat.app.AlertDialog
import androidx.lifecycle.Observer
import androidx.recyclerview.widget.DividerItemDecoration
import androidx.recyclerview.widget.LinearLayoutManager
import androidx.recyclerview.widget.RecyclerView
import com.example.list.model.Item
import com.example.list.model.ItemViewModel

class MainActivity : AppCompatActivity() {

    private val viewModel: ItemViewModel by viewModels()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        setSupportActionBar(findViewById(R.id.toolbar))

        //only load saved data once per app lifetime
        if (viewModel.itemList.value == null){
            viewModel.loadData()
            Log.i("main", "in if to load data")
        }

        //get the recycler view
        val recyclerView: RecyclerView = findViewById(R.id.recyclerView)

        //divider line between rows
        recyclerView.addItemDecoration(DividerItemDecoration(this, LinearLayoutManager.VERTICAL))

        //set a layout manager on the recycler view
        recyclerView.layoutManager = LinearLayoutManager(this, LinearLayoutManager.VERTICAL, false)

        //define an adapter
        val adapter = MyListAdapter(viewModel)

        //assign the adapter to the recycle view
        recyclerView.adapter = adapter

        findViewById<FloatingActionButton>(R.id.fab).setOnClickListener {view ->
            //create alert dialog
            val dialog = AlertDialog.Builder(this)
            //create edit text
            val editText = EditText(applicationContext)
            //add edit text to dialog
            dialog.setView(editText)
            //set dialog title
            dialog.setTitle(R.string.addItem)
            //set OK action

            dialog.setPositiveButton(R.string.add) {dialog, which ->
                val newItem = editText.text.toString()
                if (!newItem.isEmpty()){
                    //add item
                    viewModel.add(Item(newItem))
                    Snackbar.make(view, R.string.itemAdded, Snackbar.LENGTH_LONG)
                        .setAction(R.string.action, null).show()
                }
            }
            //sets cancel action
            dialog.setNegativeButton(R.string.cancel) { dialog, which ->
                //cancel
            }
            dialog.show()
        }

        //create the observer
        viewModel.itemList.observe(this, Observer {
            Log.i("main", "in observer")
            adapter.update()
            viewModel.saveData()
        })
    }

    override fun onCreateOptionsMenu(menu: Menu): Boolean {
        // Inflate the menu; this adds items to the action bar if it is present.
        menuInflater.inflate(R.menu.menu_main, menu)
        return true
    }

    override fun onOptionsItemSelected(item: MenuItem): Boolean {
        // Handle action bar item clicks here. The action bar will
        // automatically handle clicks on the Home/Up button, so long
        // as you specify a parent activity in AndroidManifest.xml.
        return when (item.itemId) {
            R.id.action_settings -> true
            else -> super.onOptionsItemSelected(item)
        }
    }
}