// Copyright © 2023 Ben Morrison. All rights reserved.

import Foundation

/// `Node` is used by the `LinkedList`.
open class Node<T>: CustomDebugStringConvertible {
    /// The element
    public var element: T
    /// The next node in the list, or nil if it is the end of the list
    public internal(set) var next: Node<T>?
    /// The previous node in the list, or nil if it is the start of the list
    public internal(set) weak var previous: Node<T>?
    
    /// Initalises the node for the list with the element.
    /// - Parameters:
    ///    - element: The element to store
    internal init(_ element: T) {
        self.element = element
        self.next = nil
        self.previous = nil
    }
    
    /// Initalises the node for the list with the element with the next and previous nodes.
    /// - Parameters:
    ///    - element: The element to store
    ///    - next: The next node to point too
    ///    - previous: The previous node to point to
    internal init(_ element: T, next: Node<T>? = nil, previous: Node<T>? = nil) {
        self.element = element
        self.next = next
        self.previous = previous
    }
    
    /// This does a straight up address check if the node is the passed in node.
    /// - Parameter other: The node we are checking if it is this node.
    /// - Returns: True if the addresses match, false if they do not.
    public func isNode(_ other: Node<T>?) -> Bool {
        guard let other else { return false }
        return Unmanaged.passUnretained(self).toOpaque() == Unmanaged.passUnretained(other).toOpaque()
    }
    
    // MARK: - CustomDebugStringConvertible
    
    public var debugDescription: String {
        var prevPointer: UnsafeMutableRawPointer? = nil
        var nextPointer: UnsafeMutableRawPointer? = nil
        
        if let previous { prevPointer = Unmanaged.passUnretained(previous).toOpaque() }
        if let next { nextPointer = Unmanaged.passUnretained(next).toOpaque() }
        
        return """
        -----------------
        | Address: \(String(describing: Unmanaged.passUnretained(self).toOpaque()))
        | Element: \(String(describing: element))
        | Previous: \(String(describing: prevPointer))
        | Next: \(String(describing: nextPointer))
        -----------------
        """
        
    }
}
