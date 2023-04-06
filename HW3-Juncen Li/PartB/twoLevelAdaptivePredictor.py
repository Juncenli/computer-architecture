# Here's an implementation of a two-level adaptive predictor using a global history register (GHR) of length 4 and a table of 16 2-bit saturating counters:

import gzip

def simulate_two_level_adaptive_predictor(trace):
    # initialize global history register and table of counters
    ghr = [0, 0, 0, 0]
    table = [[2, 2] for _ in range(16)]
    
    # initialize variables to track hits, misses, and correct/incorrect predictions
    buffer_misses = 0
    correct_predictions = 0
    incorrect_predictions = 0
    
    # process each branch in the trace
    for line in trace:
        address, outcome = line.split()
        address = int(address)
        
        # use lower 4 bits of address as index into table
        index = address & 0b1111
        
        # get prediction from table using GHR
        prediction = table[index][ghr[0]*2 + ghr[1]*1]
        
        # update counters based on actual outcome
        if outcome == 'T':
            if prediction < 3:
                table[index][ghr[0]*2 + ghr[1]*1] += 1
            else:
                correct_predictions += 1
        else:
            if prediction > 0:
                table[index][ghr[0]*2 + ghr[1]*1] -= 1
            else:
                correct_predictions += 1
                buffer_misses += 1
        
        # shift GHR and add new outcome
        ghr = ghr[1:] + [int(outcome == 'T')]
        
        # increment counters for correct/incorrect predictions
        if outcome == 'T' and prediction >= 2:
            correct_predictions += 1
        elif outcome == 'N' and prediction < 2:
            correct_predictions += 1
        else:
            incorrect_predictions += 1
    
    return buffer_misses, correct_predictions, incorrect_predictions
    
with gzip.open('itrace.out.gz', 'rt') as f:
    trace = f.readlines()

buffer_misses, correct_predictions, incorrect_predictions = simulate_two_level_adaptive_predictor(trace)

print("Buffer misses: ", buffer_misses)
print("Correct predictions: ", correct_predictions)
print("Incorrect predictions: ", incorrect_predictions)
