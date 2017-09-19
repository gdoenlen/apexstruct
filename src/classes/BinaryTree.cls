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
 * BinaryTree implementation
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
global abstract class BinaryTree extends AbstractCollection {

    /** Root node */
    protected BinaryTree.Node root;

    /** Number of items in the tree */
    protected Integer size;

    /**
     * Constructor. Sets the type of the collection.
     *
     * @param t Type of the collection
     */
    global BinaryTree(final Type t) {
        super(t);
        size = 0;
    }

    /**
     * Constructor. Sets the root node and type of the collection.
     *
     * @param root The new root node
     * @param t Type of the collection
     */
    protected BinaryTree(final BinaryTree.Node root, final Type t) {
        this(t);
        this.root = root;
    }

    /**
     * Constructs a binary tree with the given data at the root and the given trees
     * as the left and right sub trees
     *
     *
     */
    global BinaryTree(final Object data, final BinaryTree left, final BinaryTree right, final Type t) {
        this(t);
        root = new BinaryTree.Node(data);
        root.left = left.root;
        root.right = right.root;
    }

    /**
     * Returns the number of elements in the tree
     *
     * @return the size property
     */
    global override Integer size() {
        return size;
    }

    /**
     * Returns the left subtree of this tree's root
     *
     * @return  A new tree made from roots.left property
     */
    global abstract BinaryTree getLeftSubTree();

    /**
     * Return the right subtree of this tree's root
     *
     * @return a new tree made form the root's .right property
     */
    global abstract BinaryTree getRightSubTree();

    /**
     * Preorder traverses the tree to put all of its data elements into an array
     * This method will not return be in order of insertion.
     *
     * @return Array of all data elements in the tree.
     */
    global override Object[] toArray() {
        final Object[] arr = new Object[size()];
        preorderTraverse(root, arr);
        return arr;

    }

    /**
     * Recursively preorder traverses the tree and adds each data element to the array
     *
     * @param localRoot the node to start at
     */
    private void preorderTraverse(final BinaryTree.Node localRoot, final Object[] arr) {
        if(localRoot != null) {
            arr.add(localRoot.data);
            preorderTraverse(localRoot.left, arr);
            preorderTraverse(localRoot.right, arr);
        }
    }

    global virtual class Node {

        /** The left child node */
        global BinaryTree.Node left;

        /** The right child node */
        global BinaryTree.Node right;

        /** the data of this node */
        global Object data;

        /**
         * Constructor. Instantiates data.
         *
         * @param o The data of this node.
         */
        global BinaryTree.Node(final Object o) {
            this.data = o;
        }

        /**
         * Checks if a node is a leaf node
         *
         * @return true if this node has no children
         */
        global Boolean isLeaf() {
            return left == null && right == null;
        }
    }

    global override Iterator<Object> iterator() {
        return new BinaryTreeIterator(this);
    }

    global override void clear() {
        root = null;
        size = 0;
    }

    private class BinaryTreeIterator implements Iterator<Object> {

        private final BinaryTree tree;

        private final Object[] arr;

        private Integer position;

        public BinaryTreeIterator(final BinaryTree tree) {
            this.tree = tree;
            arr = tree.toArray();
            position = 0;
        }

        public Boolean hasNext() {
            return position == arr.size();
        }

        public Object next() {
            return arr[position++];
        }
    }
}