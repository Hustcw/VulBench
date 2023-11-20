int blk_init_allocated_queue(struct request_queue *q)
{
	WARN_ON_ONCE(q->mq_ops);

	q->fq = blk_alloc_flush_queue(q, NUMA_NO_NODE, q->cmd_size);
	if (!q->fq)
		return -ENOMEM;

	if (q->init_rq_fn && q->init_rq_fn(q, q->fq->flush_rq, GFP_KERNEL))
		goto out_free_flush_queue;

	if (blk_init_rl(&q->root_rl, q, GFP_KERNEL))
		goto out_exit_flush_rq;

	INIT_WORK(&q->timeout_work, blk_timeout_work);
	q->queue_flags		|= QUEUE_FLAG_DEFAULT;

	/*
	 * This also sets hw/phys segments, boundary and size
	 */
	blk_queue_make_request(q, blk_queue_bio);

	q->sg_reserved_size = INT_MAX;

	if (elevator_init(q))
		goto out_exit_flush_rq;
	return 0;

out_exit_flush_rq:
	if (q->exit_rq_fn)
 		q->exit_rq_fn(q, q->fq->flush_rq);
 out_free_flush_queue:
 	blk_free_flush_queue(q->fq);
 	return -ENOMEM;
 }
