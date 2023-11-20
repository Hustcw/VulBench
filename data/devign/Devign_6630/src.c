static void perf_lifecycle(void)

{

    Coroutine *coroutine;

    unsigned int i, max;

    double duration;



    max = 1000000;



    g_test_timer_start();

    for (i = 0; i < max; i++) {

        coroutine = qemu_coroutine_create(empty_coroutine);

        qemu_coroutine_enter(coroutine, NULL);

    }

    duration = g_test_timer_elapsed();



    g_test_message("Lifecycle %u iterations: %f s\n", max, duration);

}
