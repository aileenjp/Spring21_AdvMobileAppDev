package com.example.list.model

import android.content.Context
import androidx.room.Database
import androidx.room.Room
import androidx.room.RoomDatabase
import com.example.list.util.ItemDAO

@Database(entities = arrayOf(Item::class), version = 1, exportSchema = false)
abstract class ItemDatabase: RoomDatabase() {

    companion object {
        // Singleton prevents multiple instances of database opening at the same time
        @Volatile
        private var dbInstance: ItemDatabase? = null

        fun getDatabase(context: Context): ItemDatabase {
            // if the database instance is null, create the database
            if (dbInstance == null) {
                synchronized(ItemDatabase::class) {
                    dbInstance = Room.databaseBuilder(context, ItemDatabase::class.java, "item.db").build()
                }
            }
            //return the database instance
            return dbInstance!!
        }
    }

    abstract fun itemDAO(): ItemDAO
}