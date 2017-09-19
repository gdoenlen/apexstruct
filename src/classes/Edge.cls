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
 * Edge class to be used with the Graph ADT. Represents an edge between two vertices.
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
global class Edge {

    /** Destination vertex */
    private final Integer dest;

    /** Source vertex */
    private final Integer source;

    /** Weight of the edge */
    private final Double weight;

    /** hashCode of this edge */
    private Integer hashCode;

    /**
     * Constructs an <strong>Edge</strong> from <em>source</em> to <em>dest</em>.
     * Sets <em>weight</em> to 1.0
     *
     * @param source the source vertex
     * @param dest the dest vertex
     */
    global Edge(final Integer source, final Integer dest) {
        this.source = source;
        this.dest = dest;
        this.weight = 1.0;
    }

    /**
     * Constructs an <strong>Edge</strong> from <em>source</em> to <em>dest</em>
     * with the given <em>weight</em>.
     *
     * @param source source vertex
     * @param dest destination vertex
     * @param weight weight of the edge
     */
    global Edge(final Integer source, final Integer dest, final Double weight) {
        this.source = source;
        this.dest = dest;
        this.weight = weight;
    }

    /**
     * Checks for equality between this object and another by comparing their source and dest.
     * Weight is not considered.
     *
     * @param o an object
     * @return true if o is an instance of Edge and their source and dest are the same
     */
    global Boolean equals(final Object o) {
        //causes an stack limit to be reach. this doesn't make sense. should only compare memory addresses
        //if(this == o){ return true; }
        if (!(o instanceof Edge)) {
            return false;
        }
        final Edge that = (Edge) o;
        return (this.source == that.source && this.dest == that.dest);
    }


    /**
     * Calculates the hashCode using the source and dest. Weight is not considered.
     * The hashcode is only computed once since edge dest and source are immutable.
     *
     * @return the hashcode of the source and dest
     * @see HashCodeUtil
     */
    global override Integer hashCode() {
        if (hashCode == null) {
            hashCode = new HashCodeUtil().addHash(source).addHash(dest).getHash();
        }
        return hashCode;
    }

    /**
     * Gets the destination vertex
     *
     * @return dest
     */
    global Integer getDest() {
        return dest;
    }

    /**
     * Gets the source vertex
     *
     * @return source
     */
    global Integer getSource() {
        return source;
    }

    /**
     * Gets the weight of the edge
     *
     * @return weight
     */
    global Double getWeight() {
        return weight;
    }

}