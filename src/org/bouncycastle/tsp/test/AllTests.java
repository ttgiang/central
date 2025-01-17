package org.bouncycastle.tsp.test;

import java.security.Security;

import org.bouncycastle.jce.provider.BouncyCastleProvider;

import junit.framework.Test;
import junit.framework.TestCase;
import junit.framework.TestSuite;

public class AllTests
    extends TestCase
{
    public static void main (String[] args)
    {
        junit.textui.TestRunner.run(suite());
    }
    
    public static Test suite()
    {
        Security.addProvider(new BouncyCastleProvider());
        
        TestSuite suite = new TestSuite("TSP Tests");
        
        suite.addTestSuite(ParseTest.class);
        suite.addTestSuite(TSPTest.class);
        
        return suite;
    }
}
