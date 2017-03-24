# Apex Struct
Apex Struct is a type safe collection of data structures for the SFDC platform.

It also contains some useful utilities.

For the full documentation please see the generated documentation included in the docs folder.

## Sources
* [Data Structures: Abstraction and Design Using Java](https://www.amazon.com/Data-Structures-Abstraction-Design-Using/dp/0470128704/ref=sr_1_2?ie=UTF8&qid=1489604744&sr=8-2&keywords=data+structures+koffman+wolfgang)

## Contents
### Structs
_Starred items are experimental_
#### Self-Balancing Search Trees
 * AVLTree*
 * RedBlackTree*
 * * This works properly, but on large data sets it will hit the CPU limit.
 * SkipList*
#### Graphs
 * ListGraph
 * MatrixGraph
#### Queues
 * LinkedQueue
 * PriorityQueue (implemented as a heap)
#### Stacks
 * LinkedStack
### Supplementary Utilities
 * BinarySearch
 * DoubleUtils
 * HashCodeUtil
 * Randomizer
 * SinglePivotQuickSort
