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
 * Priority queue implemented with a heap via an sfdc list
 * https://en.wikipedia.org/wiki/Heap_%28data_structure%29
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
 *      <td>01 DEC 2016</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
global class PriorityQueue extends AbstractQueue {

    /** The backing list that is used for the data */
    private final List<Object> data;

    /** The comparator used to compare the objects */
    private final Comparator comp;

    /** The maximum number of elements the queue can hold */
    private final Integer capacity;

    /**
     * Constructor. Initializes the comparator used and the type of objects held.
     *
     * @param comp The comparator used to compare the objects
     * @param t the type of objects held by the collection
     * @see Comparator
     */
    global PriorityQueue(final Comparator comp, final Type t) {
        super(t);
        this.comp = comp;
        data = new List<Object>();
    }

    /**
     * Construcotr initializes the comparator used, the types of objects held, and the max elements in the queue.
     *
     * @param comp The comparator used to compare the objects
     * @param t The type of objects held in the collection
     * @param capacity
     * @see Comparator
     */
    global PriorityQueue(final Comparator comp, final Type t, final Integer capacity) {
        this(comp, t);
        this.capacity = capacity;
    }

    /** Returns the number of elements in the queue */
    global override Integer size() {
        return data.size();
    }

    /**
     * Returns, but does not remove the first item from the queue
     *
     * @return the top item from the queue
     */
    global override Object peek() {
        return data[0];
    }

    /**
     * Returns AND removes the first item from the queue. It will then reheap the heap
     *
     * @return the top item from the queue.
     */
    global override Object poll() {
        if (isEmpty()) {
            return null;
        }

        final Object result = data[0];

        //only one element in the queue, safe to just remove the first item
        if (data.size() == 1) {
            data.remove(0);
            return result;
        }

        data.set(0, data.remove(data.size() - 1));
        Integer parent = 0;
        while (true) {
            final Integer leftChild = 2 * parent + 1;
            if (leftChild >= data.size()) {
                break;
            }
            final Integer rightChild = leftChild + 1;

            //assumes the left child is smaller
            Integer minChild = leftChild;
            //now actually check if the which is smallest
            if (rightChild < data.size() && comp.compare(data[leftChild], data[rightChild]) > 0) {
                minChild = rightChild;
            }
            //move the smaller child up the heap
            if (comp.compare(data[parent], data[minChild]) > 0) {
                swap(parent, minChild);
                parent = minChild;
            } else {
                break;
            }
        }
        return result;
    }

    /**
     * Adds an item to the queue, then reheaps the queue so it is in the correct order
     *
     * @param o the object to add
     */
    global override Boolean offer(final Object o) {
        super.add(o);
        data.add(o);

        //location of child
        Integer child = size() - 1;
        //location of parent element
        Integer parent = (child - 1) / 2;

        //reheap the queue
        while (parent >= 0 && comp.compare(data[parent], data[child]) > 0) {
            swap(parent, child);
            child = parent;
            parent = (child - 1) / 2;
        }
        return true;
    }

    /**
     * Swaps the data are the given indices
     *
     * @param left The left index
     * @param right the right index
     */
    private void swap(final Integer left, final Integer right) {
        final Object t = data[left];
        data[left] = data[right];
        data[right] = t;
    }

    /**
     * Adds an item to the collection, simply calls offer
     *
     * @param o the object to add to the collection
     * @see add
     */
    global override Boolean add(final Object o) {
        return offer(o);
    }

    /** Returns an iterator for the queue */
    global override Iterator<Object> iterator() {
        return data.iterator();
    }
}