import gzip

def one_bit_predictor(trace):
    predictor = [0]*64
    correct_predictions = 0
    incorrect_predictions = 0
    buffer_misses = 0
    
    for line in trace:
        addr, outcome = line.split()
        index = int(addr) % 64
        prediction = predictor[index]
        
        if prediction == 0 and outcome == 'N':
            correct_predictions += 1
        elif prediction == 1 and outcome == 'T':
            correct_predictions += 1
        elif prediction == 0 and outcome == 'T':
            incorrect_predictions += 1
            buffer_misses += 1
            predictor[index] = 1
        elif prediction == 1 and outcome == 'N':
            incorrect_predictions += 1
            buffer_misses += 1
            predictor[index] = 0
            
    return correct_predictions, incorrect_predictions, buffer_misses

def two_bit_predictor(trace):
    predictor = [2]*32
    correct_predictions = 0
    incorrect_predictions = 0
    buffer_misses = 0
    
    for line in trace:
        addr, outcome = line.split()
        index = int(addr) % 32
        prediction = predictor[index]
        
        if prediction in (2, 3) and outcome == 'T':
            correct_predictions += 1
            if prediction != 3:
                predictor[index] += 1
        elif prediction in (0, 1) and outcome == 'N':
            correct_predictions += 1
            if prediction != 0:
                predictor[index] -= 1
        elif prediction in (0, 2) and outcome == 'T':
            incorrect_predictions += 1
            buffer_misses += 1
            if prediction != 2:
                predictor[index] += 1
        elif prediction in (1, 3) and outcome == 'N':
            incorrect_predictions += 1
            buffer_misses += 1
            if prediction != 1:
                predictor[index] -= 1
            
    return correct_predictions, incorrect_predictions, buffer_misses

# Load the instruction trace
with gzip.open('itrace.out.gz', 'rt') as f:
    trace = f.readlines()

# Run the one-bit predictor and print results
correct, incorrect, misses = one_bit_predictor(trace)
print("One-bit predictor:")
print(f"Correct predictions: {correct}")
print(f"Incorrect predictions: {incorrect}")
print(f"Buffer misses: {misses}")

# Run the two-bit predictor and print results
correct, incorrect, misses = two_bit_predictor(trace)
print("Two-bit predictor:")
print(f"Correct predictions: {correct}")
print(f"Incorrect predictions: {incorrect}")
print(f"Buffer misses: {misses}")
