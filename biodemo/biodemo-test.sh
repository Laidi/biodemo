# 1. Parse command line arguments.
parse_args $@
# 2. Change to test directory
cd $test_data_dir
# 2. Run tests
test_stdout_exit "$test_program one_sequence.fasta" one_sequence.fasta.expected 0
test_stdout_exit "$test_program two_sequence.fasta" two_sequence.fasta.expected 0
test_stdout_exit "$test_program --minlen 200 two_sequence.fasta" \ 
    two_sequence.fasta.minlen_200.expected 0
test_stdout_exit "$test_program --minlen 200 < two_sequence.fasta" \ 
    two_sequence.fasta.minlen_200.stdin.expected 0
test_stdout_exit "$test_program --maxlen 200 < two_sequence.fasta" \
    two_sequence.fasta.maxlen_200.stdin.expected 0
test_stdout_exit "$test_program empty_file" empty_file.expected 0
# Test when --minlen filters out ALL sequences (empty result)
test_stdout_exit "$test_program --minlen 1000 two_sequence.fasta" \
    two_sequence.fasta.minlen_1000.expected 0
# Test exit status for a bad command line invocation
test_exit_status "$test_program --this_is_not_a_valid_argument > /dev/null 2>&1" 2
# Test exit status for a non existent input FASTA file
test_exit_status "$test_program this_file_does_not_exist.fasta > /dev/null 2>&1" 1

