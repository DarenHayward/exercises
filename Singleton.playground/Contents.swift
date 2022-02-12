import UIKit

// From Design Patterns (GoF - Gamma, Johnson, Vlissides & Helm)
// The singleton pattern is a way to make sure that a class has only one instance (1) and it provides a single point of
// access to it(2).
// It can further ensure that no other instance can be created by intercepting requests for creating new objects (3) and
// provide a way to access the sole instance. (4)
// A single may be extended in the future. (5)

class Singleton {
    static let shared = Singleton() // (2) (4)
    private init() {} // (1) (3)

    func originalMethod() {
        print("original method")
    }
}

let mySingleton = Singleton.shared
mySingleton.originalMethod()

let mySecondSingleton = Singleton.shared
assert(mySingleton === mySecondSingleton)

// (5)
extension Singleton {
    func extendedMethod() {
        print("extended method")
    }
}

mySingleton.extendedMethod()
