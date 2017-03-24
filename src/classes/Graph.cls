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
 * Interface to specify a Graph ADT. A graph is a set of vertices and a set of edges.
 * Vertices are represented by integers from 0 to n - 1.
 * Edges are ordered pairs of vertices. Each implementation of the Graph interface
 * should provide a constructor that specifies the number of vertices and
 * whether or not the graph is directed.
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
global interface Graph  {

    /**
     * Gets the number of vertices in the graph.
     *
     * @return the number of vertices
     */
    Integer getNumV();

    /**
     * Determines if the graph is directed
     *
     * @return true if this is a directed graph
     */
    Boolean isDirected();

    /**
     * Insert a new edge into the graph
     *
     * @param e the edge to insert
     */
    void ins(Edge e);

    /**
     * Determine whether an edge exists.
     *
     * @param source the source vertex
     * @param dest the destination vertex
     * @return true if there is an edge from source to dest
     */
     Boolean isEdge(Integer source, Integer dest);

    /**
     * Gets the edge between the two vertices
     *
     * @param source the source vertex
     * @param dest the destination vertex
     * @return an edge between the two vertices, or null if the edge is not found
     */
    Edge getEdge(Integer source, Integer dest);

    /**
     * Gets an iterator for all edges that start at the source vertex
     *
     * @param the source vertex
     * @return an iterator that contains all of the edges that start at the source
     */
    Iterator<Edge> edgeIterator(Integer source);

}