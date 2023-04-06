typedef struct cache_blk_t_struct
{
    bool valid;            // true if cache block contains valid data
    bool dirty;            // true if cache block has been modified
    unsigned long long tag;  // cache block tag
    unsigned long long stamp; // cache block timestamp for LRU replacement
    char *data;            // cache block data
} cache_blk_t;

typedef struct {
    // Cache organization
    int nsets;              // number of sets
    int nways;              // number of ways per set
    int ncolumns;           // number of columns
    int blocksize;          // block size in bytes
    int log_blocksize;      // log2 of block size
    int set_shift;          // shift for set index
    int set_mask;           // mask for set index
    int tag_shift;          // shift for tag
    cache_blk_t **sets;     // cache sets
} cache_t;

int main(int argc, char *argv[]) {

    cache_t *icache;

    // Initialize the instruction cache
    cache_t *icache = cache_create(8192, 1, 16, 16);

    // Simulation loop
    for (int i = 0; i < num_inst; i++) {
        md_inst_t inst = fetch_inst(addr);
        cache_blk_t *blk = cache_access(icache, addr);
        if (!blk->valid || blk->tag != (addr >> icache->tag_shift)) {
            icache_misses++;
        }
        blk->valid = true;
        blk->tag = addr >> icache->tag_shift;
        blk->stamp = sim_cycle;
        addr += sizeof(md_inst_t);
    }

    // Calculate the miss rate
    double icache_mr = (double)icache_misses / (double)num_inst;
    printf("Instruction cache miss rate = %.2f%%\n", icache_mr * 100.0);
    return 0;
}

// Allocate and initialize the cache structure
cache_t *cache_create(int nsets, int nways, int ncolumns, int blocksize)
{
    cache_t *cp = (cache_t *)calloc(1, sizeof(cache_t));
    assert(cp);
    cp->nsets = nsets;
    cp->nways = nways;
    cp->ncolumns = ncolumns;
    cp->blocksize = blocksize;
    cp->log_blocksize = log2(blocksize);
    cp->set_shift = cp->log_blocksize + log2(nways) + log2(ncolumns);
    cp->set_mask = nsets - 1;
    cp->tag_shift = cp->set_shift + log2(nsets);
    cp->sets = (cache_blk_t **)calloc(nsets * ncolumns, sizeof(cache_blk_t *));
    assert(cp->sets);
    for (int i = 0; i < nsets * ncolumns; i++) {
        cp->sets[i] = (cache_blk_t *)calloc(nways, sizeof(cache_blk_t));
        assert(cp->sets[i]);
        for (int j = 0; j < nways; j++) {
            cp->sets[i][j].tag = 0;
            cp->sets[i][j].valid = false;
            cp->sets[i][j].dirty = false;
        }
    }
    return cp;
}


// Access the cache and return the matching block
cache_blk_t *cache_access(cache_t *cp, md_addr_t addr)
{
    int column = (addr >> cp->set_shift) % cp->ncolumns;
    int set = (addr >> cp->set_shift) & cp->set_mask;
    int tag = addr >> cp->tag_shift;
    cache_blk_t *blk = NULL;
    for (int i = 0; i < cp->nways; i++) {
        cache_blk_t *setblk = &cp->sets[set * cp->ncolumns + column][i];
        if (setblk->valid && setblk->tag == tag) {
            // Hit: return the matching block
            blk = setblk;
            break;
        } else if (!blk || setblk->stamp < blk->stamp) {
            // Miss: update the victim block
            blk = setblk;
        }
    }
    if (blk->valid && blk->tag != tag) {
        // Evict the victim block and update the tag
        blk->tag = tag;
        blk->stamp = sim_cycle;
    }
    return blk;
}