import time, os, sys

print("[worker] starting up...", flush=True)

interval = int(os.getenv("WORKER_INTERVAL", 5))

while True:
    print("[worker] processing tick...", flush=True)
    sys.stdout.flush()
    time.sleep(interval)

