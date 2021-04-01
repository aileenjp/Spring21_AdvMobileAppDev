package com.example.list.model

import androidx.lifecycle.MutableLiveData
import androidx.lifecycle.ViewModel

class ItemViewModel: ViewModel() {
    val itemList = MutableLiveData<ArrayList<Item>>()
    private var newList = ArrayList<Item>()

    fun add(item: Item){
        newList.add(item)
        itemList.value = newList
    }

    fun delete(item: Item){
        newList.remove(item)
        itemList.value = newList
    }
}