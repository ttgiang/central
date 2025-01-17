package org.bouncycastle.crypto.test;

import org.bouncycastle.util.test.Test;
import org.bouncycastle.util.test.TestResult;

public class RegressionTest
{
    public static Test[]    tests = 
    {
        new AESTest(),
        new AESLightTest(),
        new AESFastTest(),
        new AESWrapTest(),
        new DESTest(),
        new DESedeTest(),
        new ModeTest(),
        new PaddingTest(),
        new DHTest(),
        new ElGamalTest(),
        new DSATest(),
        new ECTest(),
        new GOST3410Test(),
        new ECGOST3410Test(),
        new ECIESTest(),
        new ECNRTest(),
        new MacTest(),
        new GOST28147MacTest(),
        new RC2Test(),
        new RC2WrapTest(),
        new RC4Test(),
        new RC5Test(),
        new RC6Test(),
        new RijndaelTest(),
        new SerpentTest(),
        new CamelliaTest(),
        new CamelliaLightTest(),
        new DigestRandomNumberTest(),
        new SkipjackTest(),
        new BlowfishTest(),
        new TwofishTest(),
        new CAST5Test(),
        new CAST6Test(),
        new GOST28147Test(),
        new IDEATest(),
        new RSATest(),
        new RSABlindedTest(),
        new RSADigestSignerTest(),
        new PSSBlindTest(),
        new ISO9796Test(),
        new ISO9797Alg3MacTest(),
        new MD2DigestTest(),
        new MD4DigestTest(),
        new MD5DigestTest(),
        new SHA1DigestTest(),
        new SHA224DigestTest(),
        new SHA256DigestTest(),
        new SHA384DigestTest(),
        new SHA512DigestTest(),
        new RIPEMD128DigestTest(),
        new RIPEMD160DigestTest(),
        new RIPEMD256DigestTest(),
        new RIPEMD320DigestTest(),
        new TigerDigestTest(),
        new GOST3411DigestTest(),
        new WhirlpoolDigestTest(),
        new MD5HMacTest(),
        new SHA1HMacTest(),
        new SHA224HMacTest(),
        new SHA256HMacTest(),
        new SHA384HMacTest(),
        new SHA512HMacTest(),
        new RIPEMD128HMacTest(),
        new RIPEMD160HMacTest(),
        new OAEPTest(),
        new PSSTest(),
        new CTSTest(),
        new CCMTest(),
        new PKCS5Test(),
        new PKCS12Test(),
        new KDF1GeneratorTest(),
        new KDF2GeneratorTest(),
        new MGF1GeneratorTest(),
        new DHKEKGeneratorTest(),
        new ECDHKEKGeneratorTest(),
        new ShortenedDigestTest(),
        new EqualsHashCodeTest(),
        new TEATest(),
        new XTEATest(),
        new RFC3211WrapTest(),
        new SEEDTest(),
        new Salsa20Test(),
        new CMacTest(),
        new EAXTest(),
        new GCMTest(),
        new HCFamilyTest(),
        new HCFamilyVecTest(),
        new ISAACTest(),
        new NoekeonTest(),
        new VMPCKSA3Test(),
        new VMPCMacTest(),
        new VMPCTest(),
        new Grainv1Test(),
        new Grain128Test(),
        //new NaccacheSternTest(),
        new SRP6Test(),
        new NullTest()
    };

    public static void main(
        String[]    args)
    {
        for (int i = 0; i != tests.length; i++)
        {
            TestResult  result = tests[i].perform();
            
            if (result.getException() != null)
            {
                result.getException().printStackTrace();
            }
            
            System.out.println(result);
        }
    }
}
