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
 * Compares two SObjects based on the given field. Uses components of the ApexLang package.
 * Implements <strong>Comparator</strong>
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
global class SObjectByFieldComparator implements Comparator {

    /**
     * PrimitiveComparator used to compare the fields.
     *
     * @see PrimitiveComparator
     */
    private final Comparator c = new PrimitiveComparator();

    /** The field to compare by. */
    private String field;

    /**
     * Constructor. Assigns the field variable.
     *
     * @param field The field you want to compare by.
     * @throws IllegalArgumentException
     */
    global SObjectByFieldComparator(String field) {
        if(String.isBlank(field)) {
            throw new IllegalArgumentException('Field cannot be blank or null');
        }
        this.field = field;
    }

    /**
     * Compares the two SObjects by the field property. Returns 0 if one = two.
     * Returns -1 if one < two. Returns 1 if one > two
     *
     * @param one The second object to compare
     * @param two The second SObject to compare
     */
    global Integer compare(Object a, Object b) {
        if(a ==  null && b == null) {
            return 0;
        } else if(a == null) {
            return -1;
        } else if(b == null) {
            return 1;
        }
        return c.compare(((SObject)a).get(field), ((SObject)b).get(field));
    }
}