import UIKit

// From Design Patterns (GoF - Gamma, Johnson, Vlissides & Helm)
// The singleton pattern is a way to make sure that a class has only one instance (1) and it provides a single point of
// access to it(2).
// It can further ensure that no other instance can be created by intercepting requests for creating new objects (3) and
// provide a way to access the sole instance. (4)
// A single may be extended in the future. (5)

class Singleton {
    static let shared = Singleton() // (2) (3) (4)
    private init() {} // (1)

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


// The lowercase singleton, differs in that instances may also be created, this allows for overriding of functions and
// therefore the modification for other purposes such as testing.
class LowerCaseSingleton {
    static let shared = LowerCaseSingleton() // (2) (3) (4)
    // Note (1) is not applied for a singleton
    
    func originalMethod() {
        print("singleton originalMethod")
    }
}

let myLowerCaseSingleton = LowerCaseSingleton.shared
myLowerCaseSingleton.originalMethod()

let mySecondLowerCaseSingleton = LowerCaseSingleton.shared
assert(myLowerCaseSingleton === mySecondLowerCaseSingleton)

let myLowerCaseSingletonInstance = LowerCaseSingleton()
assert(myLowerCaseSingleton !== myLowerCaseSingletonInstance)

// (5) Using extension
extension LowerCaseSingleton {
    func extendedMethod() {
        print("singleton extendedMethod")
    }
}
myLowerCaseSingleton.extendedMethod()

// Subclassing of LowerCaseSingleton allows overriding for e.g. test code
class LowerCaseSingletonSubclass : LowerCaseSingleton {
    override func originalMethod() {
        print("overriden singleton originalMethod")
    }
    
    func anotherExtendedMethod() {
        print("subclassed singleton anotherExtendedMethod")
    }
}

let myLowerCaseSingletonSubclass = LowerCaseSingletonSubclass()
myLowerCaseSingletonSubclass.originalMethod()
myLowerCaseSingletonSubclass.extendedMethod()
myLowerCaseSingletonSubclass.anotherExtendedMethod()

