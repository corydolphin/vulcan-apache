dnl ## XXX - Need a more thorough check of the proper flags to use

APACHE_SUBST(MOD_MPM_EVENT_LDADD)

APACHE_MPM_MODULE(event, $enable_mpm_event, event.lo fdqueue.lo pod.lo,[
    AC_CHECK_FUNCS(pthread_kill)
], , [\$(MOD_MPM_EVENT_LDADD)])
