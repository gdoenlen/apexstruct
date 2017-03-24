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
 * An implementation of the Graph ADT that uses an array of lists to represent the edges.
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
global class ListGraph extends AbstractGraph {

    private List<List<Edge>> edges;

    /**
     * Constructs a graph with the given number of vertices and direction
     *
     * @param numV the number of vertices
     * @param directed the direction of the graph
     */
    global ListGraph(Integer numV, Boolean directed) {
        super(numV, directed);
        edges = new List<List<Edge>>();
        for(Integer i = 0; i < numV; i++) {
            edges.add(new List<Edge>());
        }
    }

    /**
     * Checks if the an edge with the given source and destination are in the graph
     *
     * @param source the source vertex
     * @param dest the destination vertex
     * @return true if getEdge returns not null
     * @see getEdge
     */
    global Boolean isEdge(Integer source, Integer dest) {
        return getEdge(source, dest) != null;
    }

    /**
     * Inserts an edge into the graph. If the graph is not directed inserts
     * an additional edge in the opposite direction.
     *
     * @param e the edge you want to insert
     * @see Edge
     */
    global void ins(Edge e) {
        edges[e.getSource()].add(e);
        if(!isDirected()) {
            edges[e.getDest()].add(new Edge(e.getDest(), e.getSource(), e.getWeight()));
        }
    }

    /**
     * Gets an iterator that contains all the edges at the given source
     *
     * @param source the source vertex
     * @return an iterator with all edges that start at source
     */
    global Iterator<Edge> edgeIterator(Integer source) {
        return edges[source].iterator();
    }


    /**
     * Gets the edge that starts at <em>source</em> and ends at <em>dest</em>.
     *
     * @param source the source vertex
     * @param dest the destination vertex
     * @return the edge that begins at source and ends at dest. Null if there is none.
     */
    global Edge getEdge(Integer source, Integer dest) {
        Edge t = new Edge(source, dest);
        Edge[] src = edges[source];
        for(Edge e : src) {
            if(e.equals(t)) {
                return e;
            }
        }
        return null;
    }
}