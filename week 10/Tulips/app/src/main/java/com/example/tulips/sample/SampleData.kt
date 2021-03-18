package com.example.tulips.sample

import com.example.tulips.R
import com.example.tulips.model.Bulb

object SampleData {
    val tulipList = ArrayList<Bulb>()

    init {
        tulipList.add(Bulb("Daydream", R.drawable.daydream))
        tulipList.add(Bulb("Apeldoorn Elite", R.drawable.apeldoorn))
        tulipList.add(Bulb("Banja Luka", R.drawable.banjaluka))
        tulipList.add(Bulb("Burning Heart", R.drawable.burningheart))
        tulipList.add(Bulb("Cape Cod", R.drawable.capecod))
    }
}