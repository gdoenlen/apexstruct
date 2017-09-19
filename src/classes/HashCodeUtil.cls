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
     * Adds the hash of the integer to the current hash
     *
     * @param i an Integer
     */
    global HashCodeUtil addHash(final Integer i) {
        hash = calculateSeed() + (Integer) i;
        return this;
    }

    /**
     * Calculates the hash of a boolean by using b ? 1 : 0
     *
     * @param b a boolean
     */
    global HashCodeUtil addHash(final Boolean b) {
        hash = calculateSeed() + (b ? 1 : 0);
        return this;
    }

    /**
     * Calculates the hash of a long via shifting (l ^ l >>> 32)
     *
     * @param l a long value
     */
    global HashCodeUtil addHash(final Long l) {
        hash = calculateSeed() + (Integer)(l ^ l >>> 32);
        return this;
    }

    /**
     * Calculates the hash of a double. Uses double.longValue() and recursively calls itself.
     * Dev note: Effective java's implementation recommends using double.doubleToLongBits
     * we can't do this in apex. We can't even write it ourselves as that method is "native" in java.
     *
     * This could possibly result in collisions due to the loss of precision from double -> long
     *
     * @param d a double
     * @see Double.longValue()
     */
    global HashCodeUtil addHash(final Double d) {
        return addHash(d.longValue());
    }

    /**
     * Calculates the hash of a decimal. Uses Decimal.longValue() and recursively calls itself
     * Dev note: Effective java's implementation recommends using double.doubleToLongBits
     * we can't do this in apex. We can't even write it ourselves as that method is "native" in java.
     *
     * This could possibly result in collisions due to the loss of precision from double -> long
     *
     * @param d a decimal value
     * @see Decimal.longValue()
     */
    global HashCodeUtil addHash(final Decimal d) {
        return addHash(d.longValue());
    }

    /**
     * Calculates the hash of an object.
     * If the object == null it will calculate the hash of the integer 0.
     * If the object is NOT a list/array it will calculate with the resulting hashCode().
     * If the object is a list/array it will calculate the hash for each item in the list
     *
     * @param o an object
     * @see Object.hashCode
     */
    global HashCodeUtil addHash(final Object o) {
        if (o == null) {
            addHash(0);
        } else if (!(o instanceof List<Object>)) {
            addHash(o.hashCode());
        } else {
            final List<Object> that = (List<Object>) o;
            final Integer size = that.size();
            for (Integer i = 0; i < size; i++) {
                addHash(that.get(i));
            }
        }
        return this;
    }

    /**
     * Calculates the seed of the hash before adding the new hash. hash * PRIME
     *
     * @return hash * PRIME
     */
    private Integer calculateSeed() {
         return hash * PRIME;
    }

    /**
     * Returns the current hash
     *
     * @return hash
     */
    global Integer getHash() {
        return hash;
    }
}