package com.test.aseutil;

import junit.framework.Test;
import junit.framework.TestSuite;

/**
 * @author <b>TT Giang</b>
 * @author Applied Software Engineering.
 */

public class AllTests {

    public static Test suite() {

        TestSuite suite = new TestSuite("CC Tests");

        suite.addTestSuite(ApproverDBTest.class);

        return suite;
    }

    public static void main(String[] args) {
        junit.textui.TestRunner.run(suite());
    }
}