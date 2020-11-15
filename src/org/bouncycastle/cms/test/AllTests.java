package org.bouncycastle.cms.test;

import junit.framework.Test;
import junit.framework.TestSuite;

import javax.crypto.Cipher;

public class AllTests 
{
    public static void main (String[] args) 
        throws Exception
    {
        junit.textui.TestRunner.run(suite());
    }
    
    public static Test suite() 
        throws Exception
    {   
        TestSuite suite = new TestSuite("CMS tests");
        
        suite.addTest(CompressedDataTest.suite());
        suite.addTest(SignedDataTest.suite());
        suite.addTest(EnvelopedDataTest.suite());

        suite.addTest(CompressedDataStreamTest.suite());
        suite.addTest(SignedDataStreamTest.suite());
        suite.addTest(EnvelopedDataStreamTest.suite());
        suite.addTest(MiscDataStreamTest.suite());
        suite.addTest(Rfc4134Test.suite());

        try
        {
            Cipher.getInstance("RSA", "SunJCE");

            suite.addTest(SunProviderTest.suite());
            suite.addTest(NullProviderTest.suite());
        }
        catch (Exception e)
        {
            // ignore
        }

        return suite;
    }
}
