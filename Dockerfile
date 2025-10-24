# Start from the official vLLM image
FROM vllm/vllm-openai:latest

# Set the default working directory
WORKDIR /app

# Define environment variables with default values (can be overridden in K8s)
ENV MODEL_NAME=mistralai/Mistral-7B-Instruct-v0.2
ENV GPU_MEMORY_UTILIZATION=0.90
ENV MAX_MODEL_LENGTH=16384

# The ENTRYPOINT command that starts the vLLM server
# This command uses the specified model and sets host to 0.0.0.0 for access within the container network.
# --dtype auto allows vLLM to use BF16 or FP16 based on the model and VRAM (Crucial for performance!)
ENTRYPOINT ["python", "-m", "vllm.entrypoints.openai.api_server", \
            "--model", "${MODEL_NAME}", \
            "--gpu-memory-utilization", "${GPU_MEMORY_UTILIZATION}", \
            "--max-model-len", "${MAX_MODEL_LENGTH}", \
            "--host", "0.0.0.0", \
            "--port", "8000", \
            "--dtype", "auto"]
