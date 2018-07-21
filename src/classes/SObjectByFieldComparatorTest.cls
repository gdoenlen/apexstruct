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
 * Test class for the SObjectByFieldComparator
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
 *      <td>27 APR 2016</td>
 *      <td>Updated to 2016 apex standards.</td>
 *      <td>1.0</td>
 *  </tr>
 * </table>
 */
@IsTest
private class SObjectByFieldComparatorTest {

    /**
     * Tests the constructor. An IlleaglArgumentException should be thrown if f == '' || f == '  ' || f == null
     *
     * @see SObjectComparator
     */
    static testMethod void compareException() {
        try {
            final SObjectByFieldComparator c = new SObjectByFieldComparator('', null);
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }

        try {
            final SObjectByFieldComparator c = new SObjectByFieldComparator('  ', null);
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }

        try {
            final SObjectByFieldComparator c = new SObjectByFieldComparator(null);
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
    }


    /**
     * Tests null values.
     *
     * @see SObjectByFieldComparator
     */
    static testMethod void compareNulls() {
        final SObjectByFieldComparator c = new SObjectByFieldComparator('Name', new PrimitiveComparator());
        SObject one;
        SObject two;
        final Account a = new Account(Name = 'a');
        System.assert(c.compare(one, two) == 0);
        System.assert(c.compare(one, a) == -1);
        System.assert(c.compare(a, two) == 1);
    }

    /**
     * Tests non null sobjects
     *
     * @see SObjectByFieldComparator
     */
    static testMethod void compare() {
        final SObjectByFieldComparator c = new SObjectByFieldComparator('Name', new PrimitiveComparator());
        final Account a = new Account(Name = 'a');
        final Account b = new Account(Name = 'b');
        System.assert(c.compare(a, b) == -1);
    }
}
