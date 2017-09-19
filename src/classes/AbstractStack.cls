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
 * Abstract Stack
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
global abstract class AbstractStack extends AbstractCollection implements Stack {

    /**
     * Constructor. Calls super.
     *
     * @param t The type of object this collection will hold.
     */
    protected AbstractStack(final Type t) {
        super(t);
    }

    /**
     * Pushes the object on to the top of the stack. First checks if the object is the same type
     *
     * @param o The object to push
     * @return true if the operation succeeds
     */
    global virtual Boolean push(final Object o) {
        super.add(o);
        return true;
    }


    /**
     * Peeks at the top item of the stack, but does not remove it.
     *
     * @return The item at the top of the stack.
     */
    global abstract Object peek();

    /**
     * Pops the top item off of the stack. Removes it from the stack.
     *
     * @return the top item of the stack
     */
    global abstract Object pop();

    /**
     * Implementing to satisfy the interface.
     *
     * @return false
     * @throws UnsupportedOperationException
     */
    global override Boolean remove(final Object o) {
        throw new UnsupportedOperationException();
        return false;
    }
}