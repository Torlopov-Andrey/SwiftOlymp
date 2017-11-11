import Foundation

class BurglarEngine {
    
    private let countOfnumbers: Int = 4
    private var exactly = 0
    private var exist = 0
    
    var numbersForUnlock = [Int]()
    var history = [(exactly: Int, exist: Int)]()
    
    init() {
        setupNumber()
    }
    
    func setupNumber() {
        exist = 0
        exactly = 0
        history.removeAll()
        numbersForUnlock.removeAll()
        for _ in 1...countOfnumbers {
            numbersForUnlock.append(Int(arc4random_uniform(10)))
        }
    }
    
    func checkNumber(numbers: [Int]) -> (exactly: Int, exist: Int) {
        guard numbers.count == countOfnumbers else { fatalError() }
        exactlyCheck(numbers: numbers)
        existCheck(numbers: numbers)
        history.append((exactly: exactly, exist: exist))
        return (exactly: exactly, exist: exist)
    }
    
    private func exactlyCheck(numbers: [Int]) {
        for i in 0...countOfnumbers - 1 {
            if numbers[i] == numbersForUnlock[i] {
                exactly += 1
            }
        }
    }
    
    private func existCheck(numbers: [Int]) {
        for number in numbers {
            for unlockNumber in numbersForUnlock {
                if number == unlockNumber {
                    exist += 1
                }
            }
        }
    }
}

