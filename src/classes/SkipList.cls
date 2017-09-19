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
 * A Skip List is an alternative to a binary tree that provides for
 * approximately logorithmic searching, insertion, and deletion.
 * Skip Lists were developed by William Pugh and first described in
 * "Skip Lists: A Probabilistic Alternative to Balanced Treees",
 * CACM 13:8 (June 1990) pp 668-676
 *
 * Adapted from KW Data Structures Chapter 9 Section 6
 *
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
global class SkipList extends AbstractCollection implements SearchTree {

    /** Comparator used to compare the objects in the list */
    private final Comparator comp;

    /** the number of items in the list */
    private Integer size = 0;

    /** maximum number of link levels in each skiplist node */
    private Integer maxLevel = 2;

    /** maximum number of elements for the current level */
    private Integer maxCap = computeMaxCap(maxLevel);

    /** the natural log of 2 */
    private static final Double LOG2 = Math.log(2.0);

    /** The head of a skiplist is a dummy node. It contains no data. */
    private SkipList.Node head = new SkipList.Node(maxLevel, null);

    /**
     * Method to compute the maximum capacity, given the maximum
     * level. It computes Math.pow(2, maxLevel) - 1, using shift.
     *
     * @return Math.pow(2, maxLevel) - 1;
     */
    private static Integer computeMaxCap(final Integer maxLevel) {
        return ~(~0 << maxLevel);
    }

    /**
     * Constructor. Sets the type of objects stored and the comparator used to compare the objects
     *
     * @param t the type of objects in the collection
     * @param c the comparator used to compare the objects
     */
    global SkipList(final Type t, final Comparator c) {
        super(t);
        this.comp = c;
    }

    /**
     * Method to generate a lograthmic distributed integer between
     * 1 and maxLevel.  I.E. half of the values returned are 1, 1/4
     * are 2, 1/8 3, 1/16 4, etc.
     * @return a random lograthmic distributed int between 1 and maxLevel
     */
    private Integer logRandom() {
        final Integer r = Randomizer.getInt(maxCap);
        Integer k = (Integer) (Math.log(r + 1) / LOG2);
        if (k > maxLevel - 1) {
            k = maxLevel - 1;
        }
        return maxLevel - k;
    }

    /**
     * Searchs for an object in the list
     *
     * @param o The object you're looking for
     * @return Array of skiplist nodes that preceed the sought for item at each level
     */
    private SkipList.Node[] search(final Object o) {
        final SkipList.Node[] pred = new SkipList.Node[maxLevel];
        SkipList.Node current = head;
        for (Integer i = current.links.size() - 1; i >= 0; i--) {
            while (current.links[i] != null && comp.compare(current.links[i].data, o) < 0) {
                current = current.links[i];
            }
            pred[i] = current;
        }
        return pred;
    }

    /**
     * Adds an object to the list.
     *
     * @param o The object you want to add to the list
     * @return true if the object was added, false if it already exists.
     */
    global override Boolean add(final Object o) {
        System.debug('adding: ' + o);
        SkipList.Node[] pred = search(o);
        if (pred[0].links[0] != null && comp.compare(pred[0].links[0].data, o) == 0) {
            return false;
        } else {
            size++;
            final Integer logRandom = logRandom();
            System.debug('logRandom: ' + logRandom);
            final SkipList.Node newNode = new SkipList.Node(logRandom, o);
            for (Integer i = pred.size() - 1; i >= 0; i--) {
                newNode.links[i] = pred[i].links[i];
                pred[i].links[i] = newNode;
            }

            if (size > maxCap) {
                maxLevel++;
                maxCap = computeMaxCap(maxLevel);

                //simulates Arrays.copyOf
                final SkipList.Node[] h = new SkipList.Node[maxLevel];
                for (Integer i = 0; i < head.links.size(); i++) {
                    h[i] = head.links[i];
                }
                head.links = h;
                SkipList.Node[] p = new SkipList.Node[maxLevel];
                for (Integer i = 0; i < pred.size(); i++) {
                    p[i] = pred[i];
                }
                pred = p;
                pred[maxLevel - 1] = head;
            }
            return true;
        }
    }

    /**
     * Finds the object in the list. If found returns the target data or null if not found
     *
     * @param o the data you are looking for.
     * @return null if the list does not contain the data.
     */
    global Object find(final Object o) {
        final SkipList.Node[] pred = search(o);
        if (pred[0].links[0] != null && comp.compare(pred[0].links[0].data, o) == 0) {
            return pred[0].links[0].data;
        }
        return null;
    }

    /**
     * Checks if an object is stored in the list.
     *
     * @param o The object you're looking for
     * @return true if found, false otherwise
     * @see find
     */
    global override Boolean contains(final Object o) {
        return find(o) != null;
    }

    /**
     * Returns the size data field
     *
     * @return the size data field
     */
    global override Integer size() {
        return size;
    }

    /** Clears all data from the list and reset's it as if it was just instantiated */
    global override void clear() {
        maxLevel = 2;
        size = 0;
        maxCap = computeMaxCap(maxLevel);
        head = new SkipList.Node(maxLevel, null);
    }

    /**
     * Removes an object from the list
     *
     * @param o the object to remove
     * @return the data value of the node containing the object or null if it's not found
     * @see KW Data Structrues p. 530-531
     */
    global Object del(final Object o) {
        final SkipList.Node[] pred = search(o);
        if (pred[0].links[0] != null && comp.compare(pred[0].links[0].data, o) == 0) {
            final Object val = pred[0].links[0].data;
            for (Integer i = pred.size() - 1; i >= 0; i--) {
                pred[i].links[i] = pred[0].links[0].links[i];
            }
            return val;
        }
        //not found return null;
        return null;
    }

    /**
     * Removes an object from the list
     *
     * @param o the object to be removed
     * @return true if the object was successfully removed
     * @see del
     */
    global override Boolean remove(final Object o) {
        return del(o) != null;
    }

    global override Iterator<Object> iterator() {
        return new SkipListIterator(this);
    }

    /* Results in O(2N) if you loop through all */
    //todo properly loop through the skiplist array links
    //todo track the size of the initial skiplist so we know if its edited throughout the iteration
    //the current implementation will only iterate through the objects that are in the list at time of instantiation
    /**
     * Iterator for a skiplist. Copies all elements of the skiplist into an array then uses the array to iterate
     */
    global class SkipListIterator implements Iterator<Object> {

        private final Object[] arr;

        private Integer pos = 0;

        global SkipListIterator(final SkipList sl) {
            arr = new Object[sl.size()];
            toArray(sl.head);
        }

        /**
         * Recursive function to add all list elements to the local array
         * Loops adds all data from each SkipList node in the localnodes links
         *
         * @param localRoot the local node
         */
        private void toArray(final SkipList.Node localNode) {
            if (localNode == null) {
                return;
            }
            if (localNode.data != null) {
                arr.add(localNode.data);
            }
            for (Integer i = 0; i < localNode.links.size(); i++) {
                toArray(localNode.links[i]);
            }
        }

        global Boolean hasNext() {
            return pos < arr.size();
        }

        global Object next() {
            return arr[pos++];
        }
    }

    /**
     * SkipList Node. Used to Link the data
     */
    private class Node {
        public Node[] links;
        public Object data;

        public Node(Integer n, Object data) {
            links = new Node[n];
            this.data = data;
        }
    }
}