# Set the path to the DineroIV executable
DINEROIV=/usr/local/bin/dineroIV

# Set the path to the trace file
TRACE_FILE=trace

# Set the cache size in bytes (4KB for split cache, 8KB for shared cache)
CACHE_SIZE=4096

# Set the block sizes in bytes
BLOCK_SIZES="8 16 32"

# Set the associativities
ASSOCIATIVITIES="1 2 4"

# Set the cache types (i for instruction cache, d for data cache)
CACHE_TYPES="i d"

# Loop through all cache configurations
for cache_type in $CACHE_TYPES; do
  for associativity in $ASSOCIATIVITIES; do
    for block_size in $BLOCK_SIZES; do
      # Calculate the cache size based on the given block size and associativity
      cache_size=$((CACHE_SIZE / associativity / block_size * 1024))

      # Set the configuration options for DineroIV
      if [[ "$cache_type" == "i" ]]; then
        cache_options="-l1-isize $cache_size -l1-ibsize $block_size -l1-iassoc $associativity -informat d"
      else
        cache_options="-l1-dsize $cache_size -l1-dbsize $block_size -l1-dassoc $associativity -informat d"
      fi

      # Run DineroIV with the given cache configuration
      $DINEROIV $cache_options < $TRACE_FILE > results_${cache_type}_${block_size}_${associativity}.txt
    done
  done
done
