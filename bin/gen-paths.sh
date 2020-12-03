#!/bin/bash

function generate {
    LVL=$1

    echo "# Developer's Learning Path - Roadmap - Level: $LVL"
    IFS=$'\n'
    SEC=""
    for LINE in $(grep -r 'Roadmap:'$LVL docs | sort | sed 's/ `Roadmap:.*//' | sed 's/md:/md§/' | tr '§' '\n'); do
        if [ "${LINE:0:2}" = "- " ]; then
            echo $LINE
        elif [ "$LINE" != "$SEC" ]; then
            echo -e "\n## $LINE\n" | sed 's/docs\/\(.*\)\/\(.*\)\.md/\1 - \2/' | tr '[a-z]' '[A-Z]'
            SEC=$LINE
        fi
    done
}

generate "Entry" > roadmap/ENTRY.md
generate "Intermediate" > roadmap/INTERMEDIATE.md
generate "Advanced" > roadmap/ADVANCED.md