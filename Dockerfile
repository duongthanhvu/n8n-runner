FROM ghcr.io/n8n-io/runners:2.30.3

USER root

WORKDIR /opt/runners/task-runner-javascript

# 1. Copy our dedicated patch script into the container
COPY patch.js ./

# 2. The New Order of Operations:
# Step A: Add the package but explicitly tell pnpm NOT to run scripts yet (this prevents the crash)
RUN pnpm add @actual-app/api --ignore-scripts && \
    # Step B: Now that pnpm is done modifying package.json, run our script to inject the whitelist
    node patch.js && \
    # Step C: Manually trigger the build step for whitelisted dependencies
    pnpm rebuild && \
    # Step D: Clean up
    rm patch.js

USER runner
