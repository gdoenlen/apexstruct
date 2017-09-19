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
 * Implementation of single pivot quick sort.
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
 *      <td>11 OCT 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
global class SinglePivotQuickSort {

    /** Constructor. Prevents Instantiation. */
    private SinglePivotQuickSort() {

    }

    /**
     * Recursively sorts an array in place using a Comparator object.
     *
     * @param a The array
     * @param c The Comparator object
     */
    global static void sort(final Object[] a, final Comparator c) {
        sort(a, c, 0, a.size() - 1);
    }

    /**
     * Recursively sorts an array in place using a Comparator object.
     *
     * @param a The array
     * @param c The comparator
     * @param lo0 Where to start the sort
     * @param hi0 Where to end the sort
     */
    global static void sort(final Object[] a, final Comparator c, final Integer lo0, final Integer hi0) {
        final Integer lo = lo0;
        final Integer hi = hi0;

        if (lo >= hi) {
            return;
        } else if (lo == hi - 1) {
            if (c.compare(a[lo], a[hi]) > 0) {
                final Object t = a[lo];
                a[lo] = a[hi];
                a[hi] = t;
            }
            return;
        }

        final Object pivot = a[(lo + hi) / 2];
        a[(lo + hi) / 2] = a[hi];
        a[hi] = pivot;

        while (lo < hi) {
            while (c.compare(a[lo], pivot) <= 0 && lo < hi) {
                lo++;
            }
            while (c.compare(pivot, a[hi]) <= 0 && lo < hi) {
                hi--;
            }
            if (lo < hi) {
                Object t = a[lo];
                a[lo] = a[hi];
                a[hi] = t;
            }
        }

        a[hi0] = a[hi];
        a[hi] = pivot;

        sort(a, c, lo0, lo - 1);
        sort(a, c, hi + 1, hi0);
    }
}