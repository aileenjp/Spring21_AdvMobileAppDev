package com.example.list

import io.realm.Realm
import io.realm.RealmConfiguration

class ListApplication: android.app.Application() {
    override fun onCreate() {
        super.onCreate()

        //initialize realm
        Realm.init(this)

        //define realm configuration
        val realmConfig  = RealmConfiguration.Builder().build()
        //for debugging or if you change the db structure and don't want to migrate this will clear out the database
        //Realm.deleteRealm(realmConfig)

        //set default real configuration
        Realm.setDefaultConfiguration(realmConfig )
    }
}