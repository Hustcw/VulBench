static int announce_self_create(uint8_t *buf, 

				uint8_t *mac_addr)

{

    uint32_t magic = EXPERIMENTAL_MAGIC;

    uint16_t proto = htons(ETH_P_EXPERIMENTAL);



    /* FIXME: should we send a different packet (arp/rarp/ping)? */



    memset(buf, 0, 64);

    memset(buf, 0xff, 6);         /* h_dst */

    memcpy(buf + 6, mac_addr, 6); /* h_src */

    memcpy(buf + 12, &proto, 2);  /* h_proto */

    memcpy(buf + 14, &magic, 4);  /* magic */



    return 64; /* len */

}
