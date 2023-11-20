long Block::Frame::Read(IMkvReader* pReader, unsigned char* buf) const
{
    assert(pReader);
    assert(buf);
    const long status = pReader->Read(pos, len, buf);
    return status;
}
