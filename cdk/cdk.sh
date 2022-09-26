

# this is a special function that can change the directory of bash given a
# keyword. This allows the user to create a list of keyword/path pairs, and 
# then use those keywords to change the directory rather than typing out the
# complete path
function cdk { 
    #change this to match your keywords file
    keywordFile=~/bashrc_scripts/keywords.txt

    #  sanity check for the number of arguments passed to the script
    if [[ "$#" < "1" || "$#" > "2" ]] ; then
        echo "ckd - change directory by keyword"
        echo "usage:        cdk <keyword>"
        echo "    Changes the shell's working directory based on the keyword"
        echo "Keywords:"

        # Print file      Remove comments and empty lines   Indent
        cat $keywordFile | grep --color=never "^[^#\ ]" | sed 's/^/    /'
        return
    fi

    keyword="$1"

    # Find the line that we want from the keywords file
    line=$(grep -i -E "^[^#]*($keyword)\ .*" $keywordFile)

    # Obtain the path from the keyword file and remove the quotes
    path=$(echo $line | cut -d '"' -f2)

    # Sanity check that the keyword 
    if [[ "$path" == "" ]]; then 
        echo "Keyword \"$keyword\" not found"
    else
        cd "$path"
    fi
}