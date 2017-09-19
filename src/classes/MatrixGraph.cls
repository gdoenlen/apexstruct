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
 * An implementation of the Graph ADT that uses a double[][] to represent the edges
 * Since in apex a List is the same as an Array this implementation differs in that it only
 * stores the weight of the edge and not the whole edge itself.
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
 *      <td>03 JAN 2017</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
global class MatrixGraph extends AbstractGraph {

    /** Double[][] */
    private final List<List<Double>> edges;

    /**
     * Constructs a matrix graph with the given number of vertices and direction
     *
     * @param numV the number of vertices
     * @directed the direction
     */
    global MatrixGraph(final Integer numV, final Boolean directed) {
        super(numV, directed);
        edges = new List<List<Double>>();
        for (Integer i = 0; i < numV; i++) {
            final Double[] arr = new Double[numV];
            edges.add(arr);
        }
    }

    /**
     * Gets the edge at the given vertices
     *
     * @param source the source vertex
     * @param dest the destination vertex
     * @return the edge at the given location or null if there isnt one
     */
    global Edge getEdge(final Integer source, final Integer dest) {
        if (source < 0 || dest < 0) {
            return null;
        }
        if (source > numV - 1 || dest > numV - 1) {
            return null;
        }
        if (edges[source][dest] != null) {
            return new Edge(source, dest, edges[source][dest]);
        }
        return null;
    }

    /**
     * Checks if there is an edge at the given vertices
     *
     * @param source the source vertex
     * @param dest the destination vertex
     */
    global Boolean isEdge(final Integer source, final Integer dest) {
        return getEdge(source, dest) != null;
    }

    /**
     * Inserts an edge into the graph. If the graph is NOT directed it will insert an edge in the opposite direction
     *
     * @param e The edge you want to insert
     * @see Edge
     */
    global void ins(final Edge e) {
        edges[e.getSource()][e.getDest()] = e.getWeight();
        if (!isDirected()) {
            edges[e.getDest()][e.getSource()] = e.getWeight();
        }
    }

    /**
     * Returns an iterator of all edges at the given source vertex
     *
     * @param source the source vertex
     * @return an iterator containing all edges at the source vertex
     */
    global Iterator<Edge> edgeIterator(final Integer source) {
        final List<Edge> lst = new List<Edge>();
        for (Integer i = 0; i < edges[source].size(); i++) {
            lst.add(new Edge(source, i, edges[source][i]));
        }
        return lst.iterator();
    }
}