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
 * Self-Balancing search tree adapted from the design structure in  KW Data Structures
 * and with helpers adapted from TreeMap.java
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
 *      <td>29 JUN 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
global class RedBlackTree extends BinarySearchTreeWithRotate {

    /** true */
    global static final Boolean BLACK = true;

    /** false */
    global static final Boolean RED = false;

    /**
     * Constructor. Inits the comparator and type. Calls super
     *
     * @param comp Comparator used to compare the objects in this tree
     * @param t The type of objects in the tree
     * @see Comparator
     * @see Type
     */
    global RedBlackTree(final Comparator comp, final Type t) {
        super(comp, t);
    }

    /**
     * Constructor. Creates a tree who's root node is the given node
     *
     * @param comp The comparator used to compare the objects in the tree
     * @param root The root node of the new tree
     * @param t The type of objects in the tree
     * @see Comparator
     * @see Type
     */
    private RedBlackTree(final Comparator comp, final RedBlackTree.RedBlackNode root, final Type t) {
        super(comp, root, t);
    }

    /**
     * Gets the left subtree of this tree's root
     *
     * @return a RedBlackTree constructed from this tree's root.left
     */
    global override BinaryTree getLeftSubtree() {
        return new RedBlackTree(this.comp, (RedBlackTree.RedBlackNode) this.root, this.t);
    }

    /**
     * Gets the right subtree of this tree's root
     *
     * @return a RedBlackTree constructred form this tree's root.right
     */
    global override BinaryTree getRightSubtree() {
        return new RedBlackTree(this.comp, (RedBlackTree.RedBlackNode) this.root, this.t);
    }

    /**
     * Adds the object to the tree. Ensures that the root node is always a Black node.
     * Adapted from TreeMap.java
     * @param o The object to be added to the tree.
     * @return true if the item was successfully added to the tree
     */
    global override Boolean add(final Object o) {
        super.add(o);

        RedBlackTree.RedBlackNode localRoot = (RedBlackTree.RedBlackNode) root;
        if (localRoot == null) {
            root = new RedBlackTree.RedBlackNode(o, null);
            size = 1;
            return true;
        } else {
            RedBlackTree.RedBlackNode parent;
            Integer result;
            do {
                //navigates to the appropriate localroot node
                parent = localRoot;
                result = comp.compare(o, localRoot.data);
                if (result < 0) {
                    localRoot = (RedBlackTree.RedBlackNode) localRoot.left;
                } else if (result > 0) {
                    localRoot = (RedBlackTree.RedBlackNode) localRoot.right;
                } else {
                    //object is already in the tree
                    return false;
                }
            } while (localRoot != null);
            final RedBlackTree.RedBlackNode entry = new RedBlackTree.RedBlackNode(o, parent);
            if (result < 0) {
                parent.left = entry;
            } else {
                parent.right = entry;
            }
            fixAfterInsertion(entry);
            size++;
            return true;
        }
    }

    /*
     * A set of convenience methods designed to clean up the actual alrogithm code
     * This prevents from adding lots of null checks in the actual algorithm
     */

    //todo I think these are adding a lot of cpu time overhead we might need to remove these
    private static Boolean colorOf(final RedBlackTree.RedBlackNode localRoot) {
        return localRoot == null ? BLACK : localRoot.color;
    }

    private static RedBlackTree.RedBlackNode parentOf(final RedBlackTree.RedBlackNode localRoot) {
        return localRoot == null ? null : localRoot.parent;
    }

    private static void setColor(final RedBlackTree.RedBlackNode localRoot, final Boolean color) {
        if (localRoot != null) {
            localRoot.color = color;
        }
    }

    private static RedBlackTree.RedBlackNode leftOf(final RedBlackTree.RedBlackNode localRoot) {
        return localRoot == null ? null : (RedBlackTree.RedBlackNode) localRoot.left;
    }

    private static RedBlackTree.RedBlackNode rightOf(final RedBlackTree.RedBlackNode localRoot) {
        return localRoot == null ? null : (RedBlackTree.RedBlackNode) localRoot.right;
    }

    /**
     * Fixes the tree's balance after insertion. Adapted from TreeMap.java
     *
     * @param localRoot the entry you just made into the tree
     */
    private void fixAfterInsertion(RedBlackTree.RedBlackNode localRoot) {
        localRoot.color = RED;
        while (localRoot != null && localRoot != root && localRoot.parent.color == RED) {
            if (parentOf(localRoot) == leftOf(parentOf(parentOf(localRoot)))) {
                RedBlackTree.RedBlackNode y = rightOf(parentOf(parentOf(localRoot)));
                if (colorOf(y) == RED) {
                    setColor(parentOf(localRoot), BLACK);
                    setColor(y, BLACK);
                    setColor(parentOf(parentOf(localRoot)), RED);
                    localRoot = parentOf(parentOf(localRoot));
                } else {
                    if (localRoot == rightOf(parentOf(localRoot))) {
                        localRoot = parentOf(localRoot);
                        rotateLeft(localRoot);
                    }
                    setColor(parentOf(localRoot), BLACK);
                    setColor(parentOf(parentOf(localRoot)), RED);
                    rotateRight(parentOf(parentOf(localRoot)));
                }
            } else {
                final RedBlackTree.RedBlackNode y = leftOf(parentOf(parentOf(localRoot)));
                if (colorOf(y) == RED) {
                    setColor(parentOf(localRoot), BLACK);
                    setColor(y, BLACK);
                    setColor(parentOf(parentOf(localRoot)), RED);
                    localRoot = parentOf(parentOf(localRoot));
                } else {
                    if (localRoot == leftOf(parentOf(localRoot))) {
                        localRoot = parentOf(localRoot);
                        rotateRight(localRoot);
                    }
                    setColor(parentOf(localRoot), BLACK);
                    setColor(parentOf(parentOf(localRoot)), RED);
                    rotateLeft(parentOf(parentOf(localRoot)));
                }
            }
        }
        ((RedBlackTree.RedBlackNode) root).color = BLACK;
    }

    /**
     * Removes an object from the tree. Returns null if the object isn't found.
     * Otherwise returns the data from the node containing the object you're looking for
     *
     * @param o the data you are looking for
     * @return data from the node you are looking for, equal to o
     */
    global override Object del(final Object o) {
        final RedBlackTree.RedBlackNode temp = (RedBlackTree.RedBlackNode) getNode(root, o);
        if (temp == null) {
            return null;
        }
        final Object val = temp.data;
        deleteNode(temp);
        return val;
    }

    /**
     * Deletes the node from the tree. Adapted from TreeMap.java
     *
     * @param localRoot the localRoot node to be deleted from the tree
     */
    private void deleteNode(RedBlackTree.RedBlackNode localRoot) {
        size--;
        if (localRoot.left != null && localRoot.right != null) {
            final RedBlackTree.RedBlackNode temp = (RedBlackTree.RedBlackNode) successor(localRoot);
            localRoot.data = temp.data;
            localRoot = temp;
        }

        RedBlackTree.RedBlackNode replacement;
        if (localRoot.left != null) {
            replacement = (RedBlackTree.RedBlackNode) localRoot.left;
        } else {
            replacement = (RedBlackTree.RedBlackNode) localRoot.right;
        }

        if (replacement != null) {
            replacement.parent = localRoot.parent;
            if (localRoot.parent == null) {
                root = replacement;
            } else if (localRoot == localRoot.parent.left) {
                localRoot.parent.left = replacement;
            } else {
                localRoot.parent.right = replacement;
            }

            localRoot.left = localRoot.right = localRoot.parent = null;
            if (localRoot.color == BLACK) {
                fixAfterDeletion(localRoot);
            }
        } else if (localRoot.parent == null) {
            root = null;
        } else {
            if (localRoot.color == BLACK) {
                fixAfterDeletion(localRoot);
            }
            if (localRoot.parent != null) {
                if (localRoot == localRoot.parent.left) {
                    localRoot.parent.left = null;
                } else if (localRoot == localRoot.parent.right) {
                    localRoot.parent.right = null;
                }
                localRoot.parent = null;
            }
        }
    }

    /**
     * Fixes the balance of the tree after removing a black node, adapted from TreeMap.java
     *
     * @param localRoot the node you are removing from the tree
     */
    private void fixAfterDeletion(RedBlackTree.RedBlackNode localRoot) {
        while (localRoot != root && colorOf(localRoot) == BLACK) {
            if (localRoot == leftOf(parentOf(localRoot))) {
                RedBlackTree.RedBlackNode sibling = rightOf(parentOf(localRoot));

                if (colorOf(sibling) == RED) {
                    setColor(sibling, BLACK);
                    setColor(parentOf(localRoot), RED);
                    rotateLeft(parentOf(localRoot));
                    sibling = rightOf(parentOf(localRoot));
                }

                if (colorOf(leftOf(sibling)) == BLACK && colorOf(rightOf(sibling)) == BLACK) {
                    setColor(sibling, RED);
                    localRoot = parentOf(localRoot);
                } else {
                    if (colorOf(rightOf(sibling)) == BLACK) {
                        setColor(leftOf(sibling), BLACK);
                        setColor(sibling, RED);
                        rotateRight(sibling);
                        sibling = rightOf(parentOf(localRoot));
                    }
                    setColor(sibling, colorOf(parentOf(localRoot)));
                    setColor(parentOf(localRoot), BLACK);
                    setColor(rightOf(sibling), BLACK);
                    rotateLeft(parentOf(localRoot));
                    localRoot = (RedBlackTree.RedBlackNode) root;
                }
            } else {
                RedBlackTree.RedBlackNode sibling = leftOf(parentOf(localRoot));

                if (colorOf(sibling) == RED) {
                    setColor(sibling, BLACK);
                    setColor(parentOf(localRoot), RED);
                    rotateRight(parentOf(localRoot));
                    sibling = leftOf(parentOf(localRoot));
                }

                if (colorOf(rightOf(sibling)) == BLACK && colorOf(leftOf(sibling)) == BLACK) {
                    setColor(sibling, RED);
                    localRoot = parentOf(localRoot);
                } else {
                    if (colorOf(leftOf(sibling)) == BLACK) {
                        setColor(rightOf(sibling), BLACK);
                        setColor(sibling, RED);
                        rotateLeft(sibling);
                        sibling = leftOf(parentOf(localRoot));
                    }
                    setColor(sibling, colorOf(parentOf(localRoot)));
                    setColor(parentOf(localRoot), BLACK);
                    setColor(leftOf(sibling), BLACK);
                    rotateRight(parentOf(localRoot));
                    localRoot = (RedBlackTree.RedBlackNode) root;
                }
            }
        }
        setColor(localRoot, BLACK);
    }

    /**
     * Overrides the default rotation logic so we can re-link the parent nodes that are in RedBlackNodes
     *
     * @param localRoot the node you want to rotate around
     * @return The node that takes the localRoot's place
     */
    protected override BinaryTree.Node rotateLeft(final BinaryTree.Node localRoot) {
        if (localRoot != null) {
            final RedBlackTree.RedBlackNode lr = (RedBlackTree.RedBlackNode) localRoot;
            final RedBlackTree.RedBlackNode rc = (RedBlackTree.RedBlackNode) lr.right;
            lr.right = rc.left;
            if (rc.left != null) {
                final RedBlackTree.RedBlackNode rlc = (RedBlackTree.RedBlackNode) rc.left;
                rlc.parent = lr;
            }
            rc.parent = lr.parent;
            if (lr.parent == null) {
                root = rc;
            } else if (lr == lr.parent.left) {
                lr.parent.left = rc;
            } else {
                lr.parent.right = rc;
            }
            rc.left = lr;
            lr.parent = rc;
            return rc;
        }
        return localRoot;
    }

    /**
     * Overrids the default rotation logic so we can re-link the parent nodes that are in RedBlackNodes
     *
     * @param localRoot the node you want to rotate around
     * @return the node that takes the localRoot's place
     */
    protected override BinaryTree.Node rotateRight(final BinaryTree.Node localRoot) {
        if (localRoot != null) {
            final RedBlackTree.RedBlackNode lr = (RedBlackTree.RedBlackNode) localRoot;
            final RedBlackTree.RedBlackNode lc = (RedBlackTree.RedBlackNode) lr.left;
            lr.left = lc.right;
            if (lc.right != null) {
                final RedBlackTree.RedBlackNode lrc = (RedBlackTree.RedBlackNode) lc.right;
                lrc.parent = lr;
            }
            lc.parent = lr.parent;
            if (lr.parent == null) {
                root = lc;
            } else if (lr == lr.parent.right) {
                lr.parent.right = lc;
            } else {
                lr.parent.left = lc;
            }
            lc.right = lr;
            lr.parent = lc;
            return lc;
        }
        return localRoot;
    }

    /**
     * Gets the successor node. Overides the super method because of parent linking
     *
     * @return the new node
     */
    protected override BinaryTree.Node successor(final BinaryTree.Node localRoot) {
        if (localRoot == null) {
            return null;
        } else if (localRoot.right != null) {
            BinaryTree.Node p = localRoot.right;
            while (p.left != null) {
                p = p.left;
            }
            return p;
        } else {
            RedBlackTree.RedBlackNode p = ((RedBlackTree.RedBlackNode) localRoot).parent;
            RedBlackTree.RedBlackNode ch = (RedBlackTree.RedBlackNode) localRoot;
            while (p != null && ch == p.right) {
                ch = p;
                p = p.parent;
            }
            return p;
        }
    }

    /**
     * RedBlack node. Adds color functionality to BinaryTree.Node
     *
     * @see BinaryTree.Node
     */
    global class RedBlackNode extends BinaryTree.Node {

        /**
         * The color of the node.
         * true = BLACK
         * false = RED
         */
        global Boolean color;

        /** Parent node */
        global RedBlackTree.RedBlackNode parent;

        /**
         * Constructor. Sets the parent node of this node and the contained data.
         * Automatically makes the node BLACK
         *
         * @param o The data to be contained in the node
         * @param parent the parent node
         */
        global RedBlackNode(Object o, RedBlackTree.RedBlackNode parent) {
            super(o);
            this.parent = parent;
            color = BLACK;
        }
    }
}