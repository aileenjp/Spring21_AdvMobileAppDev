package com.example.list.model

import io.realm.RealmObject
import io.realm.annotations.PrimaryKey

open class Item(
    @PrimaryKey var id: String,
    var name: String): RealmObject()
    {
        constructor(): this("", "")
    }