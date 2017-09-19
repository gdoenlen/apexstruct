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
 * Test class for the PrimitiveComparator
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
private class PrimitiveComparatorTest {

    /**
     * Tests null forms.
     *
     * @see PrimitiveComparator
     */
    static testMethod void compare() {
        final PrimitiveComparator c = new PrimitiveComparator();
        final Integer a = null;
        final Integer b = null;
        System.assert(c.compare(a, b) == 0);
        //System.assert(c.compare(a, 1) == -1);
        System.assert(c.compare(1, b) == 1);
    }

    /**
     * Tests booleans.
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareBooleans() {
        final PrimitiveComparator c = new PrimitiveComparator();
        System.assert(c.compare(false, true) == -1);
        System.assert(c.compare(true, true) == 0);
        System.assert(c.compare(true, false) == 1);
    }

    /**
     * Tests dates.
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareDates() {
        final PrimitiveComparator c = new PrimitiveComparator();
        System.assert(c.compare(Date.today(), Date.today().addDays(1)) == -1);
        System.assert(c.compare(Date.today(), Date.today()) == 0);
        System.assert(c.compare(Date.today().addDays(1), Date.today()) == 1);
    }

    /**
     * Tests DateTimes.
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareDateTimes() {
        final PrimitiveComparator c = new PrimitiveComparator();
        System.assert(c.compare(DateTime.now(), DateTime.now().addDays(1)) == -1);
        System.assert(c.compare(DateTime.now(), DateTime.now()) == 0);
        System.assert(c.compare(DateTime.now().addDays(1), DateTime.now()) == 1);
    }

    /**
     * Tests Doubles.
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareDoubles() {
        final PrimitiveComparator c = new PrimitiveComparator();
        final Double d1 = 3.14;
        final Double d2 = 5.1;
        final Double d3 = 5.1;
        System.assert(c.compare(d1, d2) == -1);
        System.assert(c.compare(d2, d3) == 0);
        System.assert(c.compare(d2, d1) == 1);
    }

    /**
     * Tests Integers
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareIntegers() {
        final PrimitiveComparator c = new PrimitiveComparator();
        System.assert(c.compare(1, 2) == -1);
        System.assert(c.compare(0, 0) == 0);
        System.assert(c.compare(2, 1) == 1);
    }

    /**
     * Tests Longs
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareLongs() {
        final PrimitiveComparator c = new PrimitiveComparator();
        final Long l1 = 12345;
        final Long l2 = 12344;
        final Long l3 = 12345;
        System.assert(c.compare(l2, l1) == -1);
        System.assert(c.compare(l1, l3) == 0);
        System.assert(c.compare(l1, l2) == 1);
    }

    /**
     * Tests Strings
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareStrings() {
        final PrimitiveComparator c = new PrimitiveComparator();
        System.assert(c.compare('a', 'b') == -1);
        System.assert(c.compare('a', 'a') == 0);
        System.assert(c.compare('b', 'a') == 1);
    }

    /**
     * Tests Times
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareTimes() {
        final PrimitiveComparator c = new PrimitiveComparator();
        final Time t1 = Time.newInstance(1, 2, 3, 4);
        final Time t2 = Time.newInstance(4, 2, 3, 4);
        final Time t3 = Time.newInstance(1, 2, 3, 4);
        System.assert(c.compare(t1, t2) == -1);
        System.assert(c.compare(t1, t3) == 0);
        System.assert(c.compare(t2, t1) == 1);
    }

    /**
     * Tests 2 different object types. An IllegalArgumentException should be thrown.
     *
     * @see PrimitiveComparator
     */
    static testMethod void compareException() {
        final PrimitiveComparator c = new PrimitiveComparator();
        try {
            c.compare(true, 'a');
        } catch (Exception e) {
            System.assert(e instanceof IllegalArgumentException);
        }
    }
}