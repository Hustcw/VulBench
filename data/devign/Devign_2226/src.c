static void s390_msi_ctrl_write(void *opaque, hwaddr addr, uint64_t data,

                                unsigned int size)

{

    S390PCIBusDevice *pbdev;

    uint32_t io_int_word;

    uint32_t fid = data >> ZPCI_MSI_VEC_BITS;

    uint32_t vec = data & ZPCI_MSI_VEC_MASK;

    uint64_t ind_bit;

    uint32_t sum_bit;

    uint32_t e = 0;



    DPRINTF("write_msix data 0x%" PRIx64 " fid %d vec 0x%x\n", data, fid, vec);



    pbdev = s390_pci_find_dev_by_fid(fid);

    if (!pbdev) {

        e |= (vec << ERR_EVENT_MVN_OFFSET);

        s390_pci_generate_error_event(ERR_EVENT_NOMSI, 0, fid, addr, e);

        return;

    }



    if (pbdev->state != ZPCI_FS_ENABLED) {

        return;

    }



    ind_bit = pbdev->routes.adapter.ind_offset;

    sum_bit = pbdev->routes.adapter.summary_offset;



    set_ind_atomic(pbdev->routes.adapter.ind_addr + (ind_bit + vec) / 8,

                   0x80 >> ((ind_bit + vec) % 8));

    if (!set_ind_atomic(pbdev->routes.adapter.summary_addr + sum_bit / 8,

                                       0x80 >> (sum_bit % 8))) {

        io_int_word = (pbdev->isc << 27) | IO_INT_WORD_AI;

        s390_io_interrupt(0, 0, 0, io_int_word);

    }

}
