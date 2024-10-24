FROM ubuntu

SHELL ["/bin/bash", "-c"]

# Install prerequisite packages.
RUN set -euxo pipefail; \
    apt-get -y update; \
    apt-get -y dist-upgrade; \
    apt-get -y install \
      python3 \
      python3-venv; \
    apt-get clean && rm -rf /var/lib/apt/lists/*; \
    mkdir /workspace; \
    chown ubuntu:ubuntu /workspace

USER ubuntu

# Create Python venv environment, and install prerequisite Python packages.
RUN set -euxo pipefail; \
    python3 -m venv --system-site-packages "$HOME/.local"; \
    . "$HOME/.local/bin/activate"; \
    python3 -m pip install -U pip; \
    python3 -m pip install -U \
      jsonschema \
      types-jsonschema

COPY parse.py /workspace

ENTRYPOINT ["python3", "/workspace/parse.py"]
