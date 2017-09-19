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
 * Recursive implementation of a binary search algorithm.
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
global class BinarySearch {

    /** Constructor. Prevents instantiation. */
    private BinarySearch() {

    }

    /**
     * Finds the target Object in the array.
     *
     * @param a The array you are looking in.
     * @param t The target Object you want to find in the array.
     * @param c The comparator used to compare the Objects.
     * @return The location of the target in the array. Returns -1 if it is not present.
     * @see Comparator
     */
    global static Integer find(final Object[] a, final Object t, final Comparator c) {
        return find(a, t, c, 0, a.size() - 1);
    }

    /**
     * Finds the target Object in the array.
     *
     * @param a The array you are looking in.
     * @param t The target Object you want to find in the array.
     * @param c The comparator used to compare the Objects.
     * @param low The left side of the array we are looking in.
     * @param high The right side of teh array we are looking in.
     * @return The location of the target in the array. Returns -1 if it is not present.
     * @see Comparator
     */
    global static Integer find(final Object[] a, final Object t, final Comparator c, final Integer low,
                               final Integer high)
    {
        if (high < low) {
            return -1;
        } else {
            final Integer mid = low + ((high - low) / 2);
            if (c.compare(a[mid], t) >= 1) {
                return find(a, t, c, low, mid - 1);
            } else if (c.compare(a[mid], t) <= -1) {
                return find(a, t, c, mid + 1, high);
            } else {
                return mid;
            }
        }
    }
}