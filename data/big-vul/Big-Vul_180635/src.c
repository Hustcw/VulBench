static int swevent_hlist_get_cpu(struct perf_event *event, int cpu)
{
	struct swevent_htable *swhash = &per_cpu(swevent_htable, cpu);
 	int err = 0;
 
 	mutex_lock(&swhash->hlist_mutex);
 	if (!swevent_hlist_deref(swhash) && cpu_online(cpu)) {
 		struct swevent_hlist *hlist;
 
		hlist = kzalloc(sizeof(*hlist), GFP_KERNEL);
		if (!hlist) {
			err = -ENOMEM;
			goto exit;
		}
		rcu_assign_pointer(swhash->swevent_hlist, hlist);
	}
	swhash->hlist_refcount++;
exit:
	mutex_unlock(&swhash->hlist_mutex);

	return err;
}
