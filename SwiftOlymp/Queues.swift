import Foundation

func main(_ closure: @escaping () -> ()) {
    DispatchQueue.main.async(execute: closure)
}

func delay(_ delay: Double = 0, closure: @escaping ()->()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}

func background(_ closure: @escaping () -> ()) {
    DispatchQueue.global(qos: .default).async(execute: closure)
}


