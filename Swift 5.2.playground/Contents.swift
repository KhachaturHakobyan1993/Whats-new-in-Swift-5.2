import UIKit


// MARK: - Key Path Expressions as Functions -

struct User {
    let name: String
    let age: Int
    let bestFriend: String?
    
    var canVote: Bool { self.age >= 18}
}

let eric = User(name: "Eric Effiong", age: 18, bestFriend: "Otis Milburn")
let maeve = User(name: "Maeve Wiley", age: 19, bestFriend: nil)
let otis = User(name: "Otis Milburn", age: 17, bestFriend: "Eric Effiong")
let users = [eric, maeve, otis]

let userNames = users.map(\.name)
print(userNames)

let oldUserNames = users.map({ $0.name })
print(oldUserNames)

let voters = users.filter(\.canVote)
print(voters)

let bestFriends = users.compactMap(\.bestFriend)
print(bestFriends)


// MARK: - Callable values of user-defined nominal types -

struct Dice {
    let lowerBound: Int
    let upperBound: Int
    
    func callAsFunction() -> Int {
        (self.lowerBound...self.upperBound).randomElement()!
    }
}

let d6 = Dice(lowerBound: 1, upperBound: 6)
let roll1 = d6()
print(roll1)

let d12 = Dice(lowerBound: 1, upperBound: 12)
let roll2 = d12.callAsFunction()
print(roll2)

struct StepCounter {
    var steps = 0
    
    mutating func callAsFunction(count: Int) -> Bool {
        self.steps += count
        print(self.steps)
        return self.steps > 10_000
    }
}

var steps = StepCounter()
let targetReached = steps(count: 10001)


// MARK: - Subscripts can now declare default arguments -

struct PoliceForce {
    var officers: [String]
    
    subscript(index: Int, default default: String = "Unknown") -> String {
        return index >= 0 && index < self.officers.count
            ? self.officers[index]
            : `default`
    }
}

let force = PoliceForce(officers: ["Amy", "Jake", "Rosa", "Terry"])
print(force[0])
print(force[5])
print(force[-1, default: "dddddd"])


// MARK: - Lazy filtering order is now reversed -

let people = ["Arya", "Cersei", "Samwell", "Stannis"]
    .lazy
    .filter { $0.hasPrefix("S") }
    .filter { print($0); return true }
_ = people.count


// MARK: - New and improved diagnostics -

import SwiftUI

struct ContentView: View {
    @State private var name = 0

    var body: some View {
        VStack {
            Text("What is your name?")
            // Cannot convert value of type Binding<Int> to expected argument type Binding<String>.
//            TextField("Name", text: $name)
//                .frame(maxWidth: 300)
            
        }
    }
}
