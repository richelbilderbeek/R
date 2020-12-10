
path_to_add <- "/home/richel/R/i686-pc-linux-gnu-library/3.1"
path_to_add <- "/home/p230198/.rkward/library"

print(.libPaths())

lib_paths_before <- length(.libPaths())

# Only adds folder if it exists
.libPaths(c(.libPaths(),path_to_add))

lib_paths_after <- length(.libPaths())

if (lib_paths_before < lib_paths_after)
{
  print(paste("Successfully added ",path_to_add," to paths",sep=""))
} else {
  print(paste("Failed to add ",path_to_add," to paths",sep=""))
}
