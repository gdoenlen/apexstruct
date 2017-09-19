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
 * Test class for BinarySearch
 * <table>
 *  <caption>Modification Log</caption>
 *  <tr>
 *      <th>Developer</th>
 *      <th>Date</th>
 *      <th>Description</th>
 *      <th>Version</th>
 *  </tr>
 *   <tr>
 *      <td>George Doenlen</td>
 *      <td>27 APR 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0</td>
 *   </tr>
 * </table>
 */
@IsTest
private class BinarySearchTest {

    /**
     * Tests find functionality on primitives.
     * Asserts:
     *  - -1 if the object is not in the array.
     *  - Location of the object if it is present.
     *
     * @see BinarySearch.search
     */
    static testMethod void objectSearch() {
        final Integer[] a = new Integer[] {
                0, 1, 2, 3, 4, 5, 6, 7, 8, 9
        };
        Integer t = BinarySearch.find(a, a[3], new PrimitiveComparator());
        System.assertEquals(3, t);
        t = BinarySearch.find(a, 12, new PrimitiveComparator());
        System.assertEquals(-1, t);
    }

    /**
     * Tests search functionality on  sObjects
     * Asserts:
     * - -1 if the object is not in the array.
     * - Location of the object if it is present.
     *
     * @see BinarySearch.search
     */
    static testMethod void sObjectSearch() {
        final List<Account> a = new List<Account>();
        for (Integer i = 0; i < 10; i++) {
            a.add(new Account(Name = 'Test' + i));
        }
        Integer t = BinarySearch.find(a, a[3], new SObjectByFieldComparator('Name'));
        System.assertEquals(3, t);
        t = BinarySearch.find(a, new Account(Name = 'Growth Systems'), new SObjectByFieldComparator('Name'));
        System.assertEquals(-1, t);
    }
}