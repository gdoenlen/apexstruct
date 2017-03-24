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
 * Test for the LinkedStack class
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
@isTest
global class LinkedStackTest {

    /**
     * Tests the push functionality of the stack
     * Asserts: You can push an item on the stack
     * Asserts: If you are capacity you can NOT push an item onto the stack
     *
     * @see LinkedStack.push
     */
    static testMethod void push() {
        Stack s = new LinkedStack(Integer.class);
        System.assert(s.push(12));
        //0 capacity stack, won't be able to push
        s = new LinkedStack(Integer.class, 0);
        System.assert(!s.push(12));
    }

    /**
     * Test the pop functionality of the stack
     * Asserts: the last item you pushed onto the stack will be the item you pop off
     * Asserts: poping from an empty stack returns null
     *
     * @see LinkedStack.pop
     */
    static testMethod void pop() {
        Stack s = new LinkedStack(Account.class);
        Account a;
        for(Integer i = 0; i < 10; i++) {
            a = new Account();
            a.Name = 'Test' + i;
            s.push(a);
        }
        a = new Account();
        a.Name = 'Test';
        s.push(a);
        Account b = (Account)s.pop();
        System.assertEquals('Test', b.Name);
        s.clear();
        System.assertEquals(null, s.pop());
    }

    /**
     * Tests the peek functionality of the stack
     * Asserts: the last item you pushed onto the stack will be the item you peek
     * Asserts: peeking from an empty stack will give you null
     *
     * @see LinkedStack.peek
     */
    static testMethod void peek() {
        Stack s = new LinkedStack(Decimal.class);
        for(Integer i = 0; i < 10; i++) {
            s.push(2.9);
        }
        s.push(45.0);
        System.assertEquals(45.0, s.peek());
        s.clear();
        System.assertEquals(null, s.peek());
    }

    /**
     * Test for the contains method
     * Asserts: after pushing an item onto the stack you can check if it is there
     *
     * @see LinkedStack.contains
     */
    static testMethod void contains() {
        Stack s = new LinkedStack(Datetime.class);
        DateTime t = DateTime.now();
        for(Integer i = 0; i < 10; i++) {
            s.push(DateTime.now());
        }
        s.push(t);
        System.assert(s.contains(t));
    }

    /**
     * Tests the iterator
     * Asserts: all of the objects are returned
     *
     * @see LinkedStack.iterator
     * @see LinkedStackIterator
     */
    static testMethod void it() {
        Stack s = new LinkedStack(Integer.class);
        for(Integer i = 0; i < 100; i++) {
            s.push(i);
        }
        Integer count = 0;
        Iterator<Object> it = s.iterator();
        while(it.hasNext()) {
            Integer i = (Integer)it.next();
            count++;
        }
        System.assertEquals(100, count);
    }

    //BELOW TESTS ALL METHODS INHERITTED FROM ABSTRACTSTACK

    /**
     * Test the remove function of AbstractStack.
     * Asserts: UnsupportedOperationException
     *
     * @see AbstractStack.remove
     */
    static testMethod void remove() {
        Stack s = new LinkedStack(Date.class);
        Date d = Date.today();
        s.push(d);
        try {
            s.remove(d);
        } catch(UnsupportedOperationException ex) {
            System.assert(true);
        }
    }

    //BELOW TESTS ALL METHODS INHERITTED FROM ABSTRACTCOLLECTION

    /**
     * Tests that the type correctly validates
     * Asserts: IllegalArgumentException is thrown if the wrong type is added
     *
     * @see AbstractCollection.validateType
     * @see IllegalArgumentException
     */
    static testMethod void validateType() {
        Stack s = new LinkedStack(Integer.class);
        try {
            s.push('String');
        } catch(IllegalArgumentException ex) {
            System.assert(true);
        }
        try {
            s.push(12);
        } catch(IllegalArgumentException ex) {
            //this should never happen with the correct type
            System.assert(false);
        }
    }

    /**
     * Tests the addAll functionality.
     * Asserts: the items were added to the stack
     *
     * @see AbstractCollection.addAll
     */
    static testMethod void addAll() {
        Stack s = new LinkedStack(Integer.class);
        Stack b = new LinkedStack(Integer.class);

        for(Integer i = 0; i < 100; i++) {
            b.push(i);
        }
        System.assert(s.addAll(b));
    }

    /**
     * Tests the containsAll method
     * Asserts: containsAll returns true when all items in b are present in s
     * Asserts: containsAll returns false when an item in b is not present in s
     */
    static testMethod void containsAll() {
        Stack s = new LinkedStack(Integer.class);
        Stack b = new LinkedStack(Integer.class);

        for(Integer i = 0; i < 100; i++) {
            s.push(i);
            b.push(i);
        }
        System.assert(s.containsAll(b));
        for(Integer i = 100; i >= 50; i--) {
            b.pop();
        }
        System.assert(s.containsAll(b));
        b.push(455);
        System.assert(!s.containsAll(b));
    }
}