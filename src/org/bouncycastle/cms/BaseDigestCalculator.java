package org.bouncycastle.cms;

import org.bouncycastle.util.Arrays;

class BaseDigestCalculator
    implements DigestCalculator
{
    private final byte[] digest;

    BaseDigestCalculator(byte[] digest)
    {
        this.digest = digest;
    }

    public byte[] getDigest()
    {
        return Arrays.clone(digest);
    }
}
