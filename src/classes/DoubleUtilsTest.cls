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
 * Test class for DoubleUtils
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
 *      <td>03 JAN 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
@IsTest
global class DoubleUtilsTest {

    /**
     * Covers the constants of the utility class.
     * Asserts NEGATIVE_INFINITY == -(POSITIVE_INFINITY)
     * Asserts MAX_VALUE == (2 - Math.pow(2, -52)) * Math.pow(2, 1023)
     * Asserts MIN_VALUE == Math.pow(2, -1074)
     *
     * @see DoubleUtils
     */
    static testMethod void constants() {
        final Double a = DoubleUtils.POSITIVE_INFINITY;
        final Double b = DoubleUtils.NEGATIVE_INFINITY;
        final Double c = DoubleUtils.MAX_VALUE;
        final Double d = DoubleUtils.MIN_VALUE;

        System.assert(b == -(a));
        System.assert(c == ((2 - Math.pow(2, -52)) * Math.pow(2, 1023)));
        System.assert(d == Math.pow(2, -1074));
    }
}