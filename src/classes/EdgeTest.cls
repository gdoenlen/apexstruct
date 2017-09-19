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
 * Test for the Edge class
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
@isTest
global class EdgeTest {

    /**
     * Tests the equals function of an Edge.
     * An edge is equal if they both have the same <em>source</em> and <em>dest</em>.
     * Asserts: When called against itself e.equals(e) returns true
     * Asserts: 2 different edges with the same source and dest are equal
     * Asserts: Edges with different source and dest are not equal
     * Asserts: an edge is not equal to a different object type
     *
     * @see Edge.equals
     */
    static testMethod void equals() {
        //equals itself == true
        final Edge e = new Edge(1, 2);
        System.assert(e.equals(e));

        //different weights, but they have the same source and dest
        final Double d = 5.0;
        final Edge t = new Edge(1, 2, d);
        System.assert(e.equals(t));

        //different source and dest
        final Edge r = new Edge(2, 1);
        System.assert(!e.equals(r));

        //completly different types
        System.assert(!e.equals('test'));
    }


    /**
     * Tests the hashCode functionality
     * Asserts: Edges with the same source/dest will have the same hashcode
     * Asserts: Edges with different source/dest will not have the same hashcode
     *
     * @see Edge.hashCode
     */
    static testMethod void hash() {
        //2 edges with the same source and dest should have the same hashcode, weight doesn't matter
        final Edge e = new Edge(1, 2);
        final Double d = 5.0;
        final Edge t = new Edge(1, 2, d);
        System.assertEquals(e.hashCode(), t.hashCode());

        //edges with different source/dest shouldn't be equal
        final Edge r = new Edge(2, 1);
        System.assertNotEquals(e.hashCode(), r.hashCode());
    }

    /**
     * Tests the getters of the private fields.
     *
     * @see Edge.getSource
     * @see Edge.getDest
     * @see Edge.getWeight
     */
    static testMethod void gets() {
        final Edge e = new Edge(1, 2);
        System.assertEquals(1, e.getSource());
        System.assertEquals(2, e.getDest());
        final Double d = 1.0;
        System.assertEquals(d, e.getWeight());

        final Double r = 7.0;
        final Edge t = new Edge(2, 1, r);
        System.assertEquals(r, t.getWeight());
    }
}