static void omap_i2c_set_slave_addr(OMAPI2C *s, uint8_t addr)

{

    uint16_t data = addr;



    memwrite(s->addr + OMAP_I2C_SA, &data, 2);

    memread(s->addr + OMAP_I2C_SA, &data, 2);

    g_assert_cmphex(data, ==, addr);

}
