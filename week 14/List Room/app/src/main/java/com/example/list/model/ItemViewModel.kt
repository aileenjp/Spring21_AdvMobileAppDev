package com.example.list.model

import android.app.Application
import androidx.lifecycle.AndroidViewModel
import androidx.lifecycle.LiveData
import androidx.lifecycle.viewModelScope
import com.example.list.util.ItemRepository
import kotlinx.coroutines.launch

class ItemViewModel( application: Application): AndroidViewModel(application) {
    private val context = application.applicationContext
    private val itemDatabase = ItemDatabase.getDatabase(context)
    private val itemRepository = ItemRepository(itemDatabase.itemDAO())
    val itemList: LiveData<List<Item>> = itemRepository.itemList

    //uses the viewModelScope coroutine scope to launch the coroutine in a worker thread
    fun add(item: Item) = viewModelScope.launch{
        itemRepository.insertItem(item)
    }

    fun delete(item: Item) = viewModelScope.launch{
        itemRepository.deleteItem(item)
    }

    fun deleteAll() = viewModelScope.launch{
        itemRepository.deleteAll()
    }
}