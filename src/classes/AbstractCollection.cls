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
 * Abstract implementation of the Collection superinterface.
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
global abstract class AbstractCollection implements Collection {
    /** Type of the collection */
    protected Type t;

    /** Constructor for subclasses. Initializes the Collection type. */
    protected AbstractCollection(Type t) {
        this.t = t;
    }

    /**
     * Returns the number of items in the collection.
     *
     * @return The number of items in the collection.
     */
    global abstract Integer size();

    /**
     * Returns an iterator for this collection
     *
     * @return Iterator for the collection.
     */
    global abstract Iterator<Object> iterator();

    /** 
     * Adds the element to the collection.
     *
     * @param o The object to be added.
     * @return True if the element was successfully added.
     */
    global virtual Boolean add(Object o) {
        return validateType(o);
    }

    /**
     * Validates the type of the given object is equal to the type of the collection.
     *
     * @param o The object to verify.
     */
    protected virtual Boolean validateType(Object o) {
        if(getType(o) != t.getName()) {
            throw new IllegalArgumentException('Object type must be of type: ' + t.getName());
        }
        return true;
    }

    /** Removes all elements from the collection. */
    global abstract void clear();

    /**
     * Returns true if the collection contains the specified element. O(N)
     *
     * @param o The element we are looking for.
     * @return True if the collection contains the specified element.
     */
    global virtual Boolean contains(Object o) {
        Iterator<Object> it = iterator();
        while(it.hasNext()) {
            Object t = it.next();
            if(t == o) {
                return true;
            }
        }
        return false;
    }

    /**
     * Returns an array of the collection.
     * @return Array of the collection.
     */
    global virtual Object[] toArray() {
        Object[] a = new Object[size()];
        Iterator<Object> it = iterator();
        for(Integer i = 0; i < a.size(); i++) {
            a[i] = it.next();
        }
        return a;
    }

    /** 
     * Returns true if the collection contains all elements of the specified collection.
     *
     * @param c Collection of elements we are looking for.
     * @return True if the collection contains all elements from the given collection.
     */
    global virtual Boolean containsAll(Collection c) {
        Iterator<Object> it = c.iterator();
        while(it.hasNext()) {
            if(!contains(it.next())) {
                return false;
            }
        }
        return true;
    }

    /**
     * Returns true if the collection has 0 elements in it.
     *
     * @return True if the collection has 0 elements in it.
     */
    global virtual Boolean isEmpty() {
        return size() == 0;
    }

    /**
     * Removes the specified element from the collection.
     *
     * @param o The element to be removed.
     * @return True if the element was successfully removed.
     */
    global abstract Boolean remove(Object o);

    /**
     * Adds all elements from the specified collection to the collection
     *
     * @param c Collection of objects to be added.
     * @return True if any element has been added to the collection.
     */
    global virtual Boolean addAll(Collection c) {
        Boolean modified = false;
        Iterator<Object> it = c.iterator();
        while(it.hasNext()) {
            if(add(it.next())) {
                modified = true;
            }
        }
        return modified;
    }

    /**
     * Returns the type of the object in String form.
     * Dev note: null will return as an empty string. We also cannot differentiate between
     *           decimals and doubles. We also cannot detect maps or sets.
     *
     * @param o The object who's type we are looking for.
     * @return the type of o in String form.
     */
    protected virtual String getType(Object o) {
        if(o == null)                       return '';
        if(o instanceof SObject)            return ((SObject)o).getSObjectType().getDescribe().getName()+''; 
        if(o instanceof Boolean)            return 'Boolean';
        if(o instanceof Id)                 return 'Id';
        if(o instanceof String)             return 'String';
        if(o instanceof Blob)               return 'Blob';
        if(o instanceof Date)               return 'Date';
        if(o instanceof Datetime)           return 'Datetime';
        if(o instanceof Time)               return 'Time';
        if(o instanceof String)             return 'String';
        if(o instanceof Integer)            return 'Integer';
        if(o instanceof Long)               return 'Long';
        if(o instanceof Decimal)            return 'Decimal';  //we can't distinguish between decimal and double
        if(o instanceof Double)             return 'Double';   //we can't distinguish between decimal and double
        if(o instanceof List<Object>)       return 'List';
        return 'Object';                    //we can't detect maps and sets
    }
}