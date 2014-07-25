worker_processes 1
preload_app true
listen "127.0.0.1:7654", :tcp_nopush => true
timeout 30
