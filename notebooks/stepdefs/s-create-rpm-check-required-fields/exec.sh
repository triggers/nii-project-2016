
(
    cd .jobs
    taskpat='# Task: *'

    # First, filter down the jobs to only look at ones that
    # have expected output from rpmlint in the output
    # with -l, grep will output lines like: "j-1042/output"
    jobs="$(grep -l "1 specfiles checked" */output | cut -d / -f 1)"

    # Next, check each jobs and eliminate those that are for other
    # tasks.  Unfortunately, the my-script cells do not give enough
    # information to tell, so keep all my-script cells.
    taskjobs="$(
        for j in $jobs; do
            input="$(cat "$j/input")"
            [[ "$input" == $taskpat ]] && \
                [[ "$input" != *create-rpm-check-required-fields* ]] && continue
            echo "$j"
    done)"

    # Finally, check that the input contains "rpmlint"
    diditjobs="$(
        for j in $taskjobs; do
            input="$(cat "$j/input")"
            [[ "$input" == *rpmlint* ]] && echo "$j"
    done)"

    [ "$diditjobs" != "" ]
    check_message $? "Check using rpmlint was performed"
)

# Note: a current limitation of this check is that once a matching job
# appears in the job list, the second check will always pass, even if
# the instance is destroyed.
