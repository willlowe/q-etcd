#!/usr/bin/env bash

for i in {1..3}; do mkdir -p /tmp/etcd$i/logs/; done
mkdir -p /tmp/etcd_gw/logs/

## for verbosity, you can see each individual cluster written out
etcd --name node1 \
  --listen-client-urls http://localhost:2379 \
  --advertise-client-urls http://localhost:2379 \
  --listen-peer-urls http://localhost:2380 \
  --initial-advertise-peer-urls http://localhost:2380 \
  --initial-cluster node1=http://localhost:2380,node2=http://localhost:2480,node3=http://localhost:2580 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster-state new \
  --data-dir /tmp/etcd1 > /tmp/etcd1/logs/out.log 2>&1 &

etcd --name node2 \
  --listen-client-urls http://localhost:2479 \
  --advertise-client-urls http://localhost:2479 \
  --listen-peer-urls http://localhost:2480 \
  --initial-advertise-peer-urls http://localhost:2480 \
  --initial-cluster node1=http://localhost:2380,node2=http://localhost:2480,node3=http://localhost:2580 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster-state new \
  --data-dir /tmp/etcd2 > /tmp/etcd2/logs/out.log 2>&1 &

etcd --name node3 \
  --listen-client-urls http://localhost:2579 \
  --advertise-client-urls http://localhost:2579 \
  --listen-peer-urls http://localhost:2580 \
  --initial-advertise-peer-urls http://localhost:2580 \
  --initial-cluster node1=http://localhost:2380,node2=http://localhost:2480,node3=http://localhost:2580 \
  --initial-cluster-token etcd-cluster-1 \
  --initial-cluster-state new \
  --data-dir /tmp/etcd3 > /tmp/etcd3/logs/out.log 2>&1 &

etcd gateway start --endpoints=http://localhost:2379,http://localhost:2479,http://localhost:2579 --listen-addr=127.0.0.1:23790 > /tmp/etcd_gw/logs/out.log 2>&1 &

# comment out if not needed - dump the cluster status after starting
export ETCDCTL_ENDPOINTS="http://localhost:23790"
echo "=== Cluster Health ==="
etcdctl endpoint health
echo -e "\n=== Cluster Status ==="
etcdctl endpoint status --write-out=table
echo -e "\n=== Cluster Members ==="
etcdctl member list --write-out=table