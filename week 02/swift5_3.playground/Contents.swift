
//Optionals

var score : Int?
//print("Score is \(score)")
score=80
print("score is \(score!)") //forced unwrapped

//conditionally unwrap
if score != nil {
    print("The score is \(score!)")
}

//optional binding
if let currentScore = score {
    print("My current score is \(currentScore)")
}

//coalescing operator
score = nil
let myScore = score ?? 0
print("My score is \(myScore)")

//implicitly unwrapped
let newScore : Int! = 95
//print("My new score is ", newScore)


//Type Casting
class Pet {
    var name: String
    init(name: String){
        self.name = name
    }
}

class Dog : Pet {
    var breed: String
    init(name: String, breed: String) {
        self.breed=breed
        super.init(name: name)
    }
}

class Fish : Pet {
    var species: String
    init(name: String, species: String) {
        self.species=species
        super.init(name: name)
    }
}

let myPets=[Dog(name: "Cole", breed: "Black Lab"), Dog(name: "Nikki", breed: "German Shepherd"), Fish(name: "Nemo", species: "Clown Fish")]

var dogCount = 0
var fishCount = 0

for pet in myPets {
    if pet is Dog {
        dogCount += 1
    }
    else if pet is Fish {
        fishCount += 1
    }
}

print("I have \(dogCount) dogs and \(fishCount) fish")

for pet in myPets {
    if let dog = pet as? Dog {
        print("\(dog.name) is a \(dog.breed)")
    } else if let fish = pet as? Fish {
        print("\(fish.name) is a \(fish.species)")
    }
}


//Closures
let names=["Tom", "Jessie", "Megan", "Angie"]

//using a function
func backwards(s1: String, s2: String) -> Bool {
    return s1 > s2
}

var reversed = names.sorted(by:backwards)

//using a closure
reversed = names.sorted(by: {(s1:String, s2: String)->Bool in return s1 > s2})
print(reversed)

reversed = names.sorted(by: {s1, s2 in return s1 > s2})
print(reversed)

reversed = names.sorted(by: {s1, s2 in s1 > s2})
print(reversed)

reversed = names.sorted(by: {$0 > $1})
print(reversed)


//Enums
enum carType {
    case gas
    case electric
    case hybrid
}

var car = carType.electric
print(car)
car = .hybrid
print(car)


//Error Handling
enum WebError: Error{
    case Forbidden
    case NotFound
    case RequestTimeout
}

func webPage(status: Int) throws -> String{
    switch status{
        case 403: throw WebError.Forbidden
        case 404: throw WebError.NotFound
        case 408: throw WebError.RequestTimeout
        default: return "OK"
    }
}

var status = try? webPage(status: 400)
status = try? webPage(status: 404)

// var status2 = webPage(status: 400)

do {
    try webPage(status: 404)
} catch WebError.Forbidden {
    print("Forbidden")
} catch WebError.NotFound {
    print("File not found")
} catch WebError.RequestTimeout {
    print("Request time-out")
}


//Early Exit
enum MathError:Error{
    case DivideByZero
}

func divide(number1: Double, number2:Double) throws -> Double{
    guard number2>0 else{
        throw MathError.DivideByZero
    }
    return number1/number2
}

var answer = try? divide(number1: 10, number2: 5)

do {
    try divide(number1: 10, number2: 0)
} catch MathError.DivideByZero {
    print("You can't divide by zero")
}




