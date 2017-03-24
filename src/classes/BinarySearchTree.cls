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
 * Binary search tree implementation. This implementation requires a comparator object
 * to compare the objects as SObject does not directly implement compareTo.
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
global abstract class BinarySearchTree extends BinaryTree implements SearchTree {

    /** The return value from the current add operation */
    protected Boolean addReturn;

    /** The return value from the current delete operation */
    protected Object deleteReturn;

    /** The comparator this tree uses to compare it's objects */
    protected Comparator comp;

    /**
     * Constructor. Sets the type of the tree and the comparator to compare objects
     *
     * @param comp The comparator used to compare the objects
     * @param t the type of objects stored in the tree
     * @see Comparator
     */
    global BinarySearchTree(Comparator comp, Type t) {
        super(t);
        this.comp = comp;
    }

    /**
     * Constructor. Only used to create subtrees from the root.
     *
     * @param comp The comparator, passed from the current tree
     * @param root the new root node for the tree
     * @param t the type of the objects stored, passed from the current tree
     */
    protected BinarySearchTree(Comparator comp, BinaryTree.Node root, Type t) {
        super(root, t);
        this.comp = comp;
    }

    /**
     * Constructor. Sets the initial data and sub trees.
     *
     * @param comp Comparator to compare the stored objects
     * @param data the initial root data
     * @param left The left subtree
     * @param right the right subtree
     * @param t the type of objects stored
     */
    global BinarySearchTree(Comparator comp, Object data, BinarySearchTree left, BinarySearchTree right, Type t) {
        super(data, left, right, t);
        this.comp = comp;
    }

    /**
     * Checks if the tree contains a specific data item.
     * Uses find(Object) logic.
     *
     * @param o the object to find
     * @return true if the object is in the tree
     */
    global override Boolean contains(Object o) {
        return find(o) == null ? false : true;
    }

    /**
     * Recursively searchs the tree to find the target.
     *
     * @param target the object you're looking for
     * @return reference to the found object or null if it's not found
     */
    global Object find(Object target) {
        BinaryTree.Node localRoot = getNode(root, target);
        return localRoot != null ? localRoot.data : null;
    }


    /**
     * Recursively searchs the tree for the node that contains the target data
     *
     * @param localRoot the local node to begin the search at
     * @param target the target data you are looking for
     * @return the node that contains the target data or null if it's not found
     */
    protected BinaryTree.Node getNode(BinaryTree.Node localRoot, Object target) {
        if(localRoot == null) {
            return null;
        }

        Integer result = comp.compare(target, localRoot.data);
        if(result == 0) {
            return localRoot;
        } else if(result < 0) {
            return getNode(localRoot.left, target);
        } else {
            return getNode(LocalRoot.right, target);
        }
    }

    /**
     * Removes an item from the collection. Uses the same logic as del
     *
     * @param o The object to be removed
     * @return true if it was successfully removed, false otherwise
     * @see BinarySearchTree.del
     */
    global override Boolean remove(Object o) {
        if(del(o) != null) {
            return true;
        } else {
            return false;
        }
    }

    /**
     * deletes the object from the tree
     *
     * @param o The object to delete from the tree
     * @return the reference to the object in the tree.
     */
    global virtual Object del(Object o) {
        root = del(root, o);
        return deleteReturn;
    }

    /**
     * Recursively finds the node to delete.
     *
     * @param localRoot the localroot to start the search from
     * @param o the object to remove
     * @return the node that will replace the removed one
     */
    protected virtual BinaryTree.Node del(BinaryTree.Node localRoot, Object o) {
        if(localRoot == null) {
            deleteReturn = null;
            return localRoot;
        }
        Integer result = comp.compare(o, localRoot.data);
        if(result < 0) {
            localRoot.left = del(localRoot.left, o);
            return localRoot;
        } else if(result > 0) {
            localRoot.right = del(localRoot.right, o);
            return localRoot;
        } else {
            deleteReturn = localRoot.data;
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
     * Recursively finds the inorder predecessor of a node
     *
     * @param localRoot the node to start from.
     */
    protected virtual BinaryTree.Node predecessor(BinaryTree.Node localRoot) {
        if(localRoot.right.right == null) {
            BinaryTree.Node ret = localRoot.right;
            localRoot.right = localRoot.right.left;
            return ret;
        } else {
            return predecessor(localRoot.right);
        }
    }

    /**
     * Recursively finds the inorder successor of a node
     *
     * @param localRoot the node to start from.
     */
    protected virtual BinaryTree.Node successor(BinaryTree.Node localRoot) {
        if(localRoot.left.left == null) {
            BinaryTree.Node ret = localRoot.left;
            localRoot.left = localRoot.left.right;
            return ret;
        } else {
            return successor(localRoot.left);
        }
    }

}