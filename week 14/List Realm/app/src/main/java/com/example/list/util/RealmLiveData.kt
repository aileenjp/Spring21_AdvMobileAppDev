package com.example.list.util

import androidx.lifecycle.LiveData
import io.realm.RealmChangeListener
import io.realm.RealmModel
import io.realm.RealmResults

class RealmLiveData<T: RealmModel>(val realmResults: RealmResults<T>): LiveData<RealmResults<T>>() {

    private val listener = RealmChangeListener<RealmResults<T>>(){results->
        value = results
    }

//    alternate syntax
//    private val listener = RealmChangeListener<RealmResults<T>>(){
//        value = it
//    }

//    private val listener = RealmChangeListener<RealmResults<T>>{
//            results -> value = results
//    }

    //called when the number of active observers change from 0 to 1
    override fun onActive() {
        realmResults.addChangeListener(listener)
    }

    //called when the number of active observers change from 1 to 0.
    override fun onInactive() {
        realmResults.removeChangeListener(listener)
    }
}