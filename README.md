# qetcd - KDB+/Q etcd Client

Simple KDB+/Q client for etcd key-value store.

## Prerequisites

- **etcd**: v3.4

## Quick Start

```bash
# Start etcd cluster
./bin/startcluster.sh

# Load client in q
q etcd.q

# set/get keys/values
.qetcd.set["key"; "value"]
.qetcd.get["key"]
```
