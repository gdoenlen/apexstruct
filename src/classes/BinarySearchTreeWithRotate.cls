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
 * Extension of BinarySearchTree. Provides the capabilities to rotate left and right on a node.
 * This class should be extended for uses in AVL, red/black, etc trees.
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
global abstract class BinarySearchTreeWithRotate extends BinarySearchTree {

    /**
     * Constructor. Simply calls to its super class
     *
     * @param comp The comparator used to compare the objects
     * @param t The type of objects in the collection
     */
    global BinarySearchTreeWithRotate(final Comparator comp, final Type t) {
        super(comp, t);
    }

    /**
     * Constructor, simply calls to its super class
     *
     * @param comp The comparator used to compare the objects
     * @param root The root node of the tree
     * @param Type the type of objects in the collection
     */
    protected BinarySearchTreeWithRotate(final Comparator comp, final BinaryTree.Node root, final Type t) {
        super(comp, root, t);
    }

    /**
     * Constructor, simply calls the super constructor
     *
     * @param comp the comparator used to compare the objects
     * @param data the data that is set to the root of the new tree
     * @param left The left child of the new tree
     * @param right the right child of the new tree
     */
    global BinarySearchTreeWithRotate(final Comparator comp, final Object data, final BinarySearchTreeWithRotate left,
                                      final BinarySearchTreeWithRotate right, final Type t)
    {
        super(comp, data, left, right, t);
    }

    /**
     * Rotates a tree to the right around the given root node
     *
     * @param localRoot the node to rotate around
     * @return the new root of the binarytree
     */
    protected virtual BinaryTree.Node rotateRight(final BinaryTree.Node localRoot) {
        final BinaryTree.Node temp = localRoot.left;
        localRoot.left = temp.right;
        temp.right = localRoot;
        return temp;
    }

    /**
     * Rotates a tree to the left around the given root node
     *
     * @param localRoot the node to rotate around
     */
    protected virtual BinaryTree.Node rotateleft(final BinaryTree.Node localRoot) {
        final BinaryTree.Node temp = localRoot.right;
        localRoot.right = temp.left;
        temp.left = localRoot;
        return temp;
    }
}