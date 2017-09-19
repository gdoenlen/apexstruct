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
 * Test class for HashCodeUtil
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
 *      <td>29 DEC 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
@IsTest
global class HashCodeUtilTest {

    /**
     * Tests the addHash(int) function.
     * Asserts: Adding the same integer in 2 different instances equals the same hash
     *
     * @see HashCodeUtil.addHash
     */
    static testMethod void addInt() {
        final HashCodeUtil a = new HashCodeUtil();
        final HashCodeUtil b = new HashCodeUtil();

        System.assertEquals(a.addHash(217).getHash(), b.addhash(217).getHash());
    }

    /**
     * Tests the addHash(bool) function
     * Asserts: Adding the same boolean in 2 different instances equals the same hash
     *
     * @see HashCodeUtil.addHash
     */
    static testMethod void addBoolean() {
        final HashCodeUtil a = new HashCodeUtil();
        final HashCodeUtil b = new HashCodeUtil();

        System.assertEquals(a.addHash(true).getHash(), b.addHash(true).getHash());
    }

    /**
     * Tests the addHash(long) function
     * Asserts: Adding the same long in 2 different instances equals the same hash
     *
     * @see HashCodeUtil.addHash
     */
    static testMethod void addLong() {
        final HashCodeUtil a = new HashCodeUtil();
        final HashCodeUtil b = new HashCodeUtil();

        System.assertEquals(a.addHash(1234567L).getHash(), b.addHash(1234567L).getHash());
    }

    /**
     * Tests the addHash(decimal) function
     * Asserts: Adding the same decimal in 2 different instances equals the same hash
     *
     * @see HashCodeUtil.addHash
     */
    static testMethod void addDecimal() {
        final HashCodeUtil a = new HashCodeUtil();
        final HashCodeUtil b = new HashCodeUtil();

        System.assertEquals(a.addHash(2.0).getHash(), b.addHash(2.0).getHash());
    }

    /**
     * Tests the addHash(double) function
     * Asserts: Adding the same double in 2 different instances equals the same hash
     *
     * @see HashCodeUtil.addHash
     */
    static testMethod void addDouble() {
        final HashCodeUtil a = new HashCodeUtil();
        final HashCodeUtil b = new HashCodeUtil();

        final Double d = 2.0;

        System.assertEquals(a.addHash(d).getHash(), b.addHash(d).getHash());
    }

    /**
     * Tests the addHash(object) function
     * Asserts: Adding a null object calculates the hash of the integer 0
     * Asserts: Adding an object that isn't an Array/List add's it's hashCode() to the current hash
     * Asserts: Adding an array/list will add the hashCode() of all it's objects
     *
     * @see HashCodeUtil.addHash
     */
    static testMethod void addObject() {
        HashCodeUtil a = new HashCodeUtil();
        HashCodeUtil b = new HashCodeUtil();

        Object o;
        System.assertEquals(a.addHash(o).getHash(), b.addHash(0).getHash());

        a = new HashCodeUtil();
        b = new HashCodeUtil();
        final Integer i = 'test'.hashCode();
        System.assertEquals(a.addHash('test').getHash(), b.addHash(i).getHash());

        a = new HashCodeUtil();
        b = new HashCodeUtil();
        final List<String> lst = new List<String>();
        final List<Integer> sum = new List<Integer>();
        for (Integer j = 0; j < 100; j++) {
            final String t = 'Test ' + j;
            lst.add(t);
            sum.add(t.hashCode());
        }
        System.assertEquals(a.addHash(sum).getHash(), b.addHash(lst).getHash());
    }
}