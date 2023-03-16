# LinkedList

This framework is a just a random thing I work on to just code random things. I hadn't written a Linked List in nearly 12 years, so I thought I'd give it a go in swift.

## Usage

```swift
// Init an empty list
let list = LinkedList<Int>()

// Init a list from a collection
let array = ["Element 1", "Element 2", "Element 3"]
let list = LinkedList(from: array)
```

It conforms to `Collection` so it supports all actions you'd expect from a collection.

The code is also documented.

There are also tests, not heaps, but there are tests.