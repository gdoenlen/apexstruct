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
 * Abstract implementation of the graph ADT.
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
global abstract class AbstractGraph implements Graph {

    /** true if this is a directed graph */
    protected final Boolean directed;

    /** number of vertices */
    protected final Integer numV;

    /**
     * Constructs an empty graph with the given number of vertices and direction
     *
     * @param numV the number of vertices
     * @param directed true if this is a directed graph
     */
    global AbstractGraph(final Integer numV, final Boolean directed) {
        this.directed = directed;
        this.numV = numV;
    }

    /**
     * Gets the number of vertices in the graph
     *
     * @return numV
     */
    global Integer getNumV() {
        return numV;
    }

    /**
     * Checks if this is a directed graph
     *
     * @return true if directed
     */
    global Boolean isDirected() {
        return directed;
    }
}