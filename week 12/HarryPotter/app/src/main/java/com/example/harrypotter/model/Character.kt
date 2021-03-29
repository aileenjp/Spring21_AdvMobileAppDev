package com.example.harrypotter.model
import android.os.Parcelable
import kotlinx.android.parcel.Parcelize

@Parcelize
data class Character(val name: String, val info: String): Parcelable {}