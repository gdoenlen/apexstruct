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
 * Compares two Objects.
 * Implements <strong>ObjectComparator</strong>
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
 *      <td>7 JUN 2016</td>
 *      <td>Adapted from Apex Lang package</td>
 *      <td>1.0</td>
 *   </tr>
 * </table>
 */
global class PrimitiveComparator implements Comparator {

    /** Empty Constructor */
    global PrimitiveComparator() {

    }

    /**
     * Compares two objects by casting them to the appropriate type.
     * Both arguments must be of the same type
     *
     * @param one First object
     * @param two Second Object
     * @return one < two: -1, one == two: 0, one > two: 1
     * @throws IllegalArgumentException
     */
    global Integer compare(Object one, Object two){
        if(one==null && two==null) { return 0; }
        else if(one==null) { return -1; }
        else if(two==null) { return 1; }
        else if(one instanceof Boolean && two instanceof Boolean) {
            return compare((Boolean)one, (Boolean)two);
        } else if(one instanceof Date && two instanceof Date) {
            return compare((Date)one, (Date)two);
        } else if(one instanceof Datetime && two instanceof Datetime) {
            return compare((Datetime)one, (Datetime)two);
        } else if(one instanceof Integer && two instanceof Integer) {
            return compare((Integer)one, (Integer)two);
        } else if(one instanceof Long && two instanceof Long) {
            return compare((Long)one, (Long)two);
        } else if(one instanceof Double && two instanceof Double) {
            return compare((Double)one, (Double)two);
        } else if(one instanceof Time && two instanceof Time) {
            return compare((Time)one, (Time)two);
        } else if(one instanceof String && two instanceof String) {
            return compare((String)one, (String)two);
        } else {
            throw new IllegalArgumentException(
            'Both arguments must be type Boolean, Date, Datetime, Decimal, Double, ID, Integer, Long, Time, or String');
        }
    }

    /**
     * Compares two booleans.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Boolean one, Boolean two){
        if(!one && two)     return -1;
        else if(one == two) return 0;
        else                return 1;
    }

    /**
     * Compares two dates.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Date one, Date two) {
        if(one < two)       return -1;
        else if(one == two) return 0;
        else                return 1;
    }

    /**
     * Compares two datetimes.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Datetime one, Datetime two){
        if(one < two)       return -1;
        else if(one == two) return 0;
        else                return 1;
    }

    /**
     * Compares two doubles.
     *
     * @param one first object.
     * @param twi second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Double one, Double two){
        if(one < two)       return -1;
        else if(one == two) return 0;
        else                return 1;
    }

    /**
     * Compares two integers.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Integer one, Integer two){
        if(one < two)        return -1;
        else if(one == two)  return 0;
        else                 return 1;
    }

    /**
     * Compares two longs.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Long one, Long two){
        if(one < two)       return -1;
        else if(one == two) return 0;
        else                return 1;
    }

    /**
     * Compares two strings.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(String one, String two){
        if(one < two)       return -1;
        else if(one == two) return 0;
        else                return 1;
    }

    /**
     * Compares two times.
     *
     * @param one first object.
     * @param two second object
     * @return one < two: -1, one == two: 0, one > two: 1
     */
    global Integer compare(Time one, Time two){
        if(one < two)       return -1;
        else if(one == two) return 0;
        else                return 1;
    }

}