package com.example.recipes.model

data class Recipe(val name: String, val url:String) {
    constructor(): this("", ""){}
}