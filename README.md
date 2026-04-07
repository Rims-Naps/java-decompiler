<div align="center">

  <h1>Java Decompiler</h1>
  <h4 align="center">
    Have your decompilers ready when you need them most.
  </h4>
  <p>Java Decompiler combines the strength of popular Java decompilers, tailored for simplicity and efficiency.</p>
</div>

<p align="center">
  <a href="https://github.com/Rims-Naps/java-decompiler/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/github/license/Rims-Naps/java-decompiler"/></a>
</p>

## 📄 Usage

1. **Prepare Directories**:
   - Create a directory `./infiles` for the files you want to decompile.
   - Place any external libraries (in JAR format) into `./libfiles`.
   - Set up an empty directory `./outfiles` for the output.

2. **Run the Docker Image**:

```
docker run -v "$PWD/infiles:/infiles" -v "$PWD/libfiles:/libfiles" -v "$PWD/outfiles:/outfiles" ghcr.io/rims-naps/java-decompiler:latest
```

  Parallel decompilation is enabled by default. You can tune it with environment variables:

  - `MAX_DECOMPILER_JOBS`: maximum concurrent decompiler jobs (default: `2`)
  - `JAVA_XMX`: heap size per Java decompiler process (default: `2G`)
  - `FORMAT_MAX_PROCS`: max formatter workers for `astyle` (default: `8`)

  Example with custom concurrency:

  ```
  docker run \
    -e MAX_DECOMPILER_JOBS=3 \
    -e JAVA_XMX=1G \
    -e FORMAT_MAX_PROCS=6 \
    -v "$PWD/infiles:/infiles" \
    -v "$PWD/libfiles:/libfiles" \
    -v "$PWD/outfiles:/outfiles" \
    ghcr.io/rims-naps/java-decompiler:latest
  ```

   For Podman users, replace `docker` with `podman` in the command.

3. **Build & Run Locally (Windows 11)**:

   If you want to rebuild the container from source and run it locally:

   **Docker:**
   ```cmd
   docker build -t local/java-decompiler .
  docker run -ti --rm -e MAX_DECOMPILER_JOBS=3 -e JAVA_XMX=1G -v "%cd%/infiles:/infiles" -v "%cd%/libfiles:/libfiles" -v "%cd%/outfiles:/outfiles" local/java-decompiler
   ```

   **Podman:**
   ```cmd
   podman build -t local/java-decompiler .
  podman run -ti --rm -e MAX_DECOMPILER_JOBS=3 -e JAVA_XMX=1G -v "%cd%/infiles:/infiles" -v "%cd%/libfiles:/libfiles" -v "%cd%/outfiles:/outfiles" local/java-decompiler
   ```

## ⚙️ Concurrency Notes

- Total memory usage grows with `MAX_DECOMPILER_JOBS * JAVA_XMX`.
- If the container is memory constrained, reduce either `MAX_DECOMPILER_JOBS` or `JAVA_XMX`.
- Job failures are tracked per decompiler run. The container exits with a non-zero code if any decompiler job fails.
- Per-job logs are written under `./outfiles` as `log-<decompiler>-<jar>.txt`.

## 💡&nbsp;Background

This Docker image is equipped with the following Java decompilers:
- [CFR](https://www.benf.org/other/cfr/)
- [Vineflower](https://github.com/Vineflower/vineflower)
- [Procyon](https://github.com/mstrobel/procyon)

**Note:** This version no longer supports APK decompilation. The focus is now solely on JAR files. The following tools have been removed:
- Fernflower
- Krakatau
- jadx
- Enjarify

The replaced tool is [Vineflower](https://github.com/Vineflower/vineflower) instead of Fernflower.

## ⚠️ Acknowledgements

This project builds upon the work of the original developer, [eikendev](https://github.com/eikendev/java-decompiler), who did the majority of the development. My contribution involved simplifying and optimizing the code to run more efficiently on lower-end hardware, focusing exclusively on JAR files.

For more details on the original tools and decompilation processes, refer to the [original repository](https://github.com/eikendev/java-decompiler).
