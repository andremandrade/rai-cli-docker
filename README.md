# RAI CLI Docker image

This image provides an Alpine image with [RAI CLI](https://github.com/RelationalAI/rai-cli) (from [RelationalAI](https://relational.ai/)) installed.

## Usage examples

Show help

```bash
docker run andremeireles/rai-cli 
```

Read only command example

```bash
docker run -v ~/.rai/config:/home/rai/.rai/config andremeireles/rai-cli list-models mydatabase
```

Write command example

```bash
docker run -v $(pwd)/example_model.rel:/home/rai/example_model.rel \
    -v ~/.rai/config:/home/rai/.rai/config andremeireles/rai-cli \
    load-model my-database -e my-engine /home/rai/example_model.rel
```

Query execution example

```bash
docker run -v ~/.rai/config:/home/rai/.rai/config andremeireles/rai-cli \
    exec my-database -e my-engine -c "def output = 1 + 1"
```
