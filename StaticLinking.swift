import Foundation

public struct CustomType {
  public var value: Int

  public init(value: Int) {
    self.value = value
  }
}

extension CustomType {
  public static func + (lhs: CustomType, rhs: CustomType) -> CustomType {
    return CustomType(value: lhs.value + rhs.value)
  }

  public static func - (lhs: CustomType, rhs: CustomType) -> CustomType {
    return CustomType(value: lhs.value - rhs.value)
  }

  public static func * (lhs: CustomType, rhs: CustomType) -> CustomType {
    return CustomType(value: lhs.value * rhs.value)
  }

  public static func / (lhs: CustomType, rhs: CustomType) -> CustomType {
    return CustomType(value: lhs.value / rhs.value)
  }

  public static func += (lhs: inout CustomType, rhs: CustomType) {
    lhs = lhs + rhs
  }

  public static func -= (lhs: inout CustomType, rhs: CustomType) {
    lhs = lhs - rhs
  }

  public static func *= (lhs: inout CustomType, rhs: CustomType) {
    lhs = lhs * rhs
  }

  public static func /= (lhs: inout CustomType, rhs: CustomType) {
    lhs = lhs / rhs
  }
}

extension CustomType: SignedNumeric {
  public init<T: BinaryInteger>(exactly value: T) {
    self.init(value: Int(value))
  }

  public typealias Magnitude = CustomType

  public var magnitude: CustomType {
    return self < 0 ? -self : self
  }

  public static prefix func - (_ operand: Self) -> Self {
    return CustomType(value: operand.value * -1)
  }
}

extension CustomType: ExpressibleByIntegerLiteral {
  public init(integerLiteral value: Int) {
    self.init(value: value)
  }
}

extension CustomType: CustomStringConvertible {
  public var description: String {
    return "\(value)"
  }
}

extension CustomType: Strideable {
  public typealias Stride = CustomType

  public func distance(to other: CustomType) -> Stride {
    return other - self
  }

  public func advanced(by stride: Stride) -> CustomType {
    return self + stride
  }
}

extension CustomType: Equatable, Comparable {
  public static func == (lhs: Self, rhs: Self) -> Bool {
    return lhs.value == rhs.value
  }

  public static func < (lhs: Self, rhs: Self) -> Bool {
    return lhs.value < rhs.value
  }
}
