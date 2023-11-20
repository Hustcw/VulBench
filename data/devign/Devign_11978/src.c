static uint64_t qemu_rdma_poll(RDMAContext *rdma, uint64_t *wr_id_out,

                               uint32_t *byte_len)

{

    int ret;

    struct ibv_wc wc;

    uint64_t wr_id;



    ret = ibv_poll_cq(rdma->cq, 1, &wc);



    if (!ret) {

        *wr_id_out = RDMA_WRID_NONE;

        return 0;

    }



    if (ret < 0) {

        fprintf(stderr, "ibv_poll_cq return %d!\n", ret);

        return ret;

    }



    wr_id = wc.wr_id & RDMA_WRID_TYPE_MASK;



    if (wc.status != IBV_WC_SUCCESS) {

        fprintf(stderr, "ibv_poll_cq wc.status=%d %s!\n",

                        wc.status, ibv_wc_status_str(wc.status));

        fprintf(stderr, "ibv_poll_cq wrid=%s!\n", wrid_desc[wr_id]);



        return -1;

    }



    if (rdma->control_ready_expected &&

        (wr_id >= RDMA_WRID_RECV_CONTROL)) {

        DDDPRINTF("completion %s #%" PRId64 " received (%" PRId64 ")"

                  " left %d\n", wrid_desc[RDMA_WRID_RECV_CONTROL],

                  wr_id - RDMA_WRID_RECV_CONTROL, wr_id, rdma->nb_sent);

        rdma->control_ready_expected = 0;

    }



    if (wr_id == RDMA_WRID_RDMA_WRITE) {

        uint64_t chunk =

            (wc.wr_id & RDMA_WRID_CHUNK_MASK) >> RDMA_WRID_CHUNK_SHIFT;

        uint64_t index =

            (wc.wr_id & RDMA_WRID_BLOCK_MASK) >> RDMA_WRID_BLOCK_SHIFT;

        RDMALocalBlock *block = &(rdma->local_ram_blocks.block[index]);



        DDDPRINTF("completions %s (%" PRId64 ") left %d, "

                 "block %" PRIu64 ", chunk: %" PRIu64 " %p %p\n",

                 print_wrid(wr_id), wr_id, rdma->nb_sent, index, chunk,

                 block->local_host_addr, (void *)block->remote_host_addr);



        clear_bit(chunk, block->transit_bitmap);



        if (rdma->nb_sent > 0) {

            rdma->nb_sent--;

        }



        if (!rdma->pin_all) {

            /*

             * FYI: If one wanted to signal a specific chunk to be unregistered

             * using LRU or workload-specific information, this is the function

             * you would call to do so. That chunk would then get asynchronously

             * unregistered later.

             */

#ifdef RDMA_UNREGISTRATION_EXAMPLE

            qemu_rdma_signal_unregister(rdma, index, chunk, wc.wr_id);

#endif

        }

    } else {

        DDDPRINTF("other completion %s (%" PRId64 ") received left %d\n",

            print_wrid(wr_id), wr_id, rdma->nb_sent);

    }



    *wr_id_out = wc.wr_id;

    if (byte_len) {

        *byte_len = wc.byte_len;

    }



    return  0;

}
