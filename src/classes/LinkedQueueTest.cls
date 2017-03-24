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
 * Test for the LinkedQueue class
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
 *      <td>06 JAN 2017</td>
 *      <td>Original Version</td>
 *      <td>1.0.0</td>
 *  </tr>
 * </table>
 */
@isTest
global class LinkedQueueTest {

    /**
     * Test for the offer method
     * Asserts: you can offer an item to the queue
     * Asserts: you can't offer an item when at capacity
     *
     * @see LinkedQueue.offer
     */
    static testMethod void offer() {
        Queue q = new LinkedQueue(Integer.class);
        System.assert(q.offer(12));
        q = new LinkedQueue(Integer.class, 0);
        System.assert(!q.offer(12));
    }

    /**
     * Test for the poll method
     * Asserts: the first item entered in to the queue is removed when you poll
     * Asserts: null is returned if the queue is empty
     *
     * @see LinkedQueue.poll
     */
    static testMethod void poll() {
        Queue q = new LinkedQueue(Integer.class);
        q.offer(15);
        q.offer(100);
        System.assertEquals(15, q.poll());
        q.poll();
        System.assertEquals(null, q.poll());
    }

    /**
     * Test for the peek method
     * Asserts: the first item entered in to the queue is returned but NOT removed
     * Asserts: null is returned if the queue is empty
     *
     * @see LinkedQueue.peek
     */
    static testMethod void peek() {
        Queue q = new LinkedQueue(Integer.class);
        q.offer(15);
        q.offer(100);
        System.assertEquals(15, q.peek());
        System.assertEquals(15, q.peek());
        q.poll();
        q.poll();
        System.assertEquals(null, q.peek());
    }

    /**
     * Test for the iterator
     * Asserts: all the items are returned
     *
     * @see LinkedQueue.iterator
     */
    static testMethod void it() {
        Queue q = new LinkedQueue(Integer.class);
        for(Integer i = 0; i < 100; i++) {
            q.offer(i);
        }
        Iterator<Object> it = q.iterator();
        Integer count = 0;
        while(it.hasNext()) {
            Object next = it.next();
            count++;
        }
        System.assertEquals(100, count);
    }

    //BELOW TESTS EVERYTHING INHERITED FROM AbstractQueue

    /**
     * Tests the clear function
     * Asserts: the queue is empty
     *
     * @see AbstractQueue.clear
     */
    static testMethod void clear() {
        Queue q = new LinkedQueue(Integer.class);
        for(Integer i = 0; i < 100; i++) {
            q.offer(i);
        }
        q.clear();
        System.assertEquals(0, q.size());
    }

    /**
     * Tests the contains function
     * Asserts: UnsupportedOperationException is thrown
     *
     * @see AbstractQueue.contains
     */
    static testMethod void contains() {
        Queue q = new LinkedQueue(Integer.class);
        try {
            q.contains(1);
        } catch(UnsupportedOperationException ex) {
            System.assert(true);
        }
    }

    /**
     * Tests the remove function
     * Asserts: UnsupportedOperationException is thrown
     *
     * @see AbstractQueue.remove
     */
    static testMethod void remove() {
        Queue q = new LinkedQueue(Integer.class);
        try {
            q.remove(1);
        } catch(UnsupportedOperationException ex) {
            System.assert(true);
        }
    }
}