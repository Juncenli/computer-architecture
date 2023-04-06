# Set the path to the DineroIV executable
DINEROIV=/usr/local/bin/dineroIV

# Set the path to the trace file
TRACE_FILE=trace

# Set the policy types
#-lN-Tfetch C      Fetch policy
#                   (d=demand, a=always, m=miss, t=tagged,
#                    l=load forward, s=subblock) (default d)
POLICY_TYPES="d a m t l s"

CACHE_TYPES="i d"

# Loop through all cache configurations
for policy_type in $POLICY_TYPES; do
    for cache_type in $CACHE_TYPES; do
        if [[ "$cache_type" == "i" ]]; then
            cache_options="-l1-ifetch $policy_type -l1-isize 8K -l1-ibsize 32 -l1-dsize 16K -l1-dbsize 16 -informat d"
        else
            cache_options="-l1-dfetch $policy_type -l1-isize 8K -l1-ibsize 32 -l1-dsize 16K -l1-dbsize 16 -informat d"
        fi
        # Run DineroIV with the given cache configuration
        $DINEROIV $cache_options < $TRACE_FILE > results_cache_type_${cache_type}_policy_type_${policy_type}.txt
    done
done
