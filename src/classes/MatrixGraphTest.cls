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
 * Test for the MatrixGraph class
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
 *      <td>03 JAN 2017</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
@IsTest
global class MatrixGraphTest {

    /**
     * Tests all functionality of the MatrixGraph class
     * Asserts: the number of vertices are the same after contruction
     * Asserts: direction is the same after construction
     * Asserts: an edge can be found after insertion
     * Asserts: an edge not in the graph is NOT found
     * Asserts: the edge iterator returns all edges in the source
     *
     * @see MatrixGraph
     */
    static testMethod void test() {
        final Graph g = new MatrixGraph(10, false);
        System.assertEquals(10, g.getNumV());
        System.assertEquals(false, g.isDirected());

        for (Integer i = 0; i < 10; i++) {
            g.ins(new Edge(1, i));
            System.assert(g.isEdge(1, i));
            //directed == false
            System.assert(g.isEdge(i, 1));
        }
        System.assert(!g.isEdge(1, 15));
        final Iterator<Edge> it = g.edgeIterator(1);
        while (it.hasNext()) {
            final Edge e = it.next();
            System.assertEquals(1, e.getSource());
        }
    }
}