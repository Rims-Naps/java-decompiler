<div align="center">
	<h1>Java Decompiler</h1>
	<h4 align="center">
		Have your decompilers ready when you need them most.
	</h4>
	<p>Java Decompiler combines the strength of popular Java decompilers, tailored for simplicity and efficiency.</p>
</div>

<p align="center">
	<a href="https://github.com/Rims-Naps/java-decompiler/blob/master/LICENSE"><img alt="License" src="https://img.shields.io/github/license/Rims-Naps/java-decompiler"/></a>&nbsp;
</p>

## 📄&nbsp;Usage

1. **Prepare Directories**:
   - Create a directory `./infiles` for the files you want to decompile.
   - Place any external libraries (in JAR format) into `./libfiles`.
   - Set up an empty directory `./outfiles` for the output.

2. **Run the Docker Image**:

   **For Linux and macOS:**

   ```bash
   docker run \
       -ti \
       --rm \
       -v "$PWD/infiles:/infiles:Z,ro" \
       -v "$PWD/libfiles:/libfiles:Z,ro" \
       -v "$PWD/outfiles:/outfiles:Z,rw" \
       ghcr.io/rims-naps/java-decompiler:latest
   ```

   **For Windows CMD:**

   ```cmd
   docker run ^
       -ti ^
       --rm ^
       -v "%cd%\infiles:/infiles:Z,ro" ^
       -v "%cd%\libfiles:/libfiles:Z,ro" ^
       -v "%cd%\outfiles:/outfiles:Z,rw" ^
       ghcr.io/rims-naps/java-decompiler:latest
   ```

   **For Windows PowerShell:**

   ```powershell
docker run `
    -ti `
    --rm `
    -v "${PWD}\infiles:/infiles:Z,ro" `
    -v "${PWD}\libfiles:/libfiles:Z,ro" `
    -v "${PWD}\outfiles:/outfiles:Z,rw" `
    ghcr.io/rims-naps/java-decompiler:latest
   ```

   For Podman users, replace `docker` with `podman` in the command.

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

## ⚠️&nbsp;Acknowledgements

This project builds upon the work of the original developer, [eikendev](https://github.com/eikendev/java-decompiler), who did the majority of the development. My contribution involved simplifying and optimizing the code to run more efficiently on lower-end hardware, focusing exclusively on JAR files.

For more details on the original tools and decompilation processes, refer to the [original repository](https://github.com/eikendev/java-decompiler).
