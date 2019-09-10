# Candy functions that extend build/envsetup.sh

function candy_device_combos()
{
    local T list_file variant device

    T="$(gettop)"
    list_file="${T}/vendor/candy/candy.devices"
    variant="userdebug"

    if [[ $1 ]]
    then
        if [[ $2 ]]
        then
            list_file="$1"
            variant="$2"
        else
            if [[ ${VARIANT_CHOICES[@]} =~ (^| )$1($| ) ]]
            then
                variant="$1"
            else
                list_file="$1"
            fi
        fi
    fi

    if [[ ! -f "${list_file}" ]]
    then
        echo "unable to find device list: ${list_file}"
        list_file="${T}/vendor/candy/candy.devices"
        echo "defaulting device list file to: ${list_file}"
    fi

    while IFS= read -r device
    do
        add_lunch_combo "candy_${device}-${variant}"
    done < "${list_file}"
}

function candy_rename_function()
{
    eval "original_candy_$(declare -f ${1})"
}

function _candy_build_hmm() #hidden
{
    printf "%-8s %s" "${1}:" "${2}"
}

function candy_append_hmm()
{
    HMM_DESCRIPTIVE=("${HMM_DESCRIPTIVE[@]}" "$(_candy_build_hmm "$1" "$2")")
}

function candy_add_hmm_entry()
{
    for c in ${!HMM_DESCRIPTIVE[*]}
    do
        if [[ "${1}" == $(echo "${HMM_DESCRIPTIVE[$c]}" | cut -f1 -d":") ]]
        then
            HMM_DESCRIPTIVE[${c}]="$(_candy_build_hmm "$1" "$2")"
            return
        fi
    done
    candy_append_hmm "$1" "$2"
}

function candyremote()
{
    local proj pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
        return
    fi
    git remote rm candy 2> /dev/null

    proj="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"

#    if (echo "$proj" | egrep -q 'external|system|build|bionic|art|libcore|prebuilt|dalvik') ; then
#        pfx="android_"
#    fi

    project="${proj//\//_}"

    git remote add candy "git@github.com:CandyRoms/$pfx$project"
    echo "Remote 'candy' created"
}

function anyremote()
{
# usage: anyremote <github org> <alias>
# example: anyremote candyroms candy
    local proj pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
        return
    fi
    git remote rm $2 2> /dev/null

    proj="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"
    pfx=""
    project="${proj//\//_}"
    git remote add $2 "https://github.com/$1/$project"
    echo "Remote '$2' for '$1/$project' created, now fetching..."
    git fetch $2

}

function aospremote()
{
    local pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
        return
    fi
    git remote rm aosp 2> /dev/null

    project="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"
    if [[ "$project" != device* ]]
    then
        pfx="platform/"
    fi
    git remote add aosp "https://android.googlesource.com/$pfx$project"
    echo "Remote 'aosp' created"
}

function cafremote()
{
    local pfx project

    if ! git rev-parse &> /dev/null
    then
        echo "Not in a git directory. Please run this from an Android repository you wish to set up."
    fi
    git remote rm caf 2> /dev/null

    project="$(pwd -P | sed "s#$ANDROID_BUILD_TOP/##g")"
    if [[ "$project" != device* ]]
    then
        pfx="platform/"
    fi
    git remote add caf "git://codeaurora.org/$pfx$project"
    echo "Remote 'caf' created"
}

function losremote()
{
    git remote rm los 2> /dev/null
    if [ ! -d .git ]
    then
        echo .git directory not found. Please run this from the root directory of the Android repository you wish to set up.
    fi
    PROJECT=`pwd -P | sed s#$ANDROID_BUILD_TOP/##g`
    PFX="android_$(echo $PROJECT | sed 's/\//_/g')"
    git remote add los git@github.com:LineageOS/$PFX
    echo "Remote 'los' created"
}

function candygerrit()
{
    git remote rm candygerrit 2> /dev/null
    if [ ! -d .git ]
    then
        echo .git directory not found. Please run this from the root directory of the Android repository you wish to set up.
    fi
    GERRIT_REMOTE=$(cat .git/config  | grep git://github.com | awk '{ print $NF }' | sed s#git://github.com/##g)
    if [ -z "$GERRIT_REMOTE" ]
    then
        echo Unable to set up the git remote, are you in the root of the repo?
        return 0
    fi
    CRUSER=`git config --get gerrit.bbqdroid.org.username`
    if [ -z "$CRUSER" ]
    then
        git remote add candygerrit ssh://gerrit.bbqdroid.org:29418/$GERRIT_REMOTE
    else
        git remote add candygerrit ssh://$CRUSER@gerrit.bbqdroid.org:29418/$GERRIT_REMOTE
    fi
    echo You can now push to "candygerrit".
 }

function candygit()
{
    git remote rm candy 2> /dev/null
    if [ ! -d .git ]
    then
        echo .git directory not found. Please run this from the root directory of the Android repository you wish to set up.
    fi
    PROJECT=`pwd -P | sed s#$ANDROID_BUILD_TOP/##g`
    PFX="$(echo $PROJECT | sed 's/\//_/g')"
    git remote add candy git@github.com:CandyRoms/$PFX
    echo "Remote 'candy' created"
}

function candy_push()
{
    local branch ssh_name path_opt proj
    branch="c10"
    ssh_name="candy_review"
    path_opt=

    if [[ "$1" ]]
    then
        proj="$ANDROID_BUILD_TOP/$(echo "$1" | sed "s#$ANDROID_BUILD_TOP/##g")"
        path_opt="--git-dir=$(printf "%q/.git" "${proj}")"
}

function fixup_common_out_dir() {
    common_out_dir=$(get_build_var OUT_DIR)/target/common
    target_device=$(get_build_var TARGET_DEVICE)
    common_target_out=common-${target_device}
    if [ ! -z $CANDY_FIXUP_COMMON_OUT ]; then
        if [ -d ${common_out_dir} ] && [ ! -L ${common_out_dir} ]; then
            mv ${common_out_dir} ${common_out_dir}-${target_device}
            ln -s ${common_target_out} ${common_out_dir}
        else
            [ -L ${common_out_dir} ] && rm ${common_out_dir}
            mkdir -p ${common_out_dir}-${target_device}
            ln -s ${common_target_out} ${common_out_dir}
        fi
    else
        proj="$(pwd -P)"
    fi
    proj="$(echo "$proj" | sed "s#$ANDROID_BUILD_TOP/##g")"
    proj="$(echo "$proj" | sed 's#/$##')"
    proj="${proj//\//_}"

#    if (echo "$proj" | egrep -q 'external|system|build|bionic|art|libcore|prebuilt|dalvik') ; then
#        proj="android_$proj"
#    fi

    git $path_opt push "ssh://${ssh_name}/CandyRoms/$proj" "HEAD:refs/for/$branch"
}


candy_rename_function hmm
function hmm() #hidden
{
    local i T
    T="$(gettop)"
    original_candy_hmm
    echo

    echo "vendor/candy extended functions. The complete list is:"
    for i in $(grep -P '^function .*$' "$T/vendor/candy/build/envsetup.sh" | grep -v "#hidden" | sed 's/function \([a-z_]*\).*/\1/' | sort | uniq); do
        echo "$i"
    done |column
}

candy_append_hmm "candyremote" "Add a git remote for matching CandyRoms repository"
candy_append_hmm "anyremote" "Add a git remote for ANY github repository"
candy_append_hmm "aospremote" "Add git remote for matching AOSP repository"
candy_append_hmm "cafremote" "Add git remote for matching CodeAurora repository."
