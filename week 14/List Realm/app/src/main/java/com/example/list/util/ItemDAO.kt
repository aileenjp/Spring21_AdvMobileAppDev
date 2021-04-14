package com.example.list.util

import com.example.list.model.Item
import io.realm.Realm

open class ItemDAO() {
    private val realmDB:Realm = Realm.getDefaultInstance()

    fun getItems(): RealmLiveData<Item> {
        return RealmLiveData(realmDB.where(Item::class.java).findAllAsync())
    }

    fun addItem(item:Item){
        realmDB.executeTransactionAsync{transactionRealm ->
            transactionRealm.insert(item)
        }
    }
//        alternate syntax
//        realmDB.executeTransactionAsync{
//            it.insert(item)
//        }

    fun deleteItem(id:String){
        realmDB.executeTransactionAsync{transactionRealm ->
            transactionRealm.where(Item::class.java).equalTo("id", id).findAll().deleteAllFromRealm()
        }
    }

    fun deleteAll(){
        realmDB.executeTransactionAsync{transactionRealm ->
            transactionRealm.deleteAll()
        }
    }

    fun close(){
        realmDB.close()
    }
}