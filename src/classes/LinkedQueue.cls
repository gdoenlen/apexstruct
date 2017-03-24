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
 * Queue implementation backed by an SFDC List object.
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
global class LinkedQueue extends AbstractQueue {

    /** SFDC List that backs the queue */
    private List<Object> data = new List<Object>();
    /** Maximum size of the queue. */
    private Integer capacity;


    /**
     * Constructor. Sets the type of the queue.
     *
     * @param t The type of the collection.
     */
    global LinkedQueue(Type t) {
        super(t);
        data = new List<Object>();
    }

    /**
     * Constructor. Sets the type and the maximum capacity of the queue.
     *
     * @param t The type of the collection.
     * @param capacity The maximum size of the collection.
     */
    global LinkedQueue(Type t, Integer capacity) {
        super(t);
        this.capacity = capacity;
    }

    /**
     * Adds the element to the queue if there is room.
     *
     * @param o The element to be added.
     * @return True if the element was sucessfully added to the queue.
     */
    global override Boolean offer(Object o) {
        super.offer(o);
        if(size() == capacity) {
            return false;
        } else {
            data.add(o);
            return true;
        }
    }

    /**
     * Returns the number of elements in the queue.
     *
     * @return The number of elements in the queue.
     */
    global override Integer size() {
        return data.size();
    }

    /**
     * Retrieves and removes the head of the queue, or returns null if it is empty.
     *
     * @return Head of the queue/
     */
    global override Object poll() {
        if(isEmpty()) {
            return null;
        } else {
            return data.remove(0);
        }
    }

    /**
     * Retrieves, but does not remove the head of the queue or returns null if it is empty.
     *
     * @return the head of the queue.
     */
    global override Object peek() {
        if(isEmpty()) {
            return null;
        } else {
            return data[0];
        }
    }

    /**
     * Returns a new Iterator for this queue.
     *
     * @return Iterator for the queue
     * @see Iterator
     */
    global override Iterator<Object> iterator() {
        return data.iterator();
    }
}