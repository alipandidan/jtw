# Java Threads Watcher
Detect CPU hungry threads in a Java application

## How it works
JTW starts by generating a thread dump (stack trace) of main thread, seperating child threads that utilize more than 25% of CPU and looks them up in thread dump to see what they actually are. Eventually you'll end up with a list of CPU intesive threads.
