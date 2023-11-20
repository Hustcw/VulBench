static int multipath_ioctl(struct dm_target *ti, unsigned int cmd,
			   unsigned long arg)
{
	struct multipath *m = (struct multipath *) ti->private;
	struct block_device *bdev = NULL;
	fmode_t mode = 0;
	unsigned long flags;
	int r = 0;

	spin_lock_irqsave(&m->lock, flags);

	if (!m->current_pgpath)
		__choose_pgpath(m, 0);

	if (m->current_pgpath) {
		bdev = m->current_pgpath->path.dev->bdev;
		mode = m->current_pgpath->path.dev->mode;
	}

	if (m->queue_io)
		r = -EAGAIN;
	else if (!bdev)
		r = -EIO;
 
 	spin_unlock_irqrestore(&m->lock, flags);
 
 	return r ? : __blkdev_driver_ioctl(bdev, mode, cmd, arg);
 }
