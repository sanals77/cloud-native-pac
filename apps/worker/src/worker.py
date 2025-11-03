import time, os

def process_once():
    print("[worker] processing tick...")

if __name__ == "__main__":
    interval = int(os.getenv("WORKER_INTERVAL", 5))
    while True:
        process_once()
        time.sleep(interval)

