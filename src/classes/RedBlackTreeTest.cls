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
 * Test for the RedBlackTree class
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
@IsTest
global class RedBlackTreeTest {

    /**
     * Tests the add method by adding integers that would cause an extemely unbalanced
     * right heay binarysearchtree
     * Asserts: all elements are added
     *
     * @see RedBlackTree.add
     */
    static testMethod void addRightHeavy() {
        final BinarySearchTree rbt = new RedBlackTree(new PrimitiveComparator(), Integer.class);
        for(Integer i = 0; i < 50; i++) {
            System.assert(rbt.add(i));
        }
    }

    /**
     * Tests the add method by adding integers that would cause an extremely unbalanced
     * left heavy binary search tree
     * Asserts: all elements are added
     *
     * @see RedBlackTree.add
     */
    static testMethod void addLeftHeavy() {
        final BinarySearchTree rbt = new RedBlackTree(new PrimitiveComparator(), Integer.class);
        for(Integer i = 50; i >= 0; i--) {
            System.assert(rbt.add(i));
        }
    }

    /**
     * Tests the del method.
     * Asserts: The data you expect is returned if found
     * Asserts: after calling del the data is no longer in the tree
     * Asserts: if the data isn't found returns null
     *
     */
    static testMethod void del() {
        final BinarySearchTree rbt = new RedBlackTree(new PrimitiveComparator(), Integer.class);
        for(Integer i = 0; i < 50; i++) {
            rbt.add(i);
        }
        System.assertEquals(25, rbt.del(25));
        System.assertEquals(false, rbt.contains(25));
        System.assertEquals(null, rbt.del(50));
        System.assertEquals(false, rbt.contains(50));
    }
}