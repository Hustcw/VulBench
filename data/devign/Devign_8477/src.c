void qemu_file_skip(QEMUFile *f, int size)

{

    if (f->buf_index + size <= f->buf_size) {

        f->buf_index += size;

    }

}
