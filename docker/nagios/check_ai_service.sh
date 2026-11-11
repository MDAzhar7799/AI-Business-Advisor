#!/bin/bash
# ==============================================================================
# Nagios Custom Plugin: check_ai_service.sh
# Methodology: Tool 2. Nagios — Monitoring
# Author: MD AZHAR
# Description: Checks AI Business Recommendation service availability,
#              evaluates response time, and returns Nagios status codes:
#              0 = OK, 1 = WARNING, 2 = CRITICAL, 3 = UNKNOWN
# ==============================================================================

HOST="${1:-localhost}"
PORT="${2:-5000}"
ENDPOINT="http://${HOST}:${PORT}/health"

START_TIME=$(date +%s%N)
HTTP_RESPONSE=$(curl -s -o /tmp/ai_health_resp.txt -w "%{http_code}" --max-time 5 "${ENDPOINT}" 2>/dev/null)
END_TIME=$(date +%s%N)
DURATION_MS=$(( (END_TIME - START_TIME) / 1000000 ))

if [ -z "$HTTP_RESPONSE" ] || [ "$HTTP_RESPONSE" -eq 000 ]; then
    echo "CRITICAL - AI Recommendation Service is DOWN (Port ${PORT} unreachable) | response_time=0ms"
    exit 2
fi

if [ "$HTTP_RESPONSE" -ge 200 ] && [ "$HTTP_RESPONSE" -lt 300 ]; then
    if [ "$DURATION_MS" -gt 3000 ]; then
        echo "WARNING - AI Recommendation Service slow response (${DURATION_MS}ms) | response_time=${DURATION_MS}ms"
        exit 1
    else
        echo "OK - AI Recommendation Service healthy (HTTP ${HTTP_RESPONSE}, ${DURATION_MS}ms) | response_time=${DURATION_MS}ms"
        exit 0
    fi
elif [ "$HTTP_RESPONSE" -ge 500 ]; then
    echo "CRITICAL - AI Recommendation Service returned server error (HTTP ${HTTP_RESPONSE}) | response_time=${DURATION_MS}ms"
    exit 2
else
    echo "WARNING - AI Recommendation Service unexpected status (HTTP ${HTTP_RESPONSE}) | response_time=${DURATION_MS}ms"
    exit 1
fi

