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
 * Utility to calculate complex hashcodes on custom objects.
 * Based on the recommendations from Effective Java by Joshua Bloch
 *
 * All hashes are calculated using hash * 31 + (hash of the object given)
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
 *  <tr>
 *     <td>George Doenlen</td>
 *     <td>13 MAY 2021</td>
 *     <td>Use system hash codes instead of calculating ourselves</td>
 *     <td>1.0.1</td>
 *  </tr>
 * </table>
 */
global class HashCodeUtil {

    /**
     * Prime number used in the calculation. will provide better distribution.
     * 31 is chosen because it is an odd prime that will not overflow on multiplication
     * and it is easily calculated by shifting, making it easy for the compiler to optimize
     * the multiplication.
     */
    global static final Integer PRIME = 31;

    /** starting value of the hash should always be non-zero. 17 is chosen arbitralily. */
    private Integer hash = 17;

    /** Empty constructor */
    global HashCodeUtil() {

    }

    /**
     * Adds the hash of the given object to the calculation. 
     *
     * @param o an object
     * @see Object.hashCode
     */
    global HashCodeUtil addHash(Object o) {
        this.add(o == null ? 0 : o.hashCode());
        
        return this;
    }
   
    private void add(Integer i) {
        this.hash = (this.hash * PRIME) + i;  
    } 

    /**
     * Returns the current hash
     *
     * @return hash
     */
    global Integer getHash() {
        return this.hash;
    }
}
