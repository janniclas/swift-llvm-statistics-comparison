
import Foundation

func main() {
  let buffer = UnsafeMutablePointer<CChar>.allocate(capacity: 128)
  
  for i in 0..<128 {
    buffer.advanced(by: i).pointee = 42
  }
  buffer.advanced(by: 42).pointee = 13
  let p = buffer + 42 // equivalent to &Buffer[42]
  buffer.deallocate()
  return
}