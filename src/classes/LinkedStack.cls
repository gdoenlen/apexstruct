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
 * Stack implementation backed by an SFDC List object.
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
global class LinkedStack extends AbstractStack {

    /** The array of data */
    private List<Object> data;

    /** Maximum size of the stack */
    private Integer capacity;

    /**
     * Constructor. Sets the type of the stack
     *
     * @param t The type of the stack
     */
    global LinkedStack(Type t) {
        super(t);
        data = new List<Object>();
    }

    /**
     * Constructor. Sets the type and the maximum size of the stack
     *
     * @param t The type of the stack
     * @param capacity The maximum size of the stack
     */
    global LinkedStack(Type t, Integer capacity) {
        super(t);
        this.capacity = capacity;
        data = new List<Object>();
    }

    /**
     * Pushes an item on the top of the stack
     *
     * @param o The object to be pushed
     * @return True if the item was succesfully pushed on to the stack, false if it is full.
     */
    global override Boolean push(Object o) {
        super.push(o);
        if(size() == capacity) {
            return false;
        } else {
            data.add(o);
            return true;
        }
    }

    /**
     * Returns the top item from the stack, but does not remove it.
     *
     * @return The top item from the stack or null if the stack is empty.
     */
    global override Object peek() {
        if(isEmpty()) {
            return null;
        } else {
            return data[data.size() - 1];
        }
    }

    /**
     * Returns and removes the top item from the stack
     *
     * @return the top item of the stack or null if it is empty.
     */
    global override Object pop() {
        if(isEmpty()) {
            return null;
        } else {
            return data.remove(data.size() - 1);
        }
    }

    /**
     * Checks if an item is in the stack. O(N) time.
     *
     * @param o The object to be looked for.
     */
    global override Boolean contains(Object o) {
        for(Object obj : data) {
            if(obj == o) {
                return true;
            }
        }
        return false;
    }

    /** Pops all items from the stack. O(N) */
    global override void clear() {
        data = new List<Object>();
    }

    /**
     * Returns the number of elements in the stack
     *
     * @return The number of elements in the stack
     */
    global override Integer size() {
        return data.size();
    }

    /**
     * Gets an iterator for the stack from data.iterator()
     *
     * @return data.iterator()
     */
    global override Iterator<Object> iterator() {
        return data.iterator();
    }
}