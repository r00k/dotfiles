#!/bin/bash
# Railway diagnostic script - run to get a quick health check of all services

set -e

echo "=== Railway Diagnostics ==="
echo "Time: $(date)"
echo

echo "--- Project Status ---"
railway status || { echo "Not linked to a Railway project"; exit 1; }
echo

echo "--- Services ---"
services=$(railway status --json 2>/dev/null | python3 -c "
import sys,json
d=json.load(sys.stdin)
edges=d['environments']['edges'][0]['node']['serviceInstances']['edges']
for e in edges:
    svc = e['node'].get('serviceName') or e['node'].get('id')
    print(svc)
" 2>/dev/null)

if [ -z "$services" ]; then
    echo "No services found"
    exit 0
fi

echo "$services"

for svc in $services; do
    # Skip database services
    if echo "$svc" | grep -qiE "postgres|mysql|redis|mongo"; then
        continue
    fi
    
    echo
    echo "========================================"
    echo "Service: $svc"
    echo "========================================"
    
    echo
    echo "--- Recent Deployments ---"
    railway deployment list --service "$svc" 2>/dev/null | head -6
    
    echo
    echo "--- Recent Logs (last 10 lines) ---"
    railway logs --lines 10 --service "$svc" 2>/dev/null || echo "No logs available"
    
    echo
    echo "--- Recent Errors (last hour) ---"
    errors=$(railway logs --lines 200 --since 1h --service "$svc" 2>&1 | grep -iE "(error|exception|traceback|failed|critical)" | grep -v "No logs found" | head -10)
    if [ -z "$errors" ]; then
        echo "No errors"
    else
        echo "$errors"
    fi
done

echo
echo "=== Diagnostics Complete ==="
