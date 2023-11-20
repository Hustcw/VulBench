
struct Buf
{
  unsigned __int16 length;
  unsigned __int16 written;
  char data[8];
};

struct Data
{
  struct device *device;
  __int64 dev;
  int idx;
  char *mem;
  __int64 port;
  char pad[8];
  Buf *buf[16];
  int tail;
  int head;
};

Data* bytedev_arr[256];

void __fastcall bytedev_ioctl(__int64 a1, __int64 command, char *argp)
{
    unsigned int v3;
    unsigned int argp_1;
    Data *v5;
    __int64 v6;
    __int64 port;
    unsigned __int32 mode;

    _fentry__(a1, command);
    argp_1 = v3;
    v5 = *(Data **)(a1 + 200);
    raw_spin_lock(v5->pad);
    if ((_DWORD)command != 0x114514)
    {
        if ((_DWORD)command == 0x1919810)
        {
            port = v5->port;
            mode = __indword(port);
            if (mode == 1)
                __outdword(port + 1, argp_1);
            else
                printk("\x013[bytedev:] device not in blk-mode!");
        }
        else
        {
            printk("\x013[bytedev:] INVALID COMMAND!");
        }
        goto LABEL_8;
    }
    v6 = *(_QWORD *)(__readgsqword((unsigned int)&current_task) + 0x7C0);
    if (!*(_DWORD *)(v6 + 4) && !*(_DWORD *)(v6 + 20))
    {
        __outdword(v5->port, argp_1);
        printk("\x016[bytedev:] device mode changed.");
    LABEL_8:
        raw_spin_unlock(v5->pad);
        return;
    }
    bytedev_ioctl_cold_12();
}

void __fastcall bytedev_read(__int64 a1, char *user_ptr, __int64 len_2)
{
    unsigned __int64 v3;
    unsigned __int64 user_req_len;
    Data *v5;
    char *pad;
    unsigned __int32 v7;
    Data *data_1;
    __int64 tail;
    __int64 round_written;
    Buf *buf;
    __int64 written;
    unsigned __int64 len_to_write;
    char *v14;
    unsigned __int16 v15;
    Data *data;
    __int64 len;
    __int64 port;
    unsigned __int32 v19;
    unsigned __int32 v20;
    char *mem;
    Buf *v22;

    _fentry__(a1, user_ptr);
    user_req_len = v3;
    v5 = *(Data **)(a1 + 200);
    pad = v5->pad;
    raw_spin_lock(v5->pad);
    v7 = __indword(v5->port);
    if (!v7)
    {
        data_1 = *(Data **)(a1 + 200);
        tail = data_1->tail;
        if ((_DWORD)tail != data_1->head)
        {
            round_written = 0LL;
            if (user_req_len)
            {
                while (1)
                {
                    buf = data_1->buf[tail];
                    written = buf->written;
                    len_to_write = buf->length - (unsigned int)written;
                    v14 = &buf->data[written];
                    if (len_to_write > user_req_len)
                        len_to_write = user_req_len;
                    if ((len_to_write & 0x80000000) != 0LL)
                        BUG();
                    v22 = data_1->buf[tail];
                    _check_object_size(&buf->data[written], len_to_write, 1LL);
                    if (copy_to_user(&user_ptr[round_written], v14, len_to_write))
                        break;
                    user_req_len -= len_to_write;
                    round_written += len_to_write;
                    v15 = len_to_write + v22->written;
                    v22->written = v15;
                    if (v15 == v22->length)
                    {
                        if (v15 != 0xFFC)
                            goto LABEL_21;
                        kfree(v22);

                        data_1->tail = (data_1->tail + 1) % 16;
                    }
                    if (user_req_len)
                    {
                        tail = data_1->tail;
                        if ((_DWORD)tail != data_1->head)
                            continue;
                    }
                    goto LABEL_21;
                }
                printk("\x013[bytedev:] failed while reading the buffer!");
            }
        }
        goto LABEL_21;
    }
    if (v7 != 1)
    {
        printk("\x013[bytedev:] invalid mode of devices!");
    LABEL_21:
        raw_spin_unlock(pad);
        return;
    }
    data = *(Data **)(a1 + 200);
    len = 0x200LL;
    if (user_req_len <= 0x200)
        len = user_req_len;
    port = data->port;
    v19 = __indword(port);
    if (v19 == 1)
    {
        v20 = __indword(port + 2);
        if (v20 == 2)
        {
            mem = data->mem;
            _check_object_size(mem, len, 1LL);
            if (copy_to_user(user_ptr, mem, len))
                printk("\x013[bytedev:] failed to read from dev!");
        }
        else
        {
            printk("\x013[bytedev:] device not ready!");
        }
        goto LABEL_21;
    }
    bytedev_read_cold_14();
}

void __fastcall bytedev_write(__int64 a1, char *user_ptr, __int64 user_req_size)
{
    unsigned __int64 v3;
    unsigned __int64 user_req_size_1;
    Data *v5;
    unsigned __int32 mode;
    Data *v7;
    int head;
    int tail;
    int v10;
    __int64 cur_round_written;
    int v12;
    char *target;
    unsigned __int64 remain;
    Buf *v15;
    char *user_ptr_offset;
    __int64 length;
    __int64 v18;
    Buf *v19;
    __int64 len;
    Data *v21;
    __int64 port;
    __int64 v23;
    unsigned __int32 v24;
    unsigned __int32 blk_status;
    char *dest;
    Buf *v27;
    Buf *v28;
    char *v30;
    int v31;
    char *pad;

    _fentry__(a1, user_ptr);
    user_req_size_1 = v3;
    v5 = *(Data **)(a1 + 200);
    pad = v5->pad;
    raw_spin_lock(v5->pad);
    mode = __indword(v5->port);
    if (mode)
    {
        if (mode == 1)
        {
            len = 512LL;
            v21 = *(Data **)(a1 + 200);
            if (user_req_size_1 <= 0x200)
                len = user_req_size_1;
            port = v21->port;
            v23 = len;
            v24 = __indword(port);
            if (v24 == 1)
            {
                blk_status = __indword(port + 2);
                if (blk_status == 2)
                {
                    dest = v21->mem;
                    _check_object_size(dest, len, 0LL);
                    if (copy_from_user(dest, user_ptr, v23))
                        printk("\x013[bytedev:] failed to write on dev!");
                }
                else
                {
                    printk("\x013[bytedev:] device not ready!");
                }
            }
            else
            {
                printk("\x013[bytedev:] invalid operation in non-blk mode!");
            }
        }
        else
        {
            printk("\x013[bytedev:] invalid mode of devices!");
        }
    }
    else
    {
        v7 = *(Data **)(a1 + 200);
        head = v7->head;
        tail = v7->tail;
        v10 = head + 1;
        if ((head + 1) % 16 != tail || (v28 = v7->buf[head]) == 0LL || v28->length <= 0xFFBu)
        {
            cur_round_written = 0LL;
            if (user_req_size_1)
            {
                while (1)
                {
                    if (v10 % 16 == tail)
                    {
                        v27 = v7->buf[head];
                        if (v27)
                        {
                            if (v27->length > 0xFFBu)
                                break;
                        }
                    }
                    v15 = v7->buf[(head + 15) % 16];
                    user_ptr_offset = &user_ptr[cur_round_written];
                    if (v15 && (length = v15->length, (_WORD)length != 0xFFC))
                    {
                        v12 = (unsigned __int16)length;
                        target = &v15->data[length];
                        remain = (unsigned int)(0xFFC - v12);
                        if (remain > user_req_size_1)
                            remain = user_req_size_1;
                        if ((remain & 0x80000000) != 0LL)
                            BUG();
                        v30 = target;
                        _check_object_size(target, remain, 0LL);
                        if (copy_from_user(v30, user_ptr_offset, remain))
                        {
                            printk("\x013[bytedev:] failed while writing the buffer!");
                            break;
                        }
                        v15->length += remain;
                        user_req_size_1 -= remain;
                        cur_round_written += remain;
                    }
                    else
                    {
                        v31 = head;
                        v18 = 0xFFCLL;
                        v19 = (Buf *)kmem_cache_alloc_trace(kmalloc_caches[26], 0x400CC0LL, 0x1000LL);

                        v7->buf[v31] = v19;
                        if (user_req_size_1 <= 0xFFC)
                            v18 = user_req_size_1;
                        v7->head = (v7->head + 1) % 16;
                        *(_DWORD *)&v19->length = 0;
                        _check_object_size(v19->data, v18, 0LL);
                        if (copy_from_user(v19->data, user_ptr_offset, v18))
                        {
                            bytedev_write_cold_15();
                            return;
                        }
                        user_req_size_1 -= v18;
                        v19->length += v18;
                        cur_round_written += v18;
                    }
                    if (!user_req_size_1)
                        break;
                    head = v7->head;
                    tail = v7->tail;
                    v10 = head + 1;
                }
            }
        }
    }
    raw_spin_unlock(pad);
}
