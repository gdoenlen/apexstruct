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
 * Collection superinterface
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
 *      <td>29 JUN 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table> 
 */
global interface Collection {
    
    /** 
     * Adds the element to the collection.
     *
     * @param o The object to be added.
     * @return True if the element was successfully added.
     */
    Boolean add(Object o);

    /**
     * Adds all of the elements in the specified collection to this collection.
     *
     * @param c Collection to be added.
     * @return True if the operation was successful.
     */
    Boolean addAll(Collection c);

    /** Removes all elements from the collection. */
    void clear();

    /**
     * Returns true if the collection contains the specified element.
     * For Force.com Primitives.
     *
     * @param o The element we are looking for.
     * @return True if the collection contains the specified element.
     */
    Boolean contains(Object o);

    /**
     * Returns true if the collection contains all elements of the specified collection.
     *
     * @param c Collection of elements we are looking for.
     * @return True if the collection contains all elements from the given collection.
     */
    Boolean containsAll(Collection c);

    /**
     * Returns true if the collection has 0 elements in it.
     *
     * @return True if the collection has 0 elements in it.
     */
    Boolean isEmpty();

    /**
     * Removes the specified element from the collection.
     *
     * @param o The element to be removed.
     * @return True if the element was successfully removed.
     */
    Boolean remove(Object o);

    /**
     * Gets an iterator for the collection.
     *
     * @return Iterator for the collection.
     */
    Iterator<Object> iterator();

    /**
     * Gets the number of element in the collection
     *
     * @return the number of elements in the collection
     */
    Integer size();
}