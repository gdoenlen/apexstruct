/* Copyright 2017 George Doenlen

   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
   documentation files (the "Software"), to deal in the Software without restriction, including without limitation the
   rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
   to permit persons to whom the Software is furnished to do so, subject to the following conditions:

   The above copyright notice and this permission notice shall be included in all copies or substantial
   portions of the Software.

   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO
   THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
   IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN
   AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
   OTHER DEALINGS IN THE SOFTWARE. */

/**
 * Self-balancing search tree.
 * Uses the Adelson-Velskii and Landis algorithm.
 * <table>
 *  <caption>Modification Log</caption>
 *  <tr>
 *      <th>Developer</th>
 *      <th>Date</th>
 *      <th>Description</th>
 *      <th>Version</th>
 *  </tr>
 *  <tr>
 *      <td>George Doenlen</td>
 *      <td>06 DEC 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
global class AVLTree extends BinarySearchTreeWithRotate {

    /** Convenience shortcut for a left heavy tree */
    public static final Integer LEFT_HEAVY = -1;

    /** Convenience shortcut for a balanced tree */
    public static final Integer BALANCED = 0;

    /** Convenience shortcut for a right heavy tree */
    public static final Integer RIGHT_HEAVY = 1;

    /** Indicates the height of the tree has increased */
    private Boolean increase;

    /** Indicates the height of the tree has decreased */
    private Boolean decrease;

    global AVLTree(Comparator comp, Type t) {
        super(comp, t);
    }

    private AVLTree(Comparator comp, AVLTree.AVLNode root, Type t) {
        super(comp, root, t);
    }

    global override Boolean add(Object o) {
        super.add(o);
        increase = false;
        root = add((AVLTree.AVLNode)root, o);
        return addReturn;
    }

    /**
     * Recursively adds the item to the tree
     *
     * @post addReturn is set to true if the item is added to the tree
     * @param localRoot the localRoot of the tree being added to
     * @param o the object being added to the tree
     */
    private AVLTree.AVLNode add(AVLTree.AVLNode localRoot, Object o) {
        if(localRoot == null) {
            addReturn = true;
            increase = true;
            return new AVLTree.AVLNode(o);
        }

        Integer result = comp.compare(o, localRoot.data);
        if(result == 0) {
            //the object is already in the tree
            increase = false;
            addReturn = false;
            return localRoot;
        } else if(result < 0) {
            localRoot.left = add((AVLTree.AVLNode)localRoot.left, o);
            if(increase) {
                decrementBalance(localRoot);
                if(localRoot.balance < LEFT_HEAVY) {
                    increase = false;
                    return rebalanceLeft(localRoot);
                }
            }
            return localRoot;
        } else {
            localRoot.right = add((AVLTree.AVLNode)localRoot.right, o);
            if(increase) {
                incrementBalance(localRoot);
                if(localRoot.balance > RIGHT_HEAVY) {
                    increase = false;
                    return rebalanceRight(localRoot);
                }
            }
            return localRoot;
        }
    }

    /**
     * Creates a binary tree out of this tree's left sub tree
     *
     * @return a BinaryTree made out of root.left as it's root
     */
    global override BinaryTree getLeftSubTree() {
        return new AVLTree(this.comp, (AVLTree.AVLNode)this.root.left, this.t);
    }

    /**
     * Creates a Binary tree out of this tree's right sub tree
     *
     * @return a BinaryTree made from root.right as it's root
     */
    global override BinaryTree getRightSubTree() {
        return new AVLTree(this.comp, (AVLTree.AVLNode)this.root.right, this.t);
    }

    /**
     * Decrements the balance of a node. Determines if the height of the overall tree has increased or not.
     *
     * @param node the node to decrement it's balance
     */
    private void decrementBalance(AVLTree.AVLNode node) {
        node.balance--;
        if(node.balance == BALANCED) {
            increase = false;
            decrease = true;
        }
    }

    /**
     * Increments the balance of a node. Determines if the height of the overall tree has increased or not.
     *
     *
     * @param node the node to increment
     */
    private void incrementBalance(AVLTree.AVLNode node) {
        node.balance++;
        if(node.balance == BALANCED) {
            increase = false;
            decrease = true;
        }
    }

    /**
     * Rebalances the left subtree of the local root. Handles left-right case and left-left cases
     *
     * @param localRoot
     * @see KW Data Structures pages 486 - 487
     */
    private AVLTree.AVLNode rebalanceLeft(AVLTree.AVLNode localRoot) {
        AVLTree.AVLNode leftChild = (AVLTree.AVLNode)localRoot.left;
        //check for left-right heavy
        if(leftChild.balance > BALANCED) {
            AVLTree.AVLNode leftRightChild = (AVLTree.AVLNode)leftChild.right;
            if(leftRightChild.balance < BALANCED) {
                leftChild.balance = LEFT_HEAVY;
                leftRightChild.balance = BALANCED;
                localRoot.balance = BALANCED;
                decrease = true;
            } else if(leftRightChild.balance > BALANCED) {
                leftChild.balance = BALANCED;
                leftRightChild.balance = BALANCED;
                localRoot.balance = RIGHT_HEAVY;
                decrease = false;
            } else {
                leftChild.balance = BALANCED;
                localRoot.balance = BALANCED;
                decrease = true;
            }
            localRoot.left = rotateLeft(leftChild);
        } else {
            //left-left case
            leftChild.balance = BALANCED;
            localRoot.balance = BALANCED;
            decrease = true;
        }
        return (AVLTree.AVLNode)rotateRight(localRoot);
    }

    /**
     * Rebalances the right substree of the local root node
     * Symmetrical to the the rebalanceLeft function
     *
     * @param localRoot the node to begin balancing at
     * @see rebalanceLeft
     */
    private AVLTree.AVLNode rebalanceRight(AVLTree.AVLNode localRoot) {
        AVLTree.AVLNode rightChild = (AVLTree.AVLNode)localRoot.right;
        //check for right-left heavy
        if(rightChild.balance < BALANCED) {
            AVLTree.AVLNode rightLeftChild = (AVLTree.AVLNode)rightChild.left;
            if(rightLeftChild.balance > BALANCED) {
                rightChild.balance = RIGHT_HEAVY;
                rightLeftChild.balance = BALANCED;
                localRoot.balance = BALANCED;
                decrease = true;
            } else if(rightLeftChild.balance < BALANCED) {
                rightChild.balance = BALANCED;
                rightLeftChild.balance = BALANCED;
                localRoot.balance = LEFT_HEAVY;
                decrease = false;
            } else {
                rightChild.balance = BALANCED;
                localRoot.balance = BALANCED;
                decrease = true;
            }
            localRoot.right = rotateRight(rightChild);
        } else {
            //right-right case
            rightChild.balance = BALANCED;
            localRoot.balance = BALANCED;
            decrease = true;
        }
        return (AVLTree.AVLNode)rotateLeft(localRoot);
    }


    global override Object del(Object o) {
        root = del((AVLTree.AVLNode)root, o);
        return deleteReturn;
    }

    private BinaryTree.Node del(AVLTree.AVLNode localRoot, Object o) {
        if(localRoot == null) {
            deleteReturn = null;
            return localRoot;
        }

        Integer result = comp.compare(o, localRoot);
        if(result < 0) {
            localRoot.left = del(localRoot.left, o);
            if(decrease) {
                incrementBalance(localRoot);
                if(localRoot.balance > RIGHT_HEAVY) {
                    decrease = false;
                    rebalanceRight(localRoot);
                }
            }
            return localRoot;
        } else if(result > 0) {
            localRoot.right = del(localRoot.right, o);
            if(decrease) {
                decrementBalance(localRoot);
                if(localRoot.balance < LEFT_HEAVY) {
                    decrease = false;
                    rebalanceLeft(localRoot);
                }
            }
            return localRoot;
        } else {
            deleteReturn = localRoot.data;
            decrease = true;
            if(localRoot.left == null) {
                return localRoot.right;
            } else if(localRoot.right == null) {
                return localRoot.left;
            } else {
                //the node being deleted has 2 chilren
                //replace it with it's inorder predecessor
                if(localRoot.left.right == null) {
                    // The left child has no right child.
                    // Replace the data with the data in the
                    // left child.
                    localRoot.data = localRoot.left.data;
                    localRoot.left = localRoot.left.left;
                    return localRoot;
                } else {
                    //searchs for the inorder predecessor
                    localRoot.data = predecessor(localRoot.left).data;
                    return localRoot;
                }
            }
        }

    }

    /**
     * AVLNode. Adds balance to the BinaryTree node
     *
     * @see BinaryTree.Node
     */
    private class AVLNode extends BinaryTree.Node {

        /** The balance of this node against the tree */
        private Integer balance;

        /**
         * Constructor. Sets the data field and sets balance to 0
         *
         * @param o The data that this node will hold.
         */
        public AVLNode(Object o) {
            super(o);
            balance = AVLTree.BALANCED;
        }
    }
}